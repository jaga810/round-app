class Circle < ActiveRecord::Base
  has_many :players
  has_many :practices
end
