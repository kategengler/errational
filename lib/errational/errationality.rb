module Errationality
  private

  def handle_unexpected_exception(exception)
    log_exception(exception)
    handle_exception(Errational.error_base::UNEXPECTED)
  end

  def handle_exception(exception_or_message)
    log_exception(exception_or_message) if (exception_or_message.is_a? Errational.exception_base::Loggable)
    render_error(exception_or_message.to_s)
  end

  def render_error(message)
    if request.xhr?
      render :partial => Errational.error_partial, :status => Errational.error_response_code, :locals => {:message => message}, :content_type => "text/javascript"
    else
      respond_to do |format|
        format.text do
          render :text => message, :status => Errational.error_response_code
        end
        format.html do
          render :text => message, :status => Errational.error_response_code
        end
        format.json do
          render :json => message, :status => Errational.error_response_code
        end
      end
    end
  end

  def log_exception(exception)
    Errational.logger.info "An exception occurred and was handled #{exception.class} : #{exception.to_s}"
    Errational.logger.info exception.backtrace[0, 15].join("\n")
  end
end


# Note:
# When using rescue_from, assert_raises no longer works
# Test for the results of the exception handling or expect exception handlers to be called
ActiveSupport.on_load(:action_controller) do
  include Errationality

  rescue_from Exception, :with => :handle_unexpected_exception
  rescue_from Errational.exception_base::Parent, :with => :handle_exception
end
