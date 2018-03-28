class CreateBtcPrices < ActiveRecord::Migration[5.1]
  def change
    create_table :btc_prices do |t|
      t.string :name, limit: 50 # Bitcoin
	  t.string :symbol, limit: 5 # BTC
	  t.float :price_btc # BTC price
      t.float :price_usd # BTC price
	  t.float :market_cap_usd # USD total
	  t.float :total_supply, limit: 4 # BTC total
      t.float :available_supply, limit: 4 # Available BTC total
      t.float :max_supply, null: true # Maximum BTC for supply
      t.integer :last_updated # Unix timestamps

      # t.timestamps
	end
	add_index :btc_prices, :name
	add_index :btc_prices, :symbol
	add_index :btc_prices, :price_btc
	add_index :btc_prices, :price_usd
  end
end
