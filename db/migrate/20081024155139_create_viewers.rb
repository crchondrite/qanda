class CreateViewers < ActiveRecord::Migration
  def self.up
    create_table :viewers do |t|
      t.references :question
      t.references :openid_regex

      t.timestamps
    end
  end

  def self.down
    drop_table :viewers
  end
end
