require "test_helper"

class NoteTest < ActiveSupport::TestCase
  test "valid note" do
    note = Note.new(content: "Some content", user: users(:alice))
    assert note.valid?
  end

  test "invalid without content" do
    note = Note.new(user: users(:alice))
    assert_not note.valid?
    assert_includes note.errors[:content], "can't be blank"
  end

  test "invalid without user" do
    note = Note.new(content: "Some content")
    assert_not note.valid?
  end

  test "belongs to user" do
    note = notes(:alice_note)
    assert_equal users(:alice), note.user
  end
end
