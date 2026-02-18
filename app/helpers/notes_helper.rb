module NotesHelper
  def sort_link(label, column, current_col, current_dir, query)
    is_active = current_col == column
    next_dir = (is_active && current_dir == "asc") ? "desc" : "asc"
    indicator = is_active ? (current_dir == "asc" ? " ↑" : " ↓") : ""
    link_to notes_path(sort: column, dir: next_dir, q: query),
            class: "hover:underline font-bold tracking-tighter" do
      "#{label}#{indicator}".html_safe
    end
  end
end
