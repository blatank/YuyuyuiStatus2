require 'test_helper'

class OrderedTableTest < ActionDispatch::IntegrationTest
  def setup
    @hero = heros(:wassy)
    @color = colors(:red)
    @order_params = ["color_id", "hero_id", "hero_type_id", "name", "hp", "atk", "stamina", "speed", "crt", "cost", "sp", "sp_ratio", "sp_atk"]
    @orders = ["asc", "desc"]
  end
  
  test "hero_page order test" do
    
    # ます勇者別ページを開いてリンクを確認する
    get hero_path(@hero)
    
    assert_template 'heros/show'

    # リンクの確認
    @order_params.each do |order_param|
      @orders.each do |order|
        assert_select "a[href=?]", order_hero_path(@hero, order_param, order)
      end
    end

    # 実際にアクセスさせる
    @order_params.each do |order_param|
      @orders.each do |order|
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
    
  test "color_page order test" do
    # 色別ページにアクセス
    get color_path(@color)
    assert_template 'colors/show'
    
    # リンクの確認
    @order_params.each do |order_param|
      @orders.each do |order|
        assert_select "a[href=?]", order_color_path(@color, order_param, order)
      end
    end

    # 実際にアクセスさせる
    @order_params.each do |order_param|
      @orders.each do |order|
        get order_color_path(@color, order_param, order)
        assert_response :success
        assert_template 'colors/show'
        
        # alertがないことをテストする
        assert_select "div.alert", count: 0
      end
    end

    ## invalid access
    get order_color_path(@color, "color", "admin")
    assert_response :success
    assert_template 'colors/show'
    
    # alertがあることをテストする
    assert_select "div.alert"
  end
  
end
