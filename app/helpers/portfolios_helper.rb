module PortfoliosHelper
  def show_rss_for(user)
    %{
      <a href="#{user_portfolio_path(user.login)}.rss">RSS!</a>
    }
  end
  
  def show_meta_for(piece)
    %{<ul class="thumb-grid">
    <li class="client">#{piece.client_name}</li>
    <li class="service">#{piece.service_type}</li>
		<li class="url"><a href="#{piece.sale_url}" target="_blank">http://kevinjohngomez.bigcartel.com</a></li>
		<li class="buy"><a href="#{piece.sale_url}" target="_blank">$20.00</a></li>
		</ul>}
  end
end
