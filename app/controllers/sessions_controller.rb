# This controller handles the login/logout function of the site.
class SessionsController < ApplicationController
  # Be sure to include AuthenticationSystem in Application Controller instead
  include AuthenticatedSystem
  # render new.rhtml
  def index
  end

  def new
  end

  def create
    logout_keeping_session!
    visitor = Visitor.authenticate(params[:login], params[:password])

    if visitor
      # Protects against session fixation attacks, causes request forgery
      # protection if user resubmits an earlier form using back
      # button. Uncomment if you understand the tradeoffs.
      # reset_session
      session[:visitor_id]=visitor.id
      session[:visitor_name]=visitor.name
      self.current_visitor = visitor
      new_cookie_flag = (params[:remember_me] == "1")
      handle_remember_cookie! new_cookie_flag
      redirect_back_or_default('/visitors')
      flash[:notice] = "Logged in successfully"
    else
      note_failed_signin
      @login       = params[:login]
      @remember_me = params[:remember_me]
      render :action => 'index'
    end
  end

  def destroy
    session[:visitor_id]=nil
    flash[:notice] = "You have been logged out."
    redirect_to "/sessions"
  end

protected
  # Track failed login attempts
  def note_failed_signin
    flash[:error] = "Your Login failed, Please try again"
    logger.warn "Failed login for '#{params[:login]}' from #{request.remote_ip} at #{Time.now.utc}"
  end
end

