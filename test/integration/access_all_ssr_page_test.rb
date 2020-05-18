require 'test_helper'

class AccessAllSsrPageTest < ActionDispatch::IntegrationTest
  def setup
    @test1 = ssrs(:ssrtest1)
    @test2 = ssrs(:ssrtest2)
    @no_hero = heros(:sonochu)
  end
  
  test "index page access" do
    # indexにアクセス
    get ssrs_path
    
    # テンプレート確認
    assert_template 'ssrs/index'
    
    # タイトル確認
    assert_select "title", "SSRステータス(全体) | ゆゆゆいSSRステータス"
    
    # 注意書きがあることを確認
    assert_select "h2", "注意"
    
    # 登録されたSsrの分だけテーブルの行があることを確認
    assert_select "tr", count: Ssr.count+2
    
    # 登録されたSSRのセルがある
    assert_select "td", text: @test1.name, count:1
    assert_select "td", text: @test2.name, count:1

    # 登録された勇者のセルがある
    assert_select "td", text: @test1.hero.name, count:1
    assert_select "td", text: @test2.hero.name, count:1
    
    # 登録されていない勇者のセルがない
    # p Ssr.all
    assert_select "td", text: @no_hero.name, count: 0
    
    # リンク確認(@test1, @test2はタイプも違うのでカウント数も別々になるはず)
    assert_select "a[href=?]", hero_path(@test1.hero), count: 1
    assert_select "a[href=?]", hero_path(@test2.hero), count: 1
    assert_select "a[href=?]", hero_type_path(@test1.hero.hero_type), count: 1
    assert_select "a[href=?]", hero_type_path(@test2.hero.hero_type), count: 1
    assert_select "a[href=?]", color_path(@test1.color), count: 1
    assert_select "a[href=?]", color_path(@test2.color), count: 1
    
    # 平均値が表示されている(tdタグで確認)
    assert_select "td", text: "平均値(SSRのみ)", count: 1
    
    # ルートへ戻るリンクがある
    assert_select "a[href=?]", root_path
    
  end
end
