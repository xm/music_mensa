module ApplicationHelper
  def authenticity_token
    ('<input type="hidden" name="authenticity_token" value="' +
      form_authenticity_token + '">').html_safe
  end

  def nav_item(text, url)
    link_to("<li>#{ text }</li>".html_safe, url)
  end
end
