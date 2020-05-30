require 'test_helper'

class UsersLoginTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:michael)
  end
  
  test "login with valid information" do
    # ログインページに飛ぶ
    get login_path
    
    # 正しいユーザ情報を入力
    post login_path, params: { session: { email:    @user.email,
                                          password: 'password' } }
    # リダイレクトされることを確認
    assert_redirected_to @user
    follow_redirect!
    
    # ユーザページ
    assert_template 'users/show'
    
    # ログインしていることを確認
    assert is_logged_in?
    
    # ヘッダ部分のリンクを確認
    assert_select "a[href=?]", new_ssr_path # SSR追加へのパスがあるはず
  end
  
  test "login with invalid information" do
    # ログインページに飛ぶ
    get login_path
    assert_template 'sessions/new'
    
    # email/パスワードを間違って入力
    post login_path, params: { session: { email: "", password: "" } }
    
    # 失敗したので再度ログインフォームが表示される
    assert_template 'sessions/new'

    # ログインしていないことを確認
    assert_not is_logged_in?

    # ヘッダ部分のリンクを確認
    assert_select "a[href=?]", new_ssr_path, count: 0 # SSR追加へのパスがないはず
    
    # flash賀表示されているはず
    assert_not flash.empty?
    get root_path
    
    # 移動した後は消えているはず
    assert flash.empty?
    
    # ログインしていないことを確認
    assert_not is_logged_in?
    
    # ヘッダ部分のリンクを確認
    assert_select "a[href=?]", new_ssr_path, count: 0 # SSR追加へのパスがないはず
  end
end
