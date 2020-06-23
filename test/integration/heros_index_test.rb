require 'test_helper'

class HerosIndexTest < ActionDispatch::IntegrationTest
  
  def setup
    @user = users(:michael)
    # ログインする
    log_in_as(@user)
    
    # 平均値情報を更新しておく(fixturesにいれるのが面倒くさい)
    get heros_allupdate_path
    
    # ログアウト
    log_out
  end
  
  test "access index page" do
    get heros_path
    
    assert_template "heros/index"
    
    assert_select "title", text: "勇者一覧 | ゆゆゆいSSRステータス"
    
    # すべての勇者のデータが存在する(SSRがひとつもないものを除く)
    assert_select "td", text: heros(:gin).name, count: 1
    assert_select "td", text: heros(:wassy).name, count: 1

    # heros(:sonochu)はSSRが0
    assert_select "td", text: heros(:sonochu).name, count: 0
    
    # 全勇者の行がある
   assert_select "td", text: "全勇者", count: 1
  end
end
