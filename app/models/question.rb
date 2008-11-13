class Question < ActiveRecord::Base
  has_many :answers
  has_many :owner_regexs, :through => :owners, :source => :openid_regex
  has_many :owners
  has_many :viewer_regexs, :through => :viewers, :source => :openid_regex
  has_many :viewers

  validates_presence_of :content
  validates_presence_of :identity_url

  def owner_regexs=(regexs_str)
    owner_regexs.build conversion_regex_str_to_rebex_hash(regexs_str)
  end

  def viewer_regexs=(regexs_str)
    viewer_regexs.build conversion_regex_str_to_rebex_hash(regexs_str)
  end

private
  def conversion_regex_str_to_rebex_hash(regexs_str)
    regexs = regexs_str ? regexs_str.split(',') : []

    attrs = regexs.map do |regex|
      { :regex => regex }
    end
    attrs
  end
end
