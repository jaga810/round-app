class Practice < ActiveRecord::Base
  belongs_to :circle
  has_many :rounds
end
