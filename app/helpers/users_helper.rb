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

  def users_by_permission_upper_than_permission(permission)
    return User.all.select{ |user| user.permission < permission }
  end

  def users_by_permission_upper_than_user(lower_user)
    return User.all.select{ |user| user.permission < lower_user.permission }
  end

  def permissions_upper_than_user_has(lower_user)
    return UserPermission.keys.select{ |key| UserPermission::value(key) < lower_user.permission }
  end

  def permissions_upper_than_permission(permission)
    return UserPermission.keys.select{ |key| UserPermission::value(key)  < permission }
  end

end