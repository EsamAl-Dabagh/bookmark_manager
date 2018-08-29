require './lib/bookmark'

describe Bookmark do

  subject(:subject) { described_class.new }

  describe ".all" do
    it "shows all of the bookmarks" do  
      expect(Bookmark.all).to eq(["http://www.makersacademy.com", "http://www.google.com", "http://www.destroyallsoftware.com"])
    end
  end

end
