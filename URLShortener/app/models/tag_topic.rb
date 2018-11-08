class TagTopic < ApplicationRecord
  validates :topic, presence: true
  validates :url_id, presence: true

  belongs_to :url,
    primary_key: :id,
    foreign_key: :url_id,
    class_name: :ShortenedUrl

    def popular_links
      ActiveRecord::Base.connection.execute(<<-SQL, self.topic)
        SELECT
          COUNT(*)
        FROM
          tag_topics
        JOIN
          shortened_urls
        ON
          tag_topics.url_id = shortened_urls.id
        JOIN
          visits
        ON
          visits.shortened_url_id = shortened_urls.id
          /* WHERE
            tag_topics.topic = ?
        GROUP BY
          shortened_urls.short_url
            */

        ORDER BY
          COUNT(*) DESC
        LIMIT 5
      SQL
    end

end
