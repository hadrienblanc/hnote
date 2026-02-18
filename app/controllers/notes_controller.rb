class NotesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_note, only: [:show, :edit, :update, :destroy]

  SORT_COLUMNS = %w[created_at updated_at].freeze

  def index
    @notes = current_user.notes
    if params[:q].present?
      q = ActiveSupport::Inflector.transliterate(params[:q]).downcase.strip
      phrase = @notes.where("content_normalized LIKE ?", "%#{q}%")
      @notes = if phrase.exists?
        phrase
      else
        words = q.split
        words.reduce(@notes) { |scope, w| scope.where("content_normalized LIKE ?", "%#{w}%") }
      end
    end
    sort_col = SORT_COLUMNS.include?(params[:sort]) ? params[:sort] : "updated_at"
    sort_dir = params[:dir] == "asc" ? "asc" : "desc"
    @notes = @notes.order("#{sort_col} #{sort_dir}")
    @sort_col = sort_col
    @sort_dir = sort_dir
    @pagy, @notes = pagy(@notes, limit: 20)
  end

  def show
  end

  def new
    @note = Note.new
    render layout: "editor"
  end

  def create
    @note = current_user.notes.build(note_params)
    if @note.save
      redirect_to @note, notice: "Note created."
    else
      render :new, layout: "editor", status: :unprocessable_entity
    end
  end

  def edit
    render layout: "editor"
  end

  def update
    if @note.update(note_params)
      redirect_to @note, notice: "Note updated."
    else
      render :edit, layout: "editor", status: :unprocessable_entity
    end
  end

  def destroy
    @note.destroy
    redirect_to notes_path, notice: "Note deleted."
  end

  private

  def set_note
    @note = current_user.notes.find(params[:id])
  end

  def note_params
    params.require(:note).permit(:content)
  end
end
