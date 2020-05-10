require 'test_helper'

class HomePageAccessTest < ActionDispatch::IntegrationTest
  def setup
    
  end
  
  test "access home" do
    get root_path
    assert_response :success
    assert_template 'static_pages/home'
    
    # リンクチェック
    ## 全SSRへのリンクがある
    assert_select "a[href=?]", ssrs_path, count: 1
    
    ## 各勇者別のページへのリンクがある
    heros = Hero.all
    heros.each do |hero|
      assert_select "a[href=?]", hero_path(hero), count: 1
    end
    
    ## 属性別へのリンクがある
    colors = Color.all
    colors.each do |color|
      assert_select "a[href=?]", color_path(color), text: color.mean, count: 1
    end
  end
end
