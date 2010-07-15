module ThemesHelper
  def show_install_for(user, theme)
    if user.design.theme
      if user.design.theme.id == theme.id
        link_to "Uninstall", uninstall_theme_path(theme), :class => "secondary-button install"
      end
    else
      link_to "Install", install_theme_path(theme), :class => "secondary-button install"
    end
  end
    
end
