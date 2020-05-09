class Color < ApplicationRecord
  has_many :ssrs
  
  # 属性
  VALID_COLOR_REGEX = /\A(red|blue|green|yellow|purple)\z/
  validates :name, presence: true,
                    format: { with: VALID_COLOR_REGEX },
                uniqueness: true

  VALID_COLOR_MEAN_REGEX = /\A(赤|青|緑|黄|紫)\z/
  validates :mean, presence: true,
                    format: { with: VALID_COLOR_MEAN_REGEX }

  # データインポート
  def self.import
    colors = {  "red"    => "赤",
                "blue"   => "青",
                "green"  => "緑",
                "yellow" => "黄",
                "purple" => "紫" }
    
    colors.each do |key, value|
      new_color = Color.new(name: key, mean: value)
      new_color.save if new_color.valid?
    end
  end
end
