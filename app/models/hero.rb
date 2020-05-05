class Hero < ApplicationRecord
  validates :name, presence: true,
                     length: { maximum: 10 }
end
