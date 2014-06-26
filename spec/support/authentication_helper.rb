module AuthenticationHelper
  def sign_in(user)
    controller.send(:establish_session, user)
  end
end
