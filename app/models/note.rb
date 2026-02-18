class Note < ApplicationRecord
  belongs_to :user
  validates :content, presence: true

  before_save :normalize_content

  private

  def normalize_content
    self.content_normalized = ActiveSupport::Inflector.transliterate(content.to_s).downcase
  end
end
