class Practice < ActiveRecord::Base
  belongs_to :circle
  has_many :rounds
  validates :man_rane, presence: true
  validates :mix_rane, presence: true
end
