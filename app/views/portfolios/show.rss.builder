xml.instruct! :xml, :version => "1.0"
xml.rss :version => "2.0" do
  xml.channel do
    xml.title "#{@user.login}'s WeeFeed"
    xml.description "Everything new from #{@user.login}'s Weefolio."
    xml.link user_portfolio_path(current_user, :rss)
    
    @portfolio.pieces.each do |piece|
      xml.item do
        xml.title piece.title
        xml.description image_tag(piece.image_1.url(:full_size)) + "<br /> <p>#{piece.description}</p>"
      end
    end
  end
end
