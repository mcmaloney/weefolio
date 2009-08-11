module NavigationHelpers
  # Maps a name to a path. Used by the
  #
  #   When /^I go to (.+)$/ do |page_name|
  #
  # step definition in webrat_steps.rb
  #
  def path_to(page_name)
    case page_name
    
    when /the home page/
      root_path
    when /contact page/
      contact_path
    when /directory page/
      directory_path
    when /help page/
      help_path
    when /the sign up page/
      signup_path
    when /the login page/
      login_path
    when /my portfolio page/
      user = User.find_by_login("mcmaloney")
      edit_user_portfolio_path(user, user.portfolio)
    when /^the account page for "(.*)"$/i
      edit_user_path(User.find_by_login($1))
    when /^the edit piece page for "(.*)"$/i
      user = User.find_by_login("mcmaloney")
      edit_portfolio_piece_path(user.portfolio, Piece.find_by_title($1))
    when /the page for my weefolio/
      user = User.find_by_login("mcmaloney")
      user_portfolio_path(user, user.portfolio)
    when /my design editor page/
      user = User.find_by_login("mcmaloney")
      edit_user_design_path(user, user.design)
    when /^the piece page for "(.*)"$/i
      portfolio_piece_path(@user.portfolio, Piece.find_by_title($1))
    when /the users admin page/
      users_admin_path
    when /the pieces admin page/
      pieces_admin_path
    when /the blog page/
      posts_path
    when /^the post page for "(.*)"$/i
      post_path(Post.find_by_title($1))
      
    
    # Add more mappings here.
    # Here is a more fancy example:
    #
    #   when /^(.*)'s profile page$/i
    #     user_profile_path(User.find_by_login($1))

    else
      raise "Can't find mapping from \"#{page_name}\" to a path.\n" +
        "Now, go and add a mapping in #{__FILE__}"
    end
  end
end

World(NavigationHelpers)
