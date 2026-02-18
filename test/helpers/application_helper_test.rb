require "test_helper"

class ApplicationHelperTest < ActionView::TestCase
  test "blank text returns empty string" do
    assert_equal "", markdown("")
    assert_equal "", markdown(nil)
  end

  test "renders bold text" do
    result = markdown("**bold**")
    assert_includes result, "<strong>bold</strong>"
  end

  test "renders heading" do
    result = markdown("# Title")
    assert_includes result, "<h1>Title</h1>"
  end

  test "renders fenced code block" do
    result = markdown("```\ncode here\n```")
    assert_includes result, "<code>"
  end
end
