class PhoneCall < ActiveRecord::Base
  after_create :mail

  private
  def mail
    NoticeMailer.call(self).deliver
  end
end