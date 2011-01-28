class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
      # Twitter
      t.string :twitter_uid
      t.string :name
      t.string :screen_name
      t.string :avatar_url
      
      # OAuth
      t.string :oauth_token
      t.string :oauth_secret

      # AuthLogic
      # t.string :login
      # t.string :crypted_password
      # t.string :password_salt
      t.string :persistence_token, :null => false
      t.string :single_access_token, :null => false
      t.string :perishable_token, :null => false

      # AuthLogic Magic Columns
      t.integer :login_count, :null => false, :default => 0
      t.integer :failed_login_count, :null => false, :default => 0
      t.datetime :last_request_at
      t.datetime :current_login_at
      t.datetime :last_login_at
      t.string :current_login_ip
      t.string :last_login_ip

      t.timestamps
    end
  end

  def self.down
    drop_table :users
  end
end
