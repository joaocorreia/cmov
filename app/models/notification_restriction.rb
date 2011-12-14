class NotificationRestriction < ActiveRecord::Base
  belongs_to :user
  after_initialize :default_values

  private
    def default_values
      self.minimumPrice ||= 0.0
	  self.maximumPrice ||= 3000000.0
    end

end
