module Errational
  module TestHelpers
    def assert_renders_error_message(error)
      assert_match @response.body, /#{error}/
    end

    def expect_no_error
      @controller.expects(:handle_exception).never
    end
  end
end