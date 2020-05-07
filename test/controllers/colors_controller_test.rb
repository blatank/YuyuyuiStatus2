require 'test_helper'

class ColorsControllerTest < ActionDispatch::IntegrationTest
  
  def setup
    @color = colors(:red)
    @ssr_not_found_color = colors(:blue)
  end
  
  test "should get show" do
    get color_path(@color)
    assert_response :success
    assert_template 'colors/show'
  end
  
  # SSRがいないときにエラーになっていたのでテスト追加(ここのテストの問題ではない気がするが・・・)
  test "should get show(SSR not found)" do
    get color_path(@ssr_not_found_color)
    assert_response :success
    assert_template 'colors/show'
  end  
end
