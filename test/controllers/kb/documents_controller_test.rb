require "test_helper"

class Kb::DocumentsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @kb_document = kb_documents(:one)
  end

  test "should get index" do
    get kb_documents_url
    assert_response :success
  end

  test "should get new" do
    get new_kb_document_url
    assert_response :success
  end

  test "should create kb_document" do
    assert_difference("Kb::Document.count") do
      post kb_documents_url, params: { kb_document: { name: @kb_document.name, summary: @kb_document.summary, summary_embedding: @kb_document.summary_embedding } }
    end

    assert_redirected_to kb_document_url(Kb::Document.last)
  end

  test "should show kb_document" do
    get kb_document_url(@kb_document)
    assert_response :success
  end

  test "should get edit" do
    get edit_kb_document_url(@kb_document)
    assert_response :success
  end

  test "should update kb_document" do
    patch kb_document_url(@kb_document), params: { kb_document: { name: @kb_document.name, summary: @kb_document.summary, summary_embedding: @kb_document.summary_embedding } }
    assert_redirected_to kb_document_url(@kb_document)
  end

  test "should destroy kb_document" do
    assert_difference("Kb::Document.count", -1) do
      delete kb_document_url(@kb_document)
    end

    assert_redirected_to kb_documents_url
  end
end
