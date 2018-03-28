# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20180327174713) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "btc_prices", force: :cascade do |t|
    t.string "name", limit: 50
    t.string "symbol", limit: 5
    t.float "price_btc"
    t.float "price_usd"
    t.float "market_cap_usd"
    t.float "total_supply"
    t.float "available_supply"
    t.float "max_supply"
    t.integer "last_updated"
    t.index ["name"], name: "index_btc_prices_on_name"
    t.index ["price_btc"], name: "index_btc_prices_on_price_btc"
    t.index ["price_usd"], name: "index_btc_prices_on_price_usd"
    t.index ["symbol"], name: "index_btc_prices_on_symbol"
  end

end
