class HeroType < ApplicationRecord
  has_many :heros
  
  # hero_type validation
  VALID_HERO_TYPE_REGEX = /\A(巫女|遠射|範囲|近接)\z/
  validates :name, presence: true,
                     length: { maximum: 2 },
                     format: { with: VALID_HERO_TYPE_REGEX }

  # CSVからのインポート
  def self.import
    # 決め打ち
    HeroType.create!(name: "近接")
    HeroType.create!(name: "遠射")
    HeroType.create!(name: "範囲")
    HeroType.create!(name: "巫女")
  end
end
