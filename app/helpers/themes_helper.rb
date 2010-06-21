module ThemesHelper
  def show_install_for(user, theme)
    if user.design.theme.id == theme.id
      link_to "Uninstall", uninstall_theme_path(theme), :class => "button install"
    else
      link_to "Install", install_theme_path(theme), :class => "button install"
    end
  end
    
end
