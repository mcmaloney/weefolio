module WeeParser
  CSS_DICT = ["color", "background", "font", "size", "text", "hover", "link", "title"]
  USER_DICT = ["header", "image", "contact", "form", "about", "me", "tagline", "rss", "url"]
  PIECE_DICT = ["piece", "pieces", "portfolio", "image", "gallery", "about", "client", "service", "for", "sale", "url"]
  THRESH = 0.75
  
  def self.parse(string)
    i = 0
    o = 0
    subs = []
    while string.include?("]") && string.include?("]")
      i = string.index("[")
      o = string.index("]")
      subs << string[i..o]
      string = string[o+1..string.length]
    end
    subs
  end
  
  # Is this tag a CSSObject?
  def classify_as_css(substring)
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
  def classify_as_user(substring)
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
  def classify_as_piece(substring)
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
  
  # Are enough of the words in this tag having to do with the associated dictionary?
  def evaluate_classification_score_for(score, string)
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
    else
      false
    end
  end
  
  class CSSObject

    def self.determine_output_for(input_string)
      case input_string
      when "[background-color]"
        "<%=h @design.background_color %>"
      when "[text-color]"
        "<%=h @design.text_color %>"
      when "[font]"
        "<%=h @design.font %>"
      when "[font-family]"
        "<%=h @design.font_family %>"
      when "[link_color]"
        "<%=h @design.link_color %>"
      when "[title-color]"
        "<%=h @design.title_color %>"
      when "[header-background]"
        "<%=h @design.header_background %>"
      when "[header-image]"
        "<%= render :partial => 'shared/header_image' %>"
      end
    end

  end
  
  class UserObject

    def self.determine_output_for(input_string)
      case input_string
      when "[about-me]"
        "<%= show_about_me_for(@user) %>"
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
      when "[piece-image]"
        "<%= link_to image_tag(piece.image_1.url(:large_thumb)), portfolio_piece_path(@portfolio, piece), :title => piece.title %>"
      when "[piece-gallery]"
        "WHATEVER"
      when "[piece-about]"
        "<%=h @piece.description %>"
      when "[piece-client]"
        "<%=h @piece.client_name %>"
      when "[piece-service]"
        "<%=h @piece.service_type %>"
      when "[piece-price]"
        "<%=h @piece.display_price %>"
      when "[sale-url]"
        "<%=h @piece.sale_url %>"
      end
    end
  end
end