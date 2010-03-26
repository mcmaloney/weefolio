module PortfoliosHelper
  def show_rss_for(user)
    %{
      <a href="#{user_portfolio_path(user, user.portfolio)}.rss">RSS!</a>
    }
  end
end
