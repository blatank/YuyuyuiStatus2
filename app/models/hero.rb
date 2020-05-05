class Hero < ApplicationRecord
  # name validation
  validates :name, presence: true,
                     length: { maximum: 10 }
  
  # hero_type validation
  VALID_HERO_TYPE_REGEX = /\A(巫女|遠射|範囲|近接)\z/
  validates :hero_type, presence: true,
                          length: { maximum: 2 },
                          format: { with: VALID_HERO_TYPE_REGEX }
  
end
