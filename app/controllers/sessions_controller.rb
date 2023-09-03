class SessionsController < ApplicationController
  def create
    user = User.find_by_email(params[:email])
    # If the user exists AND the password entered is correct.
    if user && user.authenticate(params[:password])
      # Save the user id inside the browser cookie.
      session[:user_id] = user.id
      redirect_to root_path
    else
      # If user's login doesn't work, send them back to the login form.
      redirect_to new_login_path
    end
  end
  def destroy
    session.delete(:user_id)
    redirect_to new_login_path
  end

end


