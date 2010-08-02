xml.instruct! :xml, :version => "1.0"
xml.rss :version => "2.0" do
  xml.channel do
    xml.title "#{@user.login}'s WeeFeed"
    xml.description "Everything new from #{@user.login}'s Weefolio."
    xml.link user_portfolio_path(@user, :rss)
    
    @portfolio.pieces.each do |piece|
      xml.item do
        xml.title piece.title
        unless piece.image_uploads.blank?
          xml.description (image_tag piece.image_uploads.first.image.url(:full_size)) + "<br /> <p>#{piece.description}</p>"
        end
      end
    end
  end
end
