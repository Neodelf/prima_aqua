class PhoneCall < ActiveRecord::Base
  after_commit :mail, on: :create

  private
  def mail
    NoticeMailer.call(self).deliver
  end
end