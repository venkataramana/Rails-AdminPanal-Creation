module AuthenticatedTestHelper
  # Sets the current visitor in the session from the visitor fixtures.
  def login_as(visitor)
    @request.session[:visitor_id] = visitor ? (visitor.is_a?(Visitor) ? visitor.id : visitors(visitor).id) : nil
  end

  def authorize_as(visitor)
    @request.env["HTTP_AUTHORIZATION"] = visitor ? ActionController::HttpAuthentication::Basic.encode_credentials(visitors(visitor).login, 'monkey') : nil
  end
  
end
