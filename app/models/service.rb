class Service < ActiveRecord::Base
  after_create :mail

  private
  def mail
    NoticeMailer.service(self).deliver
  end
end