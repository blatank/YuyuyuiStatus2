require 'test_helper'

class SsrsControllerTest < ActionDispatch::IntegrationTest
  def setup
    # @hero = heros(:wassy)
    @ssr  = ssrs(:ssrtest1)
  end
  
  test "should get index" do
    get ssrs_path
    assert_response :success
    assert_template 'ssrs/index'
  end

  test "should get edit" do
    get edit_ssr_path(@ssr)
    assert_response :success
    assert_template 'ssrs/edit'
  end
end
