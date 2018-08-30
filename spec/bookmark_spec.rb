require './lib/bookmark'

describe Bookmark do

  subject(:subject) { described_class.new }

  describe ".all" do
    it "shows all of the bookmarks" do

      Bookmark.add("http://www.makersacademy.com")
      Bookmark.add("http://www.google.com")
      Bookmark.add("http://www.destroyallsoftware.com")
      
      bookmarks = Bookmark.all

      expect(bookmarks).to include("http://www.makersacademy.com")
      expect(bookmarks).to include("http://www.google.com")
      expect(bookmarks).to include("http://www.destroyallsoftware.com")
    end
  end

  describe ".add" do
    it "adds a new bookmark" do
      Bookmark.add("http://www.ebay.co.uk")
      bookmarks = Bookmark.all

      expect(bookmarks).to include("http://www.ebay.co.uk")
    end

    it "doesn't add an entry if the url supplied is invalid" do
      Bookmark.add("not valid")
      expect(Bookmark.all).not_to include("not valid")
    end
  end

end
