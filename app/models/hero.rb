require 'csv'

class Hero < ApplicationRecord
  has_many :ssrs
  # name validation
  validates :name, presence: true,
                     length: { maximum: 10 }
  
  # hero_type validation
  VALID_HERO_TYPE_REGEX = /\A(巫女|遠射|範囲|近接)\z/
  validates :hero_type, presence: true,
                          length: { maximum: 2 },
                          format: { with: VALID_HERO_TYPE_REGEX }
  
  # CSVからのインポート
  def self.csv_import(dir_path = 'db/csv/*.csv')
    Dir.glob(dir_path) do |f|
      datas = CSV.open(f)
      
      # 先頭行だけデータから抜く
      topRow   = datas.shift
    
      hero_name = topRow[0]
      # [1]はファイル名に相当する箇所なので
      hero_type = topRow[2]
      
      Hero.create!(name: hero_name, hero_type: hero_type)
    end
  end
end
