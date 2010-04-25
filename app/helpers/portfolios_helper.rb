module PortfoliosHelper
  def show_rss_for(user)
    %{
      <a href="#{user_portfolio_path(user.login)}.rss">RSS!</a>
    }
  end
end
