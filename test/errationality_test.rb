require 'mocha'
require 'test_helper'

class TestApplicationController < ApplicationController
  before_filter :blah

  def blah
    p 'hi'
  end

  def index
    render :text => "hello"
  end
end

class ErrationalityTest < ActionController::TestCase
  tests TestApplicationController

  def test_exception_base_parent_handling
    assert_controller_handles_exception_with Errational.exception_base::Parent, :handle_exception
  end

  def test_exception_base_loggable_calls_log_exception
    assert_controller_handles_exception_with Errational.exception_base::Loggable, :log_exception
  end

  def test_handle_unexpected_exception_with_general_exception
    assert_controller_handles_exception_with RuntimeError, :handle_unexpected_exception
  end

  def test_should_render_error_text_when_exception_is_raised
    @controller.stubs(:blah).raises(RuntimeError)
    get :index
    assert_match /#{Errational.error_base::UNEXPECTED}/, @response.body
  end

  def test_should_have_error_response_code_for_full_request
    @controller.stubs(:blah).raises(RuntimeError)
    get :index
    assert_response Errational.error_response_code
  end

  def test_should_have_error_response_code_for_xhr_request
    @controller.stubs(:blah).raises(RuntimeError)
    xhr :get, :index
    assert_response Errational.error_response_code
  end

  def test_handle_exception_renders_error_dialog_partial
    @controller.stubs(:blah).raises(RuntimeError)
    xhr :get, :index
    assert_match /new ErrorDialog.*#{Errational.error_base::UNEXPECTED}/, @response.body
  end

  def test_handle_unexpected_exception_handles_general_exceptions_raises_tac_retry_message_and_logs
    new_exception = RuntimeError.new("general error here")
    @controller.expects(:handle_exception).with(Errational.error_base::UNEXPECTED)
    @controller.expects(:log_exception).with(new_exception)
    @controller.send(:handle_unexpected_exception, new_exception)
  end

  private

  def assert_controller_handles_exception_with(exception, method)
    @controller.expects(method)
    @controller.stubs(:blah).raises(exception, "a message")
    xhr :get, :index
  end
end