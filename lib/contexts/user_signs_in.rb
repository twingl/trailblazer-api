require 'playhouse/context'

class UserSignsIn < Playhouse::Context
  actor :email
  actor :password
  actor :ip

  def perform
    user = User.where{|u| u.email =~ email}.first

    if user && user.password_digest.present? && user.authenticate(password)
      attrs = {
        :sign_in_count      => user.sign_in_count + 1,
        :last_sign_in_ip    => user.current_sign_in_ip || ip,
        :current_sign_in_ip => ip,
        :last_sign_in_at    => user.current_sign_in_at || Time.now.utc,
        :current_sign_in_at => Time.now.utc
      }
      user.update_attributes(attrs)

      user
    elsif user && user.is_a?(User)
      return :incorrect_password
    else
      return :unknown_account
    end
  end
end
