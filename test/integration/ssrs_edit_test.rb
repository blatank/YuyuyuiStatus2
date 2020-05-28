require 'test_helper'

class SsrsEditTest < ActionDispatch::IntegrationTest
  def setup
    @ssr = ssrs(:ssrtest1)
  end
  
  test "unsuccesssful edit" do
    get edit_ssr_path(@ssr)
    assert_template 'ssrs/edit'
    patch ssr_path(@ssr), params: { ssr: { name: "",
                                           hero_id: -1,
                                           rare: "",
                                           color_id: -1,
                                           hp: 0,
                                           atk: 0,
                                           stamina: 21,
                                           speed: 21,
                                           crt: 21,
                                           cost: 0,
                                           sp: 0,
                                           sp_ratio: -1,
                                           sp_atk: -1
                                          }
                                  }
    assert_template 'ssrs/edit'
  end
end
