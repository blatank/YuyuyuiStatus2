require 'csv'

class Ssr < ApplicationRecord
  belongs_to :hero
  belongs_to :color
  
  default_scope -> { order(color_id: :asc, id: :asc) }
  
  # SSR名
  validates :name, presence: true,
                     length: { maximum: 20 },
                 uniqueness: true

  # レア
  VALID_RARE_REGEX = /\A(R|SR|SSR|UR)\z/
  validates :rare, presence: true,
                     format: { with: VALID_RARE_REGEX }
  
  # 数字→ステータスのアルファベット変換テーブル
  STATUS_NUM = { "F-" =>  0, "F"  =>  1, "F+" =>  2,
                 "E-" =>  3, "E"  =>  4, "E+" =>  5,
                 "D-" =>  6, "D"  =>  7, "D+" =>  8,
                 "C-" =>  9, "C"  => 10, "C+" => 11,
                 "B-" => 12, "B"  => 13, "B+" => 14,
                 "A-" => 15, "A"  => 16, "A+" => 17,
                 "S-" => 18, "S"  => 19, "S+" => 20  }
  STATUS_NUM_INV = STATUS_NUM.invert
  
  # 踏ん張り
  validates :stamina,   presence: true,
                    numericality: { only_integer: true,
                        greater_than_or_equal_to: STATUS_NUM["F-"],
                           less_than_or_equal_to: STATUS_NUM["S+"] }
  
  # 速度
  validates :speed,     presence: true,
                    numericality: { only_integer: true,
                        greater_than_or_equal_to: STATUS_NUM["F-"],
                           less_than_or_equal_to: STATUS_NUM["S+"] }
  # CRT
  validates :crt,       presence: true,
                    numericality: { only_integer: true,
                        greater_than_or_equal_to: STATUS_NUM["F-"],
                           less_than_or_equal_to: STATUS_NUM["S+"] }
  # HP
  validates :hp,          presence: true,
                      numericality: { only_integer: true,
                                      greater_than: 0 }
  # ATK
  validates :atk,         presence: true,
                      numericality: { only_integer: true,
                                      greater_than: 0 }

  # COST
  validates :cost,        presence: true,
                      numericality: { only_integer: true,
                                      greater_than: 0,
                                         less_than: 100 }
  # SP
  validates :sp,          presence: true,
                      numericality: { only_integer: true,
                                      greater_than: 0,
                                         less_than: 100 }
                                         
  # 必殺技倍率
  SP_RATIO_LSB = 0.1
  validates :sp_ratio,    presence: true,
                      numericality: { only_integer: true,
                          greater_than_or_equal_to: 0,
                             less_than_or_equal_to: (500 / SP_RATIO_LSB).to_i }
                             
  # 必殺技ATK
  validates :sp_atk,        presence: true,
                        numericality: { only_integer: true,
                            greater_than_or_equal_to: 0 }
  
  # ステータスを文字列で出力
  def status_str(value)
    STATUS_NUM_INV[value]
  end
  
  # クラス判定(CSS用)
  def puts_maxmin_class(max=0, min=0, mes)
    myself = self.send(mes)
    
    if min == max or self.rare != "SSR"
      ""
    elsif myself == max
      "strongest"
    elsif myself == min
      "weakest"
    else
      ""
    end
  end

  # CSVからのインポート
  def self.csv_import(dir_path = 'db/csv/*.csv')
    Dir.glob(dir_path) do |f|
      datas = CSV.open(f)
      
      # 勇者名を取得。および先頭行を省く
      topRow   = datas.shift
      hero_name = topRow[0]
      
      # debug増やした数を数える
      num = 0
      
      hero = Hero.find_by(name: hero_name)
      if hero
        datas.each do |line|
          color    = Color.find_by(name: line[0])
          rare     = line[1]
          name     = line[2]
          hp       = line[3].to_i
          atk      = line[4].to_i
          stamina  = STATUS_NUM[line[5]]
          speed    = STATUS_NUM[line[6]]
          crt      = STATUS_NUM[line[7]]
          cost     = line[8].to_i
          sp       = line[9].to_i
          hero_id  = hero.id
          
          
          # 必殺技倍率は10倍して入れる
          sp_ratio = (line[10].to_f * 10).to_i
          sp_atk   = atk * sp_ratio
          # Ssr.create(color_id: color.id,
          ssr = Ssr.new(color_id: color.id,
                            rare: rare,
                            name: name,
                              hp: hp,
                             atk: atk,
                         stamina: stamina,
                           speed: speed,
                             crt: crt,
                            cost: cost,
                              sp: sp,
                        sp_ratio: sp_ratio,
                          sp_atk: sp_atk,
                         hero_id: hero_id)
          
          if ssr.valid?
            ssr.save
            num = num + 1 
          end
        end
      end
      puts "#{f}(+#{num})"
    end
  end

end
