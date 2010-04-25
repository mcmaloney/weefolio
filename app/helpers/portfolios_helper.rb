module PortfoliosHelper
  def show_rss_for(user)
    %{
      <a href="#{user_portfolio_path(user.login)}.rss">RSS!</a>
    }
  end
  
  def show_meta_for(piece)
    html = "<ul>"
    unless piece.client_name.blank?
      html << "<li class='client'>#{piece.client_name}</li>"
    end
    unless piece.service_type.blank?
      html << "<li class='service'>#{piece.service_type}</li>"
    end
    if piece.for_sale?
      unless piece.sale_url.blank?
        html << "<li class='url'>#{link_to piece.sale_url, piece.sale_url}</li>"
      end
      unless piece.sale_url.blank? && piece.price.blank?
        html << "<li class='buy'>#{link_to number_to_currency(piece.price), piece.sale_url}</li>"
      end
    end
    html
  end
end
