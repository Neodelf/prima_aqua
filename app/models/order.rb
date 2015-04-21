class Order < ActiveRecord::Base
  belongs_to :user
  after_commit :mail, on: :create

  private
  def mail
    NoticeMailer.product(self).deliver
  end
end
