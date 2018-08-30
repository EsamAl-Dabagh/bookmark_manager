feature "bookmark list" do
  scenario "can view a list of bookmarks" do
    Bookmark.add("http://www.makersacademy.com")
    Bookmark.add("http://www.google.com")
    Bookmark.add("http://www.destroyallsoftware.com")

    visit '/bookmarks'
    expect(page).to have_content("http://www.makersacademy.com")
    expect(page).to have_content("http://www.google.com")
    expect(page).to have_content("http://www.destroyallsoftware.com")
  end

  scenario "can add new bookmarks" do
    visit '/bookmarks'
    fill_in 'url', with: "http://ebay.co.uk"
    click_button "Add"
    expect(page).to have_content("http://ebay.co.uk")
  end
end
