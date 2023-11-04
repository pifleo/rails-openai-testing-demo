require "application_system_test_case"

class Kb::PagesTest < ApplicationSystemTestCase
  setup do
    @kb_page = kb_pages(:one)
  end

  test "visiting the index" do
    visit kb_pages_url
    assert_selector "h1", text: "Pages"
  end

  test "should create page" do
    visit kb_pages_url
    click_on "New page"

    fill_in "Content", with: @kb_page.content
    fill_in "Document", with: @kb_page.document_id
    fill_in "Page index", with: @kb_page.page_index
    click_on "Create Page"

    assert_text "Page was successfully created"
    click_on "Back"
  end

  test "should update Page" do
    visit kb_page_url(@kb_page)
    click_on "Edit this page", match: :first

    fill_in "Content", with: @kb_page.content
    fill_in "Document", with: @kb_page.document_id
    fill_in "Page index", with: @kb_page.page_index
    click_on "Update Page"

    assert_text "Page was successfully updated"
    click_on "Back"
  end

  test "should destroy Page" do
    visit kb_page_url(@kb_page)
    click_on "Destroy this page", match: :first

    assert_text "Page was successfully destroyed"
  end
end
