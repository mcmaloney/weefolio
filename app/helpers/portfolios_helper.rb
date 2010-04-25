module PortfoliosHelper
  def show_rss_for(user)
    %{
      <a href="#{user_portfolio_path(user.login)}.rss">RSS!</a>
    }
  end
  
  def show_meta_for(piece)
    %{<ul>}
    unless piece.client_name.blank?
      %{<li class="client">#{piece.client_name}</li>}
    end
    unless piece.service_type.blank?
      %{<li class="service">#{piece.service_type}</li>}
    end
    unless piece.sale_url.blank?
		  %{<li class="url"><a href="#{piece.sale_url}" target="_blank">http://kevinjohngomez.bigcartel.com</a></li>}
		  %{<li class="buy"><a href="#{piece.sale_url}" target="_blank">$20.00</a></li>}
		end
		%{</ul>}
  end
end
