class AddIdentityUrlToQuestionAndAnswer < ActiveRecord::Migration
  def self.up
    add_column :questions, :identity_url, :string
    add_column :answers, :identity_url, :string
  end

  def self.down
    remove_column :questions, :identity_url
    remove_column :answers, :identity_url
  end
end
