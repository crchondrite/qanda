class Viewer < ActiveRecord::Base
  belongs_to :question
  belongs_to :openid_regex
end
