class SessionsController < ApplicationController
  def new
  end

  def create
   
    email = params[:session][:email]
    password = params[:session][:password]
   
    if login(email, password)
      flash[:success] = "ログインに成功しました"
      redirect_to tasks_url
    else
      flash.now[:danger] = "ログインに失敗しました"
      render :new
    end
    
  end

  def destroy
    session[:user_id] = nil
    flash[:success] = "ログアウトしました"
    redirect_to login_url
  end
  
  private
  
  def login(email, password)

    @user = User.find_by(email: email)
    #authenticateメソッド（引数はpassword）は、@userに代入されているレコードのパスワードが正しいかを確認する
    if @user && @user.authenticate(password)
      #下記一文により、ブラウザにcookieとして、サーバーにsessionとして、ログイン状態が維持されることになります
      session[:user_id] = @user.id
      return true
    else
      return false
    end
  end
    
end
