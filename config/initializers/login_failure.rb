class LoginFailure < Devise::FailureApp
  def redirect_url
    root_url(anchor: 'login')
  end

  # You need to override respond to eliminate recall
  def respond
    if http_auth?
      http_auth
    else
      redirect
    end
  end
end
