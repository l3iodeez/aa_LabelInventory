class Album < ActiveRecord::Base
  validates :title, presence: true
  validates :venue, inclusion: %w(studio live)
  has_many :tracks, dependent: :destroy
  belongs_to :band


  def is_studio?
    venue == "studio"
  end

  def is_live?
    venue == "live"
  end

end
