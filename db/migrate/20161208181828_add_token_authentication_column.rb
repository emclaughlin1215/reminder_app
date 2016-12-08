class AddTokenAuthenticationColumn < ActiveRecord::Migration[5.0]
  def self.up
    change_table :users do |t|
      t.token_authenticatable
    end
  end
  def self.down
    t.remove :authentication_token
  end
end
