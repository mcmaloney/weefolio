module PiecesHelper
  def form_title(object, default)
    if object.title
      content_tag(:h1, "Edit '#{object.title}'")
    else
      content_tag(:h1, "#{default}")
    end
  end
  
  def form_button(object, block)
    if object.title
      block.submit "Update"
    else
      block.submit "Create"
    end
  end
  
  def form_content(portfolio, piece)
    if piece.title
      render :partial => "fields"
    else
      if portfolio.can_add_more?
        render :partial => "fields"
      else
        content_tag(:p, "You have uploaded the maximum amount of pieces for your account type.")
      end
    end
  end
  
  def show_image_unless_new_record(piece, image)
    unless piece.new_record?
      %{
        #{image_tag image.url(:small_thumb)}
      }
    end
  end 
end
