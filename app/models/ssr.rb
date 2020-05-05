class Ssr < ApplicationRecord
  belongs_to :hero
  
  # SSR名
  validates :name, presence: true,
                     length: { maximum: 20 }
  
  # 属性
  COLOR_NUM = { "red" => 0, "blue" => 1, "green" => 2, "yellow" => 3, "purple" => 4}
  validates :color,     presence: true,
                    numericality: { only_integer: true,
                        greater_than_or_equal_to: COLOR_NUM["red"],
                           less_than_or_equal_to: COLOR_NUM["purple"] }

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
end
