require 'pg'

class Bookmark

  attr_reader :title, :url, :id

  def initialize(id, title, url)
    @id = id
    @url = url
    @title = title
  end

  def self.all

    if ENV['ENVIRONMENT'] == 'test'
      connection = PG.connect(dbname: "bookmark_manager_test")
    else
      connection = PG.connect(dbname: "bookmark_manager")
    end

    result = connection.exec("SELECT * FROM bookmarks")
    result.map do |bookmark| 
      Bookmark.new(
        bookmark["id"],
        bookmark["title"],
        bookmark["url"]
      )
    end
  end

  def self.add(new_url, title)

    return false unless is_url?(new_url)

    if ENV['ENVIRONMENT'] == 'test'
      connection = PG.connect(dbname: "bookmark_manager_test")
    else
      connection = PG.connect(dbname: "bookmark_manager")
    end

    result = connection.exec("INSERT INTO bookmarks (url, title) VALUES('#{new_url}','#{title}') RETURNING id, title, url;")
    Bookmark.new(result[0]["id"], result[0]["title"], result[0]["url"])

  end

  private 

  def self.is_url?(new_url)
    new_url =~ /\A#{URI::regexp(['http', 'https'])}\z/
  end

end
