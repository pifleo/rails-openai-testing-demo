require "application_system_test_case"

class Kb::DocumentsTest < ApplicationSystemTestCase
  setup do
    @kb_document = kb_documents(:one)
  end

  test "visiting the index" do
    visit kb_documents_url
    assert_selector "h1", text: "Documents"
  end

  test "should create document" do
    visit kb_documents_url
    click_on "New document"

    fill_in "Name", with: @kb_document.name
    fill_in "Summary", with: @kb_document.summary
    fill_in "Summary embedding", with: @kb_document.summary_embedding
    click_on "Create Document"

    assert_text "Document was successfully created"
    click_on "Back"
  end

  test "should update Document" do
    visit kb_document_url(@kb_document)
    click_on "Edit this document", match: :first

    fill_in "Name", with: @kb_document.name
    fill_in "Summary", with: @kb_document.summary
    fill_in "Summary embedding", with: @kb_document.summary_embedding
    click_on "Update Document"

    assert_text "Document was successfully updated"
    click_on "Back"
  end

  test "should destroy Document" do
    visit kb_document_url(@kb_document)
    click_on "Destroy this document", match: :first

    assert_text "Document was successfully destroyed"
  end
end
