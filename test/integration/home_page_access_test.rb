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
    assert_select "a[href=?]", hero_path(heros(:wassy)), count: 1
    assert_select "a[href=?]", hero_path(heros(:gin)), count: 1

    ## SSRがない勇者へのリンクはない
    assert_select "a[href=?]", hero_path(heros(:sonochu)), count: 0
    
    ## 属性別へのリンクがある
    colors = Color.all
    colors.each do |color|
      assert_select "a[href=?]", color_path(color), text: color.mean, count: 1
    end
    
    ## 存在するタイプの勇者へのリンクがある
    types = [:kinsetsu, :ensya, :hani]
    types.each do |t|
      hero_type = hero_types(t)
      assert_select "a[href=?]", hero_type_path(hero_type), text: hero_type.name, count: 1
    end
    
    ## 存在しないタイプの勇者へのリンクがない
    assert_select "a[href=?]", hero_type_path(hero_types(:miko)), count: 0
    
  end
end
