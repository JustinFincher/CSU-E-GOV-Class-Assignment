module ApplicationHelper

  def is_backstage_url?(path)
    return current_page?(backstage_path)
  end

end
