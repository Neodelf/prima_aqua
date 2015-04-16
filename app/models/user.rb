class User < ActiveRecord::Base
  has_many :orders
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  enum customer_type: [:individual, :company]

  def company?
    customer_type == 'company'
  end

  def individual?
    customer_type == 'individual'
  end
end
