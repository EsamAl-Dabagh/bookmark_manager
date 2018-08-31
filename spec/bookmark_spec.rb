require './lib/bookmark'

describe Bookmark do

  subject(:subject) { described_class.new }

  describe ".all" do
    it "shows all of the bookmarks" do

      Bookmark.add("http://www.makersacademy.com", "Makers")
      Bookmark.add("http://www.google.com", "Google")
      Bookmark.add("http://www.destroyallsoftware.com", "Destroy All Software")
      
      bookmarks = Bookmark.all
      bookmark = bookmarks.first

      expect(bookmark.title).to include("Makers")
      expect(bookmark).to respond_to(:id)
      expect(bookmark.url).to include("http://www.makersacademy.com")
      expect(bookmarks.length).to eq(3)
    end
  end

  describe ".add" do
    it "adds a new bookmark" do
      Bookmark.add("http://www.ebay.co.uk", "Ebay")
      bookmarks = Bookmark.all
      bookmark = bookmarks.first

      expect(bookmark.title).to include("Ebay")
    end

    it "doesn't add an entry if the url supplied is invalid" do
      Bookmark.add("not valid", "the title")
      expect(Bookmark.all).not_to include("not valid")
    end
  end

  describe ".delete" do
    it "removes bookmark from database" do

      connection = PG.connect(dbname: "bookmark_manager_test")
      connection.exec("INSERT INTO bookmarks VALUES(1, 'http://www.makersacademy.com', 'Makers');")
      Bookmark.delete(1)

      expect(Bookmark.all).to eq([])
    end
  end

end
