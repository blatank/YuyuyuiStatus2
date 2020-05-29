class User < ApplicationRecord
  # 保存時にemailは小文字にする
  before_save { self.email = email.downcase }
  
  # name
  validates :name,  presence: true, length: { maximum: 50  }
  
  # email
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true,
                      length: { maximum: 255 },
                      format: { with: VALID_EMAIL_REGEX },
                  uniqueness: true
                  
  # password
  has_secure_password
  validates :password, presence: true,
                         length: { minimum: 6 }
  
end
