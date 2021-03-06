class Track < ActiveRecord::Base

  validates :bonus, inclusion: %w(regular bonus)

  belongs_to :album
  has_one :band, through: :album
  has_many :notes

  def is_bonus?
    bonus == "bonus"
  end

  def is_regular?
    bonus == "regular"
  end
end
