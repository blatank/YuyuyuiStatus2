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
    get atk_desc_hero_path(@hero)
    
    assert_response :success
    assert_template 'heros/show'
    
  end
end
