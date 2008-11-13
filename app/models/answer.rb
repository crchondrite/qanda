class Answer < ActiveRecord::Base
  belongs_to :question

  validates_presence_of :identity_url

  def set_content(params)
    orign_params = params.dup
    orign_params.delete_if do |key, value|
      ["commit","authenticity_token", "action", "controller", "question_id"].include?(key)
    end
    self.content = orign_params.to_json
  end
end
