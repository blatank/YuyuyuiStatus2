require 'test_helper'

class SsrsControllerTest < ActionDispatch::IntegrationTest
  def setup
    # @hero = heros(:wassy)
    # @ssr  = ssrs(:ssrtest)
  end
  
  test "should get index" do
    get ssrs_path
    assert_response :success
    assert_template 'ssrs/index'
  end
end
