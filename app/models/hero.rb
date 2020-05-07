require 'csv'

class Hero < ApplicationRecord
  has_many :ssrs
  # name validation
  validates :name, presence: true,
                     length: { maximum: 10 }
  
  # CSVからのインポート
  def self.csv_import(dir_path = 'db/csv/*.csv')
    Dir.glob(dir_path) do |f|
      datas = CSV.open(f)
      
      # 先頭行だけデータから抜く
      topRow   = datas.shift
    
      hero_name = topRow[0]
      # [1]はファイル名に相当する箇所なので
      hero_type_id = HeroType.find_by(name: topRow[2]).id
      
      Hero.create!(name: hero_name, hero_type_id: hero_type_id)
    end
  end
end
