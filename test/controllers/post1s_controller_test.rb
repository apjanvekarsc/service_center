require "test_helper"

class Post1sControllerTest < ActionDispatch::IntegrationTest
  setup do
    @post1 = post1s(:one)
  end

  test "should get index" do
    get post1s_url
    assert_response :success
  end

  test "should get new" do
    get new_post1_url
    assert_response :success
  end

  test "should create post1" do
    assert_difference('Post1.count') do
      post post1s_url, params: { post1: { name: @post1.name, role: @post1.role } }
    end

    assert_redirected_to post1_url(Post1.last)
  end

  test "should show post1" do
    get post1_url(@post1)
    assert_response :success
  end

  test "should get edit" do
    get edit_post1_url(@post1)
    assert_response :success
  end

  test "should update post1" do
    patch post1_url(@post1), params: { post1: { name: @post1.name, role: @post1.role } }
    assert_redirected_to post1_url(@post1)
  end

  test "should destroy post1" do
    assert_difference('Post1.count', -1) do
      delete post1_url(@post1)
    end

    assert_redirected_to post1s_url
  end
end
