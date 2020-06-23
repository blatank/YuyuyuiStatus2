ENV['RAILS_ENV'] ||= 'test'
require_relative '../config/environment'
require 'rails/test_help'

class ActiveSupport::TestCase
  # Run tests in parallel with specified workers
  parallelize(workers: :number_of_processors)

  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  # Add more helper methods to be used by all tests here...
  
  # テストユーザーがログイン中の場合にtrueを返す
  def is_logged_in?
    !session[:user_id].nil?
  end

  # テストユーザーとしてログインする
  def log_in_as(user)
    session[:user_id] = user.id
  end
  
  def log_out
    session[:user_id] = nil
  end
end

class ActionDispatch::IntegrationTest

  # テストユーザーとしてログインする

  # for advanced login
  # def log_in_as(user, password: 'password', remember_me: '1')
    # post login_path, params: { session: { email: user.email,
    #                                       password: password,
    #                                       remember_me: remember_me } }
                                          
  def log_in_as(user, password: 'password')
    post login_path, params: { session: { email: user.email,
                                          password: password } }
  end
  
  def log_out
    delete  logout_path
  end
end