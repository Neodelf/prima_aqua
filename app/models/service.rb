class Service < ActiveRecord::Base
  after_commit :mail, on: :create

  private
  def mail
    NoticeMailer.service(self).deliver
  end
end