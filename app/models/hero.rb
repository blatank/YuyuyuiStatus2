require 'csv'

class Hero < ApplicationRecord
  
  has_many   :ssrs
  belongs_to :hero_type
  
  # name validation
  validates :name, presence: true,
                     length: { maximum: 10 },
                 uniqueness: true
  
  # filename validation
  validates :filename, presence: true,
                         length: { maximum: 255 }
                         
  # icon url validation
  ICON_URL_REGEX = /\A(|https:\/\/[a-zA-Z][a-zA-Z0-9\.\/\-_]+\.(jpg|jpeg|png|gif|svg|bmp))\z/i
  validates :icon_url, length: { maximum: 1000 },
                       format: {    with: ICON_URL_REGEX}
  
  # CSVからのインポート
  def self.csv_import(dir_path = 'db/csv/*.csv')
    Dir.glob(dir_path) do |f|
      datas = CSV.open(f)
      
      # 先頭行だけデータから抜く
      topRow   = datas.shift
    
      hero_name = topRow[0]
      filename  = topRow[1]
      hero_type_id = HeroType.find_by(name: topRow[2]).id
      
      new_hero = Hero.new(name: hero_name, hero_type_id: hero_type_id, filename: filename)
      new_hero.save if new_hero.valid?
    end
  end
end
