require 'test_helper'

class HerosControllerTest < ActionDispatch::IntegrationTest
  def setup
    @hero = heros(:wassy)
  end
  
  test "should get show" do
    get hero_path(@hero)
    assert_response :success
    assert_template 'heros/show'
  end
end
