# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20090810173514) do

  create_table "designs", :force => true do |t|
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "background_color",          :default => "#dedddb"
    t.string   "background_align",          :default => "center"
    t.string   "background_tile",           :default => "repeat"
    t.string   "page_bg_color",             :default => "#fff"
    t.string   "link_color",                :default => "#72b225"
    t.string   "link_hover_color",          :default => "#242420"
    t.string   "link_img_border_color",     :default => "#f5f4f4"
    t.string   "text_color",                :default => "#767574"
    t.string   "text_font_1",               :default => "Arial"
    t.string   "text_font_2",               :default => "Helvetica"
    t.boolean  "text_serif",                :default => false
    t.string   "title_color",               :default => "#242420"
    t.boolean  "title_bold",                :default => false
    t.boolean  "title_italic",              :default => false
    t.string   "title_font",                :default => "Georgia"
    t.boolean  "title_serif",               :default => true
    t.string   "tagline_color",             :default => "#242420"
    t.boolean  "tagline_bold",              :default => false
    t.boolean  "tagline_italic",            :default => false
    t.string   "tagline_font",              :default => "Georgia"
    t.boolean  "tagline_serif",             :default => true
    t.string   "border_color",              :default => "#eee"
    t.string   "header_image_file_name"
    t.string   "header_image_content_type"
    t.integer  "header_image_file_size"
    t.datetime "header_image_updated_at"
    t.text     "css_text",                  :default => "'''''''''''''''''''''''''''''''body {\n    \tmargin: 20px;\n    \tbackground-color: #dedddb; /*---Background: Color---*/\n    \tbackground-position: top; /*---Background: Alignment---*/\n    \tbackground-image: none; /*---Background: Image---*/\n    \tbackground-repeat: repeat; /*---Background: Tile---*/\n    \tfont-family: Arial, Helvetica, sans-serif; /*---Text: Font---*/\n    \tfont-size: 12px; /*---Text: Size---*/\n    \tcolor: #767574; /*---Text: Color---*/\n    \tline-height: 150%;\n    \t}\n\n    a:link,\n    a:visited {\n    \tcolor: #72b225; /*---Links: Color---*/\n    \t}\n\n    a:hover,\n    a:visited:hover {\n    \tcolor: #242420; /*---Text: Color---*/\n    \t}\n\n    h1 {\n    \tfont-size: ; /*---Tagline: Size---*/\n    \tcolor: #242420; /*---Tagline: Color---*/\n    \tfont-family: Georgia, serif; /*---Tagline: Font---*/\n    \tfont-weight: normal; /*---Tagline: Bold---*/\n    \tfont-style: normal; /*---Tagline: Italic---*/\n    \t}\n\n    h2, h3, h4, h5, h6 {\n    \tcolor: #242420; /*---Titles: Color---*/\n    \tfont-family: Georgia, serif; /*---Titles: Font---*/\n    \tfont-weight: normal; /*---Titles: Bold---*/\n    \tfont-style: normal; /*---Titles: Italic---*/\n    \t}\n\n    hr {\n    \tborder: 0;\n    \theight: 1px;\n    \tbackground: #eee; /*---Border: Color---*/\n    \tmargin: 20px 0;\n    \t}\n\n    a:link img, a:visited img {\n    \tdisplay: block;\n    \tborder: 5px solid #f5f4f4; /*---Border: Color---*/\n    \t}\n\n    a:hover img, a:visited:hover img {\t\n    \tborder: 5px solid #72b225; /*---Link: Color---*/\n    \t}\n\n\n    /*---STRUCTURE---*/\n\n    div#page-container {\n    \tmargin: 0 auto;\n    \twidth: 710px;\n    \tbackground: #fff; /*---Page: Background Color---*/\n    \toverflow: hidden;\n    \tpadding: 20px;\n    \t-webkit-border-radius: 10px;\n    \t}\n\n    div#header-container {\n    \toverflow: hidden;\n    \tmargin: 0 0 20px 0;\n    \t}\n\n    div#tagline-container {\n    \toverflow: hidden;\n    \ttext-align: left;\n    \t}\n\n    div#info-container {\n    \toverflow: hidden;\n    \t}\n\n    div#about-container {\n    \twidth: 345px;\n    \tmargin: 0 0 20px 0;\n    \toverflow: hidden;\n    \tfloat: left;\n    \t}\n\n    div#contact-container {\n    \twidth: 345px;\n    \tmargin: 0;\n    \toverflow: hidden;\n    \tfloat: right;\n    \t}'''''''''''''''''''''''''''''''"
    t.string   "text_size",                 :default => "12"
    t.string   "tagline_size"
    t.integer  "layout_type",               :default => 1
  end

  create_table "pieces", :force => true do |t|
    t.string   "title"
    t.string   "description"
    t.decimal  "price",                :precision => 10, :scale => 2
    t.boolean  "for_sale"
    t.integer  "portfolio_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "image_2_file_name"
    t.string   "image_2_content_type"
    t.integer  "image_2_file_size"
    t.datetime "image_2_updated_at"
    t.string   "image_3_file_name"
    t.string   "image_3_content_type"
    t.integer  "image_3_file_size"
    t.datetime "image_3_updated_at"
    t.string   "image_4_file_name"
    t.string   "image_4_content_type"
    t.integer  "image_4_file_size"
    t.datetime "image_4_updated_at"
    t.string   "image_5_file_name"
    t.string   "image_5_content_type"
    t.integer  "image_5_file_size"
    t.datetime "image_5_updated_at"
    t.string   "image_1_file_name"
    t.string   "image_1_content_type"
    t.integer  "image_1_file_size"
    t.datetime "image_1_updated_at"
    t.integer  "position"
  end

  create_table "portfolios", :force => true do |t|
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "login",                     :limit => 40
    t.string   "name",                      :limit => 100, :default => ""
    t.string   "email",                     :limit => 100
    t.string   "crypted_password",          :limit => 40
    t.string   "salt",                      :limit => 40
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "remember_token",            :limit => 40
    t.datetime "remember_token_expires_at"
    t.string   "activation_code",           :limit => 40
    t.datetime "activated_at"
    t.string   "first_name"
    t.string   "last_name"
    t.text     "about_me"
    t.string   "tag_line",                  :limit => 500
    t.integer  "account_tier",                             :default => 1
    t.string   "photo_file_name"
    t.string   "photo_content_type"
    t.integer  "photo_file_size"
    t.datetime "photo_updated_at"
    t.integer  "design_type",                              :default => 1
    t.boolean  "has_read_terms",                           :default => false
  end

  add_index "users", ["login"], :name => "index_users_on_login", :unique => true

end
