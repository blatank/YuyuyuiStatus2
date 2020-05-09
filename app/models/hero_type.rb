class HeroType < ApplicationRecord
  has_many :heros
  
  # hero_type validation
  VALID_HERO_TYPE_REGEX = /\A(巫女|遠射|範囲|近接)\z/
  validates :name, presence: true,
                     length: { maximum: 2 },
                     format: { with: VALID_HERO_TYPE_REGEX },
                 uniqueness: true

  # CSVからのインポート
  def self.import
    # 決め打ち
    types = ["近接", "遠射", "範囲", "巫女"]
    
    types.each do |t|
      new_type = HeroType.new(name: t)
      new_type.save if new_type.valid?
    end
  end
end
