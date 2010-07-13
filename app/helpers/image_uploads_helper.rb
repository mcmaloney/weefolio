module ImageUploadsHelper
  def show_add_image(piece)
    if piece.can_add_more_images?
      "#{link_to "Add Image +", new_piece_image_upload_path(@piece)}"
    end
  end
end
