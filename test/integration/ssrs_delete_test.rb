require 'test_helper'

class SsrsDeleteTest < ActionDispatch::IntegrationTest
  def setup
    @ssr = ssrs(:ssrtest1)
    @user = users(:michael)
    @ssr_count = ssrs.count
  end
  
  test "when delete access without login" do
    # ログインしてないときに削除しようとした

    # ログインしていない
    
    # 削除実行
    delete ssr_path(@ssr)
    
    # rootにリダイレクトされることを確認 
    assert_redirected_to root_url
    
    # 削除もされてない
    assert @ssr_count, ssrs.count
  end
  
  test "ssr delete" do
    # ログインする
    log_in_as(@user)
    
    # 削除実行
    delete ssr_path(@ssr)

    # 勇者のページににリダイレクトされることを確認 
    assert_redirected_to @ssr.hero
    
    # 成功のメッセージのflashが存在するはず
    assert_not flash.nil?
    
    # 削除の数が1つ減っている
    assert @ssr_count - 1, ssrs.count 
  end
end
