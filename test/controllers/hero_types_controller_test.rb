require 'test_helper'

class HeroTypesControllerTest < ActionDispatch::IntegrationTest
  def setup
    @hero_type = hero_types(:ensya)
    @ssr_not_found_hero_type = hero_types(:hani)
  end
  
  test "should get show" do
    get hero_type_path(@hero_type)
    assert_response :success
    assert_template 'hero_types/show'
  end
  
  # SSRがいないときにエラーになっていたのでテスト追加(ここのテストの問題ではない気がするが・・・)
  test "should get show(SSR not found)" do
    get hero_type_path(@ssr_not_found_hero_type)
    assert_response :success
    assert_template 'hero_types/show'
  end  
end
