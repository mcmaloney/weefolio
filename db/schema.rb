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

ActiveRecord::Schema.define(:version => 20100906185155) do

  create_table "delayed_jobs", :force => true do |t|
    t.integer  "priority",   :default => 0
    t.integer  "attempts",   :default => 0
    t.text     "handler"
    t.text     "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "designs", :force => true do |t|
    t.integer  "user_id"
    t.integer  "layout_type",                   :default => 1
    t.string   "header_image_file_name"
    t.string   "header_image_content_type"
    t.integer  "header_image_file_size"
    t.datetime "header_image_updated_at"
    t.string   "background_color",              :default => "f5f5f3"
    t.string   "text_color",                    :default => "767574"
    t.string   "title_color",                   :default => "242420"
    t.string   "link_color",                    :default => "9fcf44"
    t.string   "link_hover_color",              :default => "242420"
    t.string   "header_color",                  :default => "242420"
    t.string   "font_family",                   :default => "Lucida Grande"
    t.integer  "font_size",                     :default => 11
    t.string   "border_color",                  :default => "dcdcda"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "browser_html"
    t.text     "user_html"
    t.integer  "theme_id"
    t.string   "background_image_file_name"
    t.string   "background_image_content_type"
    t.integer  "background_image_file_size"
    t.datetime "background_image_updated_at"
    t.string   "background_orientation"
  end

  create_table "image_uploads", :force => true do |t|
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.integer  "piece_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "pieces", :force => true do |t|
    t.string   "title"
    t.text     "description"
    t.decimal  "price",        :precision => 10, :scale => 2
    t.boolean  "for_sale"
    t.integer  "portfolio_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "position"
    t.string   "sale_url"
    t.string   "client_name"
    t.string   "service_type"
  end

  create_table "plans", :force => true do |t|
    t.integer  "user_id"
    t.integer  "level"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "card_expiration_month"
    t.string   "card_expiration_year"
    t.string   "card_type"
    t.string   "billing_first_name"
    t.string   "billing_last_name"
    t.string   "billing_address"
    t.string   "billing_address_2"
    t.string   "billing_city"
    t.string   "billing_state"
    t.string   "billing_postal_code"
    t.string   "card_last_four"
    t.string   "gateway_response"
    t.string   "payment_status"
    t.integer  "amount_in_cents"
  end

  create_table "portfolios", :force => true do |t|
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "login"
    t.string   "permalink"
  end

  create_table "posts", :force => true do |t|
    t.string   "title"
    t.text     "body"
    t.string   "author"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "simple_captcha_data", :force => true do |t|
    t.string   "key",        :limit => 40
    t.string   "value",      :limit => 6
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "theme_uploads", :force => true do |t|
    t.string   "title"
    t.text     "source_code"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "screenshot_file_name"
    t.string   "screenshot_content_type"
    t.integer  "screenshot_file_size"
    t.datetime "screenshot_updated_at"
    t.string   "asset_package_file_name"
    t.string   "asset_package_content_type"
    t.integer  "asset_package_file_size"
    t.datetime "asset_package_updated_at"
    t.integer  "user_id"
  end

  create_table "themes", :force => true do |t|
    t.string   "directory_name"
    t.string   "template_filename"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "photo_file_name"
    t.string   "photo_content_type"
    t.integer  "photo_file_size"
    t.datetime "photo_updated_at"
    t.string   "name"
    t.text     "description"
    t.string   "author_name"
  end

  create_table "user_mailers", :force => true do |t|
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
    t.text     "about_me"
    t.string   "tag_line",                  :limit => 500
    t.string   "photo_file_name"
    t.string   "photo_content_type"
    t.integer  "photo_file_size"
    t.datetime "photo_updated_at"
    t.integer  "design_type",                              :default => 1
    t.boolean  "admin_user",                               :default => false
    t.string   "address1"
    t.string   "address2"
    t.string   "city"
    t.string   "state"
    t.string   "country"
    t.string   "zip"
  end

  add_index "users", ["login"], :name => "index_users_on_login", :unique => true

end
