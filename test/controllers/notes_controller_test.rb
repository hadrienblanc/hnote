require "test_helper"

class NotesControllerTest < ActionDispatch::IntegrationTest
  # Auth wall — unauthenticated users redirected to sign in
  test "index redirects when not signed in" do
    get notes_path
    assert_redirected_to new_user_session_path
  end

  test "show redirects when not signed in" do
    get note_path(notes(:alice_note))
    assert_redirected_to new_user_session_path
  end

  test "new redirects when not signed in" do
    get new_note_path
    assert_redirected_to new_user_session_path
  end

  # Authenticated CRUD
  test "index shows user notes" do
    sign_in users(:alice)
    get notes_path
    assert_response :success
  end

  test "show renders note" do
    sign_in users(:alice)
    get note_path(notes(:alice_note))
    assert_response :success
  end

  test "new renders form" do
    sign_in users(:alice)
    get new_note_path
    assert_response :success
  end

  test "create creates note and redirects" do
    sign_in users(:alice)
    assert_difference "Note.count", 1 do
      post notes_path, params: { note: { content: "A new note" } }
    end
    assert_redirected_to note_path(Note.last)
  end

  test "create with blank content renders new with error" do
    sign_in users(:alice)
    assert_no_difference "Note.count" do
      post notes_path, params: { note: { content: "" } }
    end
    assert_response :unprocessable_entity
  end

  test "edit renders form" do
    sign_in users(:alice)
    get edit_note_path(notes(:alice_note))
    assert_response :success
  end

  test "update updates note and redirects" do
    sign_in users(:alice)
    patch note_path(notes(:alice_note)), params: { note: { content: "Updated content" } }
    assert_redirected_to note_path(notes(:alice_note))
    assert_equal "Updated content", notes(:alice_note).reload.content
  end

  test "destroy deletes note and redirects" do
    sign_in users(:alice)
    assert_difference "Note.count", -1 do
      delete note_path(notes(:alice_note))
    end
    assert_redirected_to notes_path
  end

  # User isolation — alice cannot access bob's notes (404 response)
  test "show returns 404 for other user's note" do
    sign_in users(:alice)
    get note_path(notes(:bob_note))
    assert_response :not_found
  end

  test "edit returns 404 for other user's note" do
    sign_in users(:alice)
    get edit_note_path(notes(:bob_note))
    assert_response :not_found
  end

  test "update returns 404 for other user's note" do
    sign_in users(:alice)
    patch note_path(notes(:bob_note)), params: { note: { content: "Hacked" } }
    assert_response :not_found
    assert_not_equal "Hacked", notes(:bob_note).reload.content
  end

  test "destroy returns 404 for other user's note" do
    sign_in users(:alice)
    assert_no_difference "Note.count" do
      delete note_path(notes(:bob_note))
    end
    assert_response :not_found
  end
end
