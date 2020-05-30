require 'test_helper'

class SsrsAddTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:michael)
  end
  
  test "should not access without login" do
    
    # newページにアクセス
    get new_ssr_path
    
    # rootにリダイレクトされることを確認 
    assert_redirected_to root_url
    follow_redirect!
  end
  
  test "invalid ssr information" do
    # ログインする
    log_in_as(@user)
    
    # newページにアクセス
    get new_ssr_path
    
    # 間違った入力を送る
    assert_no_difference 'Ssr.count' do
      post ssrs_path, params: { ssr: { name: "",
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
    end
    
    # 失敗時はフォームが再表示される
    assert_template 'ssrs/new'
    
    # エラーメッセージをチェック
    assert_select 'div#error_explanation'
    assert_select 'div.field_with_errors'
  end
  
  test "valid ssr information" do
    # ログインする
    log_in_as(@user)
    
    # newページにアクセス
    get new_ssr_path
    
    # 正しい入力を送る
    assert_difference 'Ssr.count', 1 do
      post ssrs_path, params: { ssr: { name: "test",
                                       hero_id: heros(:gin).id,
                                       rare: "SSR",
                                       color_id: colors(:red).id,
                                       hp: 100,
                                       atk: 100,
                                       stamina: 0,
                                       speed: 0,
                                       crt: 1,
                                       cost: 1,
                                       sp: 1,
                                       sp_ratio: 0,
                                       sp_atk: 0
                                      }
                              }
    end
    
    # 成功時はSSRのページに飛ぶ
    follow_redirect!
    assert_template 'ssrs/show'
    
    # エラーメッセージをチェック
    assert_select 'div#error_explanation', count: 0
    assert_select 'div.field_with_errors', count: 0
    
    # 成功のメッセージのflashが存在するはず
    assert_not flash.nil?
  end
  
  test "send valid create information without login" do
    # ログインもしてない、edit経由でもなく直接有効値を送る
    post ssrs_path, params:       { ssr: { name: "test",
                                        hero_id: heros(:gin).id,
                                           rare: "SSR",
                                       color_id: colors(:red).id,
                                             hp: 100,
                                            atk: 100,
                                        stamina: 0,
                                          speed: 0,
                                            crt: 1,
                                           cost: 1,
                                             sp: 1,
                                       sp_ratio: 0,
                                         sp_atk: 0
                                        }
                                  }    
    
    # rootにリダイレクトされることを確認 
    assert_redirected_to root_url
    follow_redirect!
    
    # flash
    assert_not flash.empty?
  end
end
