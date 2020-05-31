require 'csv'

class Hero < ApplicationRecord
  before_save { self.filename = self.filename.downcase }
  
  has_many   :ssrs
  belongs_to :hero_type
  
  # name validation
  validates :name, presence: true,
                     length: { maximum: 10 },
                 uniqueness: true
  
  # filename validation
  FILENAME_REGEX = /\.csv\z/i
  validates :filename, presence: true,
                         length: { maximum: 255 },
                         format: { with: FILENAME_REGEX }
  
  # CSVからのインポート
  def self.csv_import(dir_path = 'db/csv/*.csv')
    Dir.glob(dir_path) do |f|
      datas = CSV.open(f)
      
      # 先頭行だけデータから抜く
      topRow   = datas.shift
    
      hero_name = topRow[0]
      filename  = "#{topRow[1]}.csv"
      hero_type_id = HeroType.find_by(name: topRow[2]).id
      
      new_hero = Hero.new(name: hero_name, hero_type_id: hero_type_id, filename: filename)
      new_hero.save if new_hero.valid?
    end
  end
end
