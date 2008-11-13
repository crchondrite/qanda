class Owner < ActiveRecord::Base
  belongs_to :question
  belongs_to :openid_regex
end
