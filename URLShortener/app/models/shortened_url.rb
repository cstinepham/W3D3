class ShortenedUrl < ApplicationRecord
  validates :short_url, presence: true, uniqueness: true
  validates :long_url, presence: true
  validates :user_id, presence: true

  belongs_to :submitter,
    primary_key: :id,
    foreign_key: :user_id,
    class_name: :User

  has_many :visits,
    primary_key: :id,
    foreign_key: :shortened_url_id,
    class_name: :Visit

  has_many :visitors,
    Proc.new { distinct },
    through: :visits,
    source: :user

  has_many :tag_topics,
    primary_key: :id,
    foreign_key: :url_id,
    class_name: :TagTopic

    def self.random_code
      short_url = SecureRandom::urlsafe_base64(16)
      while self.exists?(short_url)
        short_url = SecureRandom::urlsafe_base64(16)
      end

      short_url
    end

    def self.create_from_user(user, long_url)
      ShortenedUrl.create!( short_url: self.random_code,
                            long_url: long_url,
                            user_id: user.id
                          )
    end

    def num_clicks
      self.visits.count
    end

    def num_uniques
      self.visitors.count
    end

    def num_recent_uniques
      self.visits.select(:user_id).distinct.where(["created_at < ?", Time.now - 10]).count
    end


end
