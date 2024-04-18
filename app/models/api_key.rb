class ApiKey < ActiveRecord::Base
  before_create :generate_access_token

  private

  def generate_access_token
    begin
      self.access_token = SecureRandom.hex
    end while self.class.exist?(access_token: access_token)
  end
end