require 'test_helper'

class SsrsControllerTest < ActionDispatch::IntegrationTest
  def setup
    # @hero = heros(:wassy)
    # @ssr  = ssrs(:ssrtest)
  end
  
  test "should get root" do
    get root_path
    assert_response :success
    assert_template 'ssrs/index'
  end
end
