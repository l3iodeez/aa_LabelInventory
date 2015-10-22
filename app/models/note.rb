class Note < ActiveRecord::Base
  validates :note_text, presence: true

  belongs_to :track
  belongs_to :user
end
