module UsersHelper
  include SessionsHelper

  # Returns the Gravatar for the given user.
  def gravatar_for(user)
    gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
    gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}?s=256&d=identicon"
    image_tag(gravatar_url, alt: user.name, class: "gravatar")
  end

  def gravatar_round_for(user)
    gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
    gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}?s=256&d=identicon"
    image_tag(gravatar_url, alt: user.name, class:'ui huge avatar image')
  end

  def is_admin_or_upper_for?(user)
    if user != nil
      return user.permission <= UserPermission::admin
    end
    return false
  end

  def is_root_or_upper_for?(user)
    if user != nil
      return user.permission <= UserPermission::root
    end
    return false
  end

  def is_admin_or_upper?
    if current_user != nil
      return current_user.permission <= UserPermission::admin
    end
    return false
  end

  def is_root_or_upper?
    if current_user != nil
      return current_user.permission <= UserPermission::root
    end
    return false
  end

  def should_create_root_user?
    return User.all.find_all{|u| u.permission == UserPermission::root}.empty?
  end

end