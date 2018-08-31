require 'pg'

class Bookmark

  attr_reader :title, :url, :id

  def initialize(id, title, url)
    @id = id
    @url = url
    @title = title
  end

  def self.all

    connection = connect_to_environment

    result = connection.exec("SELECT * FROM bookmarks")
    result.map do |bookmark| 
      Bookmark.new(bookmark["id"], bookmark["title"], bookmark["url"])
    end
  end

  def self.add(new_url, title)

    return false unless is_url?(new_url)

    connection = connect_to_environment

    result = connection.exec("INSERT INTO bookmarks (url, title) VALUES('#{new_url}','#{title}') RETURNING id, title, url;")
    Bookmark.new(result[0]["id"], result[0]["title"], result[0]["url"])

  end

  def self.delete(id)

    connection = connect_to_environment

    connection.exec("DELETE FROM bookmarks WHERE id = '#{id}';")

  end

  private 

  def self.connect_to_environment

    if ENV['ENVIRONMENT'] == 'test'
      PG.connect(dbname: "bookmark_manager_test")
    else
      PG.connect(dbname: "bookmark_manager")
    end

  end

  def self.is_url?(new_url)
    new_url =~ /\A#{URI::regexp(['http', 'https'])}\z/
  end

  # def self.find_id(title)
  #   connection = connect_to_environment

  #   connection.exec("SELECT id FROM bookmarks WHERE title = '#{title}';")
  # end

end
