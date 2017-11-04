module DocumentsHelper
  include SessionsHelper
  include UsersHelper

  def belongs_to_current_user?(document)
    if logged_in? && current_user != nil
      return current_user.id == document.user_id
    end
    return false
  end

  def current_user_has_auth_to_review?(document)
    if logged_in? && current_user != nil
      return current_user.to_review_documents.any?{ |doc_id| doc_id.to_s == document.id.to_s}
    end
    return false
  end



end
