class AddContentNormalizedToNotes < ActiveRecord::Migration[8.0]
  def up
    add_column :notes, :content_normalized, :text
    Note.find_each do |note|
      note.update_columns(
        content_normalized: ActiveSupport::Inflector.transliterate(note.content.to_s).downcase
      )
    end
  end

  def down
    remove_column :notes, :content_normalized
  end
end
