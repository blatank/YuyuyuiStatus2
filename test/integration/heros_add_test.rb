require 'test_helper'

class HerosAddTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:michael)
  end
  
  test "should not access without login" do
    
    # newページにアクセス
    get new_hero_path
    
    # rootにリダイレクトされることを確認 
    assert_redirected_to root_url
    follow_redirect!
  end
  
  test "invalid ssr information" do
    # ログインする
    log_in_as(@user)
    
    # newページにアクセス
    get new_hero_path
    
    # 間違った入力を送る
    assert_no_difference 'Hero.count' do
      post heros_path, params: { hero: { name: "",
                                         hero_type_id: -1,
                                         filename: "",
                                         icon_url: ""
                                       }
                               }
    end
    
    # 失敗時はフォームが再表示される
    assert_template 'heros/new'
    
    # エラーメッセージをチェック
    assert_select 'div#error_explanation'
    assert_select 'div.field_with_errors'
  end
  
  test "valid hero information" do
    # ログインする
    log_in_as(@user)
    
    # newページにアクセス
    get new_hero_path
    
    # 正しい入力を送る
    assert_difference 'Hero.count', 1 do
      post heros_path, params: { hero: {         name: "土居珠子",
                                         hero_type_id: hero_types(:ensya).id,
                                             filename: "tamako",
                                             icon_url: "https://example.com/image/doitama.png"
                                       }
                                }
    end
    
    # 成功時はSSRのページに飛ぶ
    follow_redirect!
    assert_template 'heros/show'
    
    # エラーメッセージをチェック
    assert_select 'div#error_explanation', count: 0
    assert_select 'div.field_with_errors', count: 0
    
    # 成功のメッセージのflashが存在するはず
    assert_not flash.nil?
  end
  
  test "send valid create information without login" do
    # ログインもしてない、edit経由でもなく直接有効値を送る
    post heros_path, params: { hero: {         name: "土居珠子",
                                       hero_type_id: hero_types(:ensya).id,
                                           filename: "tamako",
                                           icon_url: "https://example.com/image/doitama.png"
                                     }
                              }
    
    # rootにリダイレクトされることを確認 
    assert_redirected_to root_url
    follow_redirect!
    
    # flash
    assert_not flash.empty?
  end
end
