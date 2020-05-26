require 'test_helper'

class OrderedTableTest < ActionDispatch::IntegrationTest
  def setup
    @hero = heros(:wassy)
  end
  
  test "ordered by sp_atk desc" do
    get spatk_desc_hero_path(@hero)
    
    assert_response :success
    assert_template 'heros/show'
    
  end
  
  test "ordered by atk desc" do
    order_params = ["color_id", "hero_name_id", "hero_type_id", "name", "hp", "atk", "stamina", "speed", "crt", "cost", "sp", "sp_ratio", "sp_atk"]
    orders = ["asc", "desc"]
    
    # ます勇者別ページを開いてリンクを確認する
    get hero_path(@hero)
    
    assert_template 'heros/show'

    # リンクの確認
    order_params.each do |order_param|
      orders.each do |order|
        assert_select "a[href=?]", order_hero_path(@hero, order_param, order)
      end
    end

    # 実際にアクセスさせる
    order_params.each do |order_param|
      orders.each do |order|
        get order_hero_path(@hero, order_param, order)
        assert_response :success
        assert_template 'heros/show'
        
        # alertがないことをテストする
        assert_select "div.alert", count: 0
      end
    end

    ## invalid access
    get order_hero_path(@hero, "color", "admin")
    assert_response :success
    assert_template 'heros/show'
    
    # alertがあることをテストする
    assert_select "div.alert"

  end
end
