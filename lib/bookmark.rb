require 'pg'

class Bookmark

  def self.all

    if ENV['ENVIRONMENT'] == 'test'
      connection = PG.connect(dbname: "bookmark_manager_test")
    else
      connection = PG.connect(dbname: "bookmark_manager")
    end

    
    result = connection.exec("SELECT * FROM bookmarks")
    result.map { |bookmark| bookmark["url"] }
  end

  def self.add(new_url)

    if ENV['ENVIRONMENT'] == 'test'
      connection = PG.connect(dbname: "bookmark_manager_test")
    else
      connection = PG.connect(dbname: "bookmark_manager")
    end

    connection.exec("INSERT INTO bookmarks (url) VALUES('#{new_url}');")

  end

end
