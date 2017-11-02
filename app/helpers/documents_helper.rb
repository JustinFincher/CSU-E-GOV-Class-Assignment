module DocumentsHelper
  include SessionsHelper
  include UsersHelper

  def belongs_to_current_user(document)
    if logged_in? && current_user != nil
      return current_user.id == document.user_id
    end
    return false
  end



end
