feature "bookmark list" do
  scenario "can view a list of bookmarks" do
      Bookmark.add("http://www.makersacademy.com", "Makers")
      Bookmark.add("http://www.google.com", "Google")
      Bookmark.add("http://www.destroyallsoftware.com", "Destroy All Software")

    visit '/bookmarks'
    expect(page).to have_link("Makers", href: "http://www.makersacademy.com")
    expect(page).to have_link("Google", href: "http://www.google.com")
    expect(page).to have_link("Destroy All Software", href: "http://www.destroyallsoftware.com")
  end

  scenario "can add new bookmarks" do
    visit '/bookmarks'
    fill_in 'url', with: "http://ebay.co.uk"
    fill_in 'title', with: "Ebay"
    click_button "Add"
    expect(page).to have_content("Ebay")
  end
end

feature "validate submitted url" do
  scenario "checks the inputted url" do
    visit '/bookmarks'
    fill_in 'url', with: "htp://not real"
    fill_in 'title', with: "doesn't work"
    click_button "Add"
    expect(page).not_to have_content("htp://not real")
    expect(page).to have_content("You must submit a valid URL")
  end
end
