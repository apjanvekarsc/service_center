require "application_system_test_case"

class Post1sTest < ApplicationSystemTestCase
  setup do
    @post1 = post1s(:one)
  end

  test "visiting the index" do
    visit post1s_url
    assert_selector "h1", text: "Post1s"
  end

  test "creating a Post1" do
    visit post1s_url
    click_on "New Post1"

    fill_in "Name", with: @post1.name
    fill_in "Role", with: @post1.role
    click_on "Create Post1"

    assert_text "Post1 was successfully created"
    click_on "Back"
  end

  test "updating a Post1" do
    visit post1s_url
    click_on "Edit", match: :first

    fill_in "Name", with: @post1.name
    fill_in "Role", with: @post1.role
    click_on "Update Post1"

    assert_text "Post1 was successfully updated"
    click_on "Back"
  end

  test "destroying a Post1" do
    visit post1s_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Post1 was successfully destroyed"
  end
end
