class AddCssVariablesToDesign < ActiveRecord::Migration
  def self.up
    add_column :designs, :background_color, :string, :default => "f5f5f3"
    add_column :designs, :background_align, :string, :default => "center"
    add_column :designs, :background_tile, :string, :default => "repeat"
    add_column :designs, :page_bg_color, :string, :default => "fff"
    add_column :designs, :link_color, :string, :default => "72b225"
    add_column :designs, :link_hover_color, :string, :default => "242420"
    add_column :designs, :link_img_border_color, :string, :default => "f5f4f4"
    add_column :designs, :text_color, :string, :default => "767574"
    add_column :designs, :text_size, :integer, :default => 12
    add_column :designs, :text_font_1, :string, :default => "Arial"
    add_column :designs, :text_font_2, :string, :default => "Helvetica"
    add_column :designs, :text_serif, :boolean, :default => false
    add_column :designs, :title_color, :string, :default => "242420"
    add_column :designs, :title_bold, :boolean, :default => false
    add_column :designs, :title_italic, :boolean, :default => false
    add_column :designs, :title_font, :string, :default => "Georgia"
    add_column :designs, :title_serif, :boolean, :default => true
    add_column :designs, :tagline_size, :integer
    add_column :designs, :tagline_color, :string, :default => "72b225"
    add_column :designs, :tagline_bold, :boolean, :default => false
    add_column :designs, :tagline_italic, :boolean, :default => false
    add_column :designs, :tagline_font, :string, :default => "Georgia"
    add_column :designs, :tagline_serif, :boolean, :default => true
    add_column :designs, :border_color, :string, :default => "eee"
  end

  def self.down
    remove_column :designs, :background_color
    remove_column :designs, :background_align
    remove_column :designs, :background_tile
    remove_column :designs, :page_bg_color
    remove_column :designs, :link_color
    remove_column :designs, :link_hover_color
    remove_column :designs, :link_img_border_color
    remove_column :designs, :text_color
    remove_column :designs, :text_size
    remove_column :designs, :text_font_1
    remove_column :designs, :text_font_2
    remove_column :designs, :text_serif
    remove_column :designs, :title_color
    remove_column :designs, :title_bold
    remove_column :designs, :title_italic
    remove_column :designs, :title_font
    remove_column :designs, :title_serif
    remove_column :designs, :tagline_size
    remove_column :designs, :tagline_color
    remove_column :designs, :tagline_bold
    remove_column :designs, :tagline_italic
    remove_column :designs, :tagline_font
    remove_column :designs, :tagline_serif
    remove_column :designs, :border_color
  end
end
