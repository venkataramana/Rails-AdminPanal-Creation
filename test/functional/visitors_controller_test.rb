require File.dirname(__FILE__) + '/../test_helper'
require 'visitors_controller'

# Re-raise errors caught by the controller.
class VisitorsController; def rescue_action(e) raise e end; end

class VisitorsControllerTest < ActionController::TestCase
  # Be sure to include AuthenticatedTestHelper in test/test_helper.rb instead
  # Then, you can remove it from this and the units test.
  include AuthenticatedTestHelper

  fixtures :visitors

  def test_should_allow_signup
    assert_difference 'Visitor.count' do
      create_visitor
      assert_response :redirect
    end
  end

  def test_should_require_login_on_signup
    assert_no_difference 'Visitor.count' do
      create_visitor(:login => nil)
      assert assigns(:visitor).errors.on(:login)
      assert_response :success
    end
  end

  def test_should_require_password_on_signup
    assert_no_difference 'Visitor.count' do
      create_visitor(:password => nil)
      assert assigns(:visitor).errors.on(:password)
      assert_response :success
    end
  end

  def test_should_require_password_confirmation_on_signup
    assert_no_difference 'Visitor.count' do
      create_visitor(:password_confirmation => nil)
      assert assigns(:visitor).errors.on(:password_confirmation)
      assert_response :success
    end
  end

  def test_should_require_email_on_signup
    assert_no_difference 'Visitor.count' do
      create_visitor(:email => nil)
      assert assigns(:visitor).errors.on(:email)
      assert_response :success
    end
  end
  

  

  protected
    def create_visitor(options = {})
      post :create, :visitor => { :login => 'quire', :email => 'quire@example.com',
        :password => 'quire69', :password_confirmation => 'quire69' }.merge(options)
    end
end
