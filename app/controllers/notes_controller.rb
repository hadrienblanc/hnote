class NotesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_note, only: [:show, :edit, :update, :destroy]

  SORT_COLUMNS = %w[created_at updated_at].freeze

  def index
    @notes = current_user.notes
    @notes = @notes.where("content LIKE ?", "%#{params[:q]}%") if params[:q].present?
    sort_col = SORT_COLUMNS.include?(params[:sort]) ? params[:sort] : "updated_at"
    sort_dir = params[:dir] == "asc" ? "asc" : "desc"
    @notes = @notes.order("#{sort_col} #{sort_dir}")
    @sort_col = sort_col
    @sort_dir = sort_dir
  end

  def show
  end

  def new
    @note = Note.new
  end

  def create
    @note = current_user.notes.build(note_params)
    if @note.save
      redirect_to @note, notice: "Note created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @note.update(note_params)
      redirect_to @note, notice: "Note updated."
    else
      render :edit, status: :unprocessable_entity
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
