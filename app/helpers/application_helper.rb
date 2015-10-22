module ApplicationHelper

  def auth_token
    <<-HTML.html_safe
    <input type="hidden"
           name="authenticity_token"
           value="#{form_authenticity_token}">
    HTML
  end

  def ugly_lyrics(lyrics)
    line_array = lyrics.split("\n")
    html = "<pre>"
    line_array.each do |line|
      html += "♫ " + h(line) +"\n"
    end

    html.html_safe
  end
end
