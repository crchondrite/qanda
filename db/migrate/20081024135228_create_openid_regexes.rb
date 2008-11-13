class CreateOpenidRegexes < ActiveRecord::Migration
  def self.up
    create_table :openid_regexes do |t|
      t.string :regex

      t.timestamps
    end
  end

  def self.down
    drop_table :openid_regexes
  end
end
