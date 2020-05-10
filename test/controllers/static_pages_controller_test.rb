require 'test_helper'

class StaticPagesControllerTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end
  test "should get root" do
    get root_path
    assert_response :success
    assert_template 'static_pages/home'
  end
end
