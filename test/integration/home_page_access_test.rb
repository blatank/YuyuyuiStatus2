require 'test_helper'

class HomePageAccessTest < ActionDispatch::IntegrationTest
  def setup
    @test1 = ssrs(:ssrtest1)
    @test2 = ssrs(:ssrtest2)
    @no_hero = heros(:sonochu)
  end
  
  test "home page access" do
    # rootにアクセス
    get root_path
    
    # テンプレート確認
    assert_template 'ssrs/index'
    
    # タイトル確認
    assert_select "title", "SSRステータス(全体) | ゆゆゆいSSRステータス"
    
    # 注意書きがあることを確認
    assert_select "h2", "注意"
    
    # 登録されたSsrの分だけテーブルの行があることを確認
    assert_select "tr", count: Ssr.count+1
    
    # 登録されたSSRのセルがある
    assert_select "td", text: @test1.name, count:1
    assert_select "td", text: @test2.name, count:1

    # 登録された勇者のセルがある
    assert_select "td", text: @test1.hero.name, count:1
    assert_select "td", text: @test2.hero.name, count:1
    
    # 登録されていない勇者のセルがない
    # p Ssr.all
    assert_select "td", text: @no_hero.name, count: 0
  end
end
