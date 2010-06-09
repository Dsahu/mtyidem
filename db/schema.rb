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

ActiveRecord::Schema.define(:version => 20100607214102) do

  create_table "camp_pics", :force => true do |t|
    t.string   "path"
    t.string   "name"
    t.integer  "campaign_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "camp_units", :force => true do |t|
    t.integer  "campaign_id"
    t.string   "name"
    t.text     "description"
    t.string   "path"
    t.integer  "image_where"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "campaigns", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.integer  "mode"
    t.string   "title"
    t.string   "subtitle"
    t.string   "link"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "path"
  end

  create_table "convocatoriaunits", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.integer  "ordernum"
    t.integer  "run_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "diploma_elements", :force => true do |t|
    t.integer  "font_size"
    t.string   "font_weight"
    t.string   "font_family"
    t.integer  "pos_x"
    t.integer  "pos_y"
    t.boolean  "is_italic"
    t.string   "column_name"
    t.integer  "diploma_schema_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "diploma_schemas", :force => true do |t|
    t.integer  "run_id"
    t.integer  "size_x"
    t.integer  "size_y"
    t.string   "photopath"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "emails", :force => true do |t|
    t.string   "name"
    t.string   "description"
    t.integer  "from_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "events", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.integer  "organizator_id"
    t.boolean  "idemserial"
    t.string   "phone"
    t.string   "location"
    t.boolean  "visible"
    t.date     "when"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "run_id"
  end

  create_table "friend_requests", :force => true do |t|
    t.integer  "inviter_id"
    t.integer  "other_id"
    t.integer  "status"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "friendrelations", :force => true do |t|
    t.integer  "inviter_id"
    t.integer  "other_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "gp_datas", :force => true do |t|
    t.integer  "grandprix_id"
    t.string   "name"
    t.integer  "accum"
    t.boolean  "particip1"
    t.boolean  "particip2"
    t.boolean  "particip3"
    t.boolean  "particip4"
    t.boolean  "particip5"
    t.boolean  "particip6"
    t.boolean  "particip7"
    t.boolean  "particip8"
    t.boolean  "particip9"
    t.boolean  "particip10"
    t.boolean  "particip11"
    t.boolean  "particip12"
    t.boolean  "particip13"
    t.boolean  "particip14"
    t.boolean  "particip15"
    t.boolean  "particip16"
    t.boolean  "particip17"
    t.boolean  "particip18"
    t.boolean  "particip19"
    t.boolean  "particip20"
    t.boolean  "particip21"
    t.boolean  "particip22"
    t.boolean  "particip23"
    t.boolean  "particip24"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "grandprixes", :force => true do |t|
    t.string   "name"
    t.string   "name1"
    t.string   "name2"
    t.string   "name3"
    t.string   "name4"
    t.string   "name5"
    t.string   "name6"
    t.string   "name7"
    t.string   "name8"
    t.string   "name9"
    t.string   "name10"
    t.string   "name11"
    t.string   "name12"
    t.string   "name13"
    t.string   "name14"
    t.string   "name15"
    t.string   "name16"
    t.string   "name17"
    t.string   "name18"
    t.string   "name19"
    t.string   "name20"
    t.string   "name21"
    t.string   "name22"
    t.string   "name23"
    t.string   "name24"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "ins_stores", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.integer  "store_id"
    t.integer  "run_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "inscriptions", :force => true do |t|
    t.integer  "user_id"
    t.integer  "paidfrom_id"
    t.integer  "amount",             :limit => 10, :precision => 10, :scale => 0
    t.datetime "signed_at"
    t.datetime "completed_at"
    t.integer  "run_id"
    t.text     "description"
    t.integer  "runevent_id"
    t.string   "status"
    t.integer  "statuscode"
    t.integer  "dresssize"
    t.integer  "age_at_inscription"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "firstname"
    t.string   "lastname"
    t.integer  "age"
    t.string   "email"
    t.boolean  "sex",                                                             :default => true
    t.integer  "ficha"
    t.string   "club"
    t.string   "phone"
    t.integer  "runner_category_id"
    t.string   "color"
    t.string   "city"
    t.date     "ins_date"
    t.integer  "ins_store_id"
  end

  create_table "invitation_inputs", :force => true do |t|
    t.integer  "user_id"
    t.string   "input",      :limit => 512
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "invitations", :force => true do |t|
    t.integer  "user_id"
    t.string   "email"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "links", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.string   "url"
    t.string   "photo"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "logins", :force => true do |t|
    t.string   "email"
    t.string   "password"
    t.boolean  "failed",     :default => false
    t.string   "ipaddr"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "organizators", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.text     "address"
    t.string   "phone"
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "payconds", :force => true do |t|
    t.integer  "runevent_id"
    t.decimal  "amount",       :precision => 10, :scale => 2
    t.decimal  "amount_extra", :precision => 10, :scale => 2
    t.integer  "from_age",                                    :default => 0
    t.integer  "to_age",                                      :default => 99
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "sexmode",                                     :default => 1
  end

  create_table "payment_notifications", :force => true do |t|
    t.text     "params"
    t.integer  "inscription_id"
    t.string   "status"
    t.string   "transaction_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "purchased_at"
  end

  create_table "picturecomments", :force => true do |t|
    t.integer  "picture_id"
    t.integer  "user_id"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "pictures", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.integer  "upload_by_user_id"
    t.string   "path"
    t.integer  "run_id"
    t.boolean  "visible"
    t.integer  "counter"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "width"
    t.integer  "height"
    t.string   "s_path"
    t.string   "m_path"
    t.string   "l_path"
  end

  create_table "responses", :force => true do |t|
    t.integer  "wallevent_id"
    t.integer  "user_id"
    t.integer  "by_user_id"
    t.text     "description"
    t.integer  "result_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "results", :force => true do |t|
    t.integer  "num"
    t.string   "cat"
    t.integer  "user_id"
    t.string   "firstname"
    t.string   "lastname"
    t.integer  "edad"
    t.string   "clubcustom"
    t.integer  "time_in_seconds"
    t.integer  "time_chip_in_seconds"
    t.integer  "rank_general"
    t.integer  "rank_rama"
    t.integer  "rank_cat"
    t.integer  "paso_in_seconds"
    t.integer  "run_id"
    t.integer  "part_1"
    t.integer  "part_2"
    t.integer  "part_3"
    t.integer  "part_4"
    t.integer  "part_5"
    t.integer  "part_6"
    t.integer  "part_7"
    t.integer  "part_8"
    t.integer  "part_9"
    t.integer  "part_10"
    t.integer  "pause_1"
    t.integer  "pause_2"
    t.integer  "pause_3"
    t.integer  "pause_4"
    t.integer  "pause_5"
    t.integer  "pause_6"
    t.integer  "pause_7"
    t.integer  "pause_8"
    t.integer  "pause_9"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "club"
    t.string   "custom_run_name"
    t.integer  "custom_all_runners"
    t.integer  "custom_all_male"
    t.integer  "custom_all_female"
    t.integer  "custom_all_category"
    t.boolean  "is_custom",                                           :default => false
    t.date     "custom_date"
    t.decimal  "custom_run_distance",   :precision => 5, :scale => 2, :default => 0.0
    t.string   "custom_run_logo"
    t.integer  "time_chip_in_seconds1",                               :default => 0
    t.integer  "time_chip_in_seconds2",                               :default => 0
    t.integer  "paso_in_seconds1",                                    :default => 0
    t.integer  "paso_in_seconds2",                                    :default => 0
  end

  create_table "runevents", :force => true do |t|
    t.integer  "run_id"
    t.string   "name"
    t.text     "description"
    t.decimal  "default_amount",       :precision => 10, :scale => 2
    t.decimal  "default_amount_extra", :precision => 10, :scale => 2
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "runner_categories", :force => true do |t|
    t.string   "name"
    t.integer  "run_id"
    t.integer  "from_age"
    t.integer  "to_age"
    t.integer  "sex_mode"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "color"
  end

  create_table "runs", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.date     "eventday"
    t.date     "lastregisterday"
    t.string   "location"
    t.integer  "distance"
    t.integer  "electronicservicequote", :limit => 10, :precision => 10, :scale => 0
    t.boolean  "showincarrusel"
    t.boolean  "showresults"
    t.integer  "fichastart"
    t.integer  "fichaend"
    t.boolean  "inscriptionopen"
    t.integer  "runtype_id"
    t.string   "flickrlink"
    t.text     "convocatoria"
    t.text     "descriptionadicional"
    t.string   "mainphoto"
    t.string   "diplomphoto"
    t.string   "sponsoringphoto"
    t.string   "mapphoto"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "participantcount"
    t.string   "logophoto"
    t.boolean  "showvideos"
    t.boolean  "showphotos"
    t.integer  "last_ficha"
    t.string   "partial_name_time1",                                                  :default => ""
    t.string   "partial_name_time2",                                                  :default => ""
    t.string   "shirtphoto"
    t.string   "medaillephoto"
    t.string   "trofeophoto"
    t.string   "rifaphoto"
    t.string   "altimetrophoto"
  end

  create_table "runtypes", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.integer  "parts"
    t.string   "part_name_1"
    t.string   "part_name_2"
    t.string   "part_name_3"
    t.string   "part_name_4"
    t.string   "part_name_5"
    t.string   "part_name_6"
    t.string   "part_name_7"
    t.string   "part_name_8"
    t.string   "part_name_9"
    t.string   "part_name_10"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "store_groups", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "stores", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "stores_in_groups", :force => true do |t|
    t.integer  "store_id"
    t.integer  "store_group_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "user_result_assignments", :force => true do |t|
    t.integer  "user_id"
    t.integer  "result_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "run_id"
  end

  create_table "userpictureassignments", :force => true do |t|
    t.integer  "picture_id"
    t.integer  "user_id"
    t.integer  "tagged_by_user_id"
    t.integer  "cor_x"
    t.integer  "cor_y"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "login"
    t.string   "email"
    t.string   "crypted_password",          :limit => 40
    t.string   "salt",                      :limit => 40
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "remember_token"
    t.datetime "remember_token_expires_at"
    t.string   "activation_code",           :limit => 40
    t.datetime "activated_at"
    t.string   "firstname"
    t.string   "lastname"
    t.string   "street1"
    t.string   "street2"
    t.string   "zip"
    t.string   "city"
    t.integer  "state_id"
    t.integer  "country_id"
    t.boolean  "is_idem_admin"
    t.date     "bday"
    t.string   "profilepic"
    t.integer  "default_dress_size"
    t.boolean  "sex",                                     :default => true
    t.string   "club"
    t.string   "s_profilepic"
  end

  create_table "uservideoassignments", :force => true do |t|
    t.integer  "video_id"
    t.integer  "user_id"
    t.integer  "tagged_by_user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "videocomments", :force => true do |t|
    t.integer  "video_id"
    t.integer  "user_id"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "videos", :force => true do |t|
    t.string   "name"
    t.string   "path"
    t.boolean  "is_start"
    t.integer  "run_id"
    t.boolean  "visible"
    t.integer  "counter"
    t.integer  "upload_by_user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "wallevents", :force => true do |t|
    t.integer  "we_type"
    t.string   "name",                     :limit => 512
    t.text     "description"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "otheruser_id"
    t.integer  "run_id"
    t.integer  "picture_id"
    t.integer  "video_id"
    t.integer  "group_id"
    t.integer  "userpictureassignment_id"
    t.integer  "uservideoassignment_id"
  end

end
