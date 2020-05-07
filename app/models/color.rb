class Color < ApplicationRecord
  has_many :ssrs
  
  # 属性
  VALID_COLOR_REGEX = /\A(red|blue|green|yellow|purple)\z/
  validates :name, presence: true,
                    format: { with: VALID_COLOR_REGEX }

  VALID_COLOR_MEAN_REGEX = /\A(赤|青|緑|黄|紫)\z/
  validates :mean, presence: true,
                    format: { with: VALID_COLOR_MEAN_REGEX }

  # データインポート
  def self.import
    Color.create!(name: "red",    mean: "赤")
    Color.create!(name: "blue",   mean: "青")
    Color.create!(name: "green",  mean: "緑")
    Color.create!(name: "yellow", mean: "黄")
    Color.create!(name: "purple", mean: "紫")
  end
end
