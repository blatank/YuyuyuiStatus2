require 'test_helper'

class SsrsEditTest < ActionDispatch::IntegrationTest
  def setup
    @ssr = ssrs(:ssrtest1)
    @user = users(:michael)
  end
  
  test "when show page access without login" do
    # ログインしていない
    
    # show pageにアクセス
    get ssr_path(@ssr)
    
    # editへのリンクがないことを確認
    assert_select "a[href=?]", edit_ssr_path(@ssr), count: 0
  end

  test "when show page access with login" do
    # ログインする
    log_in_as(@user)
    
    # show pageにアクセス
    get ssr_path(@ssr)
    
    # editへのリンクがあることを確認
    assert_select "a[href=?]", edit_ssr_path(@ssr)
  end

  test "should not access without login" do
    # ログインしていない
    
    # editページにアクセス
    get edit_ssr_path(@ssr)
    
    # rootにリダイレクトされることを確認 
    assert_redirected_to root_url
    follow_redirect!
    
    # flash
    assert_not flash.empty?
  end
  
  test "unsuccesssful edit" do
    # ログインする
    log_in_as(@user)
    
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
    
    # エラーメッセージをチェック
    assert_select 'div#error_explanation'
    assert_select 'div.field_with_errors'
  end
  
  test "successsful edit" do
    # ログインする
    log_in_as(@user)
    
    get edit_ssr_path(@ssr)
    assert_template 'ssrs/edit'
    patch ssr_path(@ssr), params: { ssr: { name: "test",
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
    
    assert_redirected_to ssr_path(@ssr)
    follow_redirect!
    assert_template 'ssrs/show'
    
    # エラーメッセージをチェック
    assert_select 'div#error_explanation', count: 0
    assert_select 'div.field_with_errors', count: 0
  end
  
  test "send valid edit information without login" do
    # ログインもしてない、edit経由でもなく直接有効値を送る
    patch ssr_path(@ssr), params: { ssr: { name: "test",
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
