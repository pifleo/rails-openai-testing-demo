require "test_helper"

class Kb::PagesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @kb_page = kb_pages(:one)
  end

  test "should get index" do
    get kb_pages_url
    assert_response :success
  end

  test "should get new" do
    get new_kb_page_url
    assert_response :success
  end

  test "should create kb_page" do
    assert_difference("Kb::Page.count") do
      post kb_pages_url, params: { kb_page: { content: @kb_page.content, document_id: @kb_page.document_id, page_index: @kb_page.page_index } }
    end

    assert_redirected_to kb_page_url(Kb::Page.last)
  end

  test "should show kb_page" do
    get kb_page_url(@kb_page)
    assert_response :success
  end

  test "should get edit" do
    get edit_kb_page_url(@kb_page)
    assert_response :success
  end

  test "should update kb_page" do
    patch kb_page_url(@kb_page), params: { kb_page: { content: @kb_page.content, document_id: @kb_page.document_id, page_index: @kb_page.page_index } }
    assert_redirected_to kb_page_url(@kb_page)
  end

  test "should destroy kb_page" do
    assert_difference("Kb::Page.count", -1) do
      delete kb_page_url(@kb_page)
    end

    assert_redirected_to kb_pages_url
  end
end
