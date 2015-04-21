class Order < ActiveRecord::Base
  belongs_to :user
  after_create :mail

  private
  def mail
    NoticeMailer.product(self).deliver
  end
end
