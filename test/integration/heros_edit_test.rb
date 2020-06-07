require 'test_helper'

class HerosEditTest < ActionDispatch::IntegrationTest
  def setup
    @hero = heros(:wassy)
    @user = users(:michael)
  end
  
  test "when show page access without login" do
    # ログインしていない
    
    # show pageにアクセス
    get hero_path(@hero)
    
    # editへのリンクがないことを確認
    assert_select "a[href=?]", edit_hero_path(@hero), count: 0
  end

  test "when show page access with login" do
    # ログインする
    log_in_as(@user)
    
    # show pageにアクセス
    get hero_path(@hero)
    
    # editへのリンクがあることを確認
    assert_select "a[href=?]", edit_hero_path(@hero)
  end

  test "should not access without login" do
    # ログインしていない
    
    # editページにアクセス
    get edit_hero_path(@hero)
    
    # rootにリダイレクトされることを確認 
    assert_redirected_to root_url
    follow_redirect!
    
    # flash
    assert_not flash.empty?
  end
  
  test "unsuccesssful edit" do
    # ログインする
    log_in_as(@user)
    
    get edit_hero_path(@hero)
    assert_template 'heros/edit'
    
    # 間違った入力を送る
    patch hero_path(@hero), params: { hero: {         name: "",
                                              hero_type_id: -1,
                                                  filename: "",
                                                  icon_url: ""
                                            }
                                    }

    assert_template 'heros/edit'
    
    # エラーメッセージをチェック
    assert_select 'div#error_explanation'
    assert_select 'div.field_with_errors'
  end
  
  test "successsful edit" do
    # ログインする
    log_in_as(@user)
    
    get edit_hero_path(@hero)
    assert_template 'heros/edit'
    patch hero_path(@hero), params: { hero: {         name: "土居珠子",
                                              hero_type_id: hero_types(:ensya).id,
                                                  filename: "tamako",
                                                  icon_url: "https://example.com/image/doitama.png"
                                            }
                                    }
    
    assert_redirected_to hero_path(@hero)
    follow_redirect!
    assert_template 'heros/show'
    
    # エラーメッセージをチェック
    assert_select 'div#error_explanation', count: 0
    assert_select 'div.field_with_errors', count: 0
  end
  
  test "send valid edit information without login" do
    # ログインもしてない、edit経由でもなく直接有効値を送る
    patch hero_path(@hero), params: { hero: {         name: "土居珠子",
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
