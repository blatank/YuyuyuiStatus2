require 'test_helper'
require 'cgi'

class HerosControllerTest < ActionDispatch::IntegrationTest
  def setup
    @hero = heros(:wassy)
  end
  
  test "should get show" do
    get hero_path(@hero)
    assert_response :success
    assert_template 'heros/show'
  end
  
  test "should get index with existing name" do
    # /heros?name=存在する勇者名でアクセス
    name = CGI.escape(@hero.name)
    get "#{heros_path}?name=#{name}"
    
    # その勇者のページに飛ぶことを確認
    assert_redirected_to @hero
    follow_redirect!
    
    # テンプレート確認
    assert_template 'heros/show'
  end

  test "should get index with unexisting name" do
    # /heros?name=存在する勇者名でアクセス
    name = CGI.escape(@hero.name+"あ")
    get "#{heros_path}?name=#{name}"
    
    # indexページが表示されることを確認
    # テンプレート確認
    assert_template 'heros/index'
  end
end
