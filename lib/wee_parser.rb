module WeeParser
  CSS_DICT = ["color", "background", "font", "size", "text", "hover", "link", "title", "border", "header", "family"]
  USER_DICT = ["header", "image", "contact", "form", "about", "me", "tagline", "rss", "url", "username"]
  PIECE_DICT = ["piece", "pieces", "meta", "portfolio", "image", "gallery", "about", "client", "service", "for", "sale", "url", "if", "title"]
  GLOBAL_DICT = ["end"]
  THRESH = 0.75
  
  # Right now, this generates an array of all the tags in the HTML. Needs to process each sub to .erb, stick it back in at the same index.
  def self.parse(string)
    i = 0
    o = 0
    dict = Hash.new
    while string.include?("]") && string.include?("]")
      i = string.index("[")
      o = string.index("]")
      if make_output_for(string[i..o])
        dict[string[i..o]] = make_output_for(string[i..o])
      end
      string = string[o+1..string.length]
    end
    dict
  end
  
  # Output a block of HTML with ERB where once there were tags. This copy gets saved to be rendered in the portfolio/show action.
  def self.build_erb_copy_for(dictionary, input_string)
    output_string = input_string
    dictionary.each do |key, value|
      output_string = output_string.gsub(key, value)
    end
    output_string
  end
  
  #################################################################################################################
  # We're not using these conditional methods yet, but I'm keeping them around in case we need them in the future.#
  #################################################################################################################
  
  # Is this tag a conditional?
  def is_conditional(substring)
    substring.include?("block:") || substring.include?("/block:")
  end
  
  # Is the conditional the start of a block or the end of one?
  def conditional_type(substring)
    if substring.include?("block:")
      "start"
    elsif substring.include?("/block:")
      "end"
    end
  end
  
  # Strip the [] off of the conditional so we can see what kind it is.
  def break_conditional(substring)
    if is_conditional(substring)
      substring = substring.gsub(/[\[\]]/, "")
      output = substring.split(" ")[1]
    else
      output = substring
    end
    output
  end
  
  #################################################################################################################
  #################################################################################################################
  
  # Is this tag a CSSObject?
  def self.classify_as_css(substring)
    i = 0
    string = substring.split("-")
    string.each do |word|
      CSS_DICT.length.times do |j|
        if word.include?(CSS_DICT[j])
          i += 1
        end
      end
    end
    evaluate_classification_score_for(i, string)
  end

  # Is this tag a UserObject?
  def self.classify_as_user(substring)
    i = 0
    string = substring.split("-")
    string.each do |word|
      USER_DICT.length.times do |j|
        if word.include?(USER_DICT[j])
          i += 1
        end
      end
    end
    return true if evaluate_classification_score_for(i, string)
  end

  # Is this tag a PieceObject?
  def self.classify_as_piece(substring)
    i = 0
    string = substring.split("-")
    string.each do |word|
      PIECE_DICT.length.times do |j|
        if word.include?(PIECE_DICT[j])
          i += 1
        end
      end
    end
    return true if evaluate_classification_score_for(i, string)
  end
  
  def self.classify_as_global(substring)
    i = 0
    string = substring.split("-")
    string.each do |word|
      GLOBAL_DICT.length.times do |j|
        if word.include?(GLOBAL_DICT[j])
          i += 1
        end
      end
    end
    return true if evaluate_classification_score_for(i, string)
  end
  
  # Are enough of the words in this tag having to do with the associated dictionary?
  def self.evaluate_classification_score_for(score, string)
    if score.to_f / string.length.to_f > THRESH
      true
    else
      false
    end
  end
  
  # Give the .erb equivalent of the tag we're passing in.
  def self.make_output_for(substring)
    if classify_as_css(substring)
      CSSObject.determine_output_for(substring)
    elsif classify_as_user(substring)
      UserObject.determine_output_for(substring)
    elsif classify_as_piece(substring)
      PieceObject.determine_output_for(substring)
    elsif classify_as_global(substring)
      GlobalObject.determine_output_for(substring)
    else
      false
    end
  end
end
  
class CSSObject
  
  def self.determine_output_for(input_string)
    case input_string
    when "[background-color]"
      "<%=h @design.render_color(@design.background_color) %>"
    when "[text-color]"
      "<%=h @design.render_color(@design.text_color) %>"
    when "[font]"
      "<%=h @design.font %>"
    when "[font-size]"
      "<%=h @design.font_size %>"
    when "[font-family]"
      "<%=h @design.render_font_family %>"
    when "[link-color]"
      "<%=h @design.render_color(@design.link_color) %>"
    when "[link-hover]"
      "<%=h @design.render_color(@design.link_hover_color) %>"
    when "[border-color]"
      "<%=h @design.render_color(@design.border_color) %>"
    when "[title-color]"
      "<%=h @design.render_color(@design.title_color) %>"
    when "[header-background]"
      "<%=h @design.header_background %>"
    when "[header]"
      "<%= render :partial => 'shared/header_image' %>"
    when "[header-color]"
      "<%= @design.render_color(@design.header_color) %>"
    end
  end

end
  
class UserObject
  
  def self.determine_output_for(input_string)
    case input_string
    when "[username]"
      "<%= @user.login %>"
    when "[about]"
      "<%= show_about_me_for(@user) %>"
    when "[avatar-url]"
      "<%= image_tag @user.photo.url(:large_thumb) %>"
    when "[rss-url]"
      "<%= show_rss_for(@user) %>"
    when "[tagline]"
      "<%= render_tag_line(@user) %>"
    when "[contact-form]"
      "<%= show_contact_form_for(@user) %>" 
    end
  end
end

class PieceObject
  
  def self.determine_output_for(input_string)
    case input_string
    when "[piece-title]"
      "<%=h piece.title %>"
    when "[piece-image]"
      "<%= image_tag piece.image_1.url, :title => piece.title %>"
    when "[piece-gallery]"
      "<%= render :partial => 'pieces/piece', :object => piece %>"
    when "[piece-about]"
      "<%=h piece.description %>"
    when "[piece-client]"
      "<%=h piece.client_name %>"
    when "[piece-service]"
      "<%=h piece.service_type %>"
    when "[piece-price]"
      "<%=h piece.display_price %>"
    when "[sale-url]"
      "<%=h piece.sale_url %>"
    when "[piece-meta]"
      "<%= show_meta_for(piece) %>"
    when "[if:portfolio-pieces]"
      "<% unless @portfolio.pieces.blank? %>
        <% @portfolio.pieces.each do |piece|%>"
    end
  end
end

class GlobalObject
  
  def self.determine_output_for(input_string)
    case input_string
    when "[end]"
      "<% end %>"
    end
  end
end
