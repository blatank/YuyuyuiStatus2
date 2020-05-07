class Color < ApplicationRecord
  has_many :ssrs
  
  # 属性
  VALID_COLOR_REGEX = /\A(red|blue|green|yellow|purple)\z/
  validates :name, presence: true,
                    format: { with: VALID_COLOR_REGEX }

  # データインポート
  def self.import
    Color.create!(name: "red")
    Color.create!(name: "blue")
    Color.create!(name: "green")
    Color.create!(name: "yellow")
    Color.create!(name: "purple")
  end
end
