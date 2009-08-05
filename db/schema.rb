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

ActiveRecord::Schema.define(:version => 20090805192452) do

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
    t.integer  "text_size",                 :default => 12
    t.string   "text_font_1",               :default => "Arial"
    t.string   "text_font_2",               :default => "Helvetica"
    t.boolean  "text_serif",                :default => false
    t.string   "title_color",               :default => "#242420"
    t.boolean  "title_bold",                :default => false
    t.boolean  "title_italic",              :default => false
    t.string   "title_font",                :default => "Georgia"
    t.boolean  "title_serif",               :default => true
    t.integer  "tagline_size"
    t.string   "tagline_color",             :default => "#242420"
    t.boolean  "tagline_bold",              :default => false
    t.boolean  "tagline_italic",            :default => false
    t.string   "tagline_font",              :default => "Georgia"
    t.boolean  "tagline_serif",             :default => true
    t.string   "border_color",              :default => "#eee"
    t.text     "css_text"
    t.string   "header_image_file_name"
    t.string   "header_image_content_type"
    t.integer  "header_image_file_size"
    t.datetime "header_image_updated_at"
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
    t.integer  "layout_type",                              :default => 1
    t.integer  "design_type",                              :default => 1
  end

  add_index "users", ["login"], :name => "index_users_on_login", :unique => true

end
