class User < ApplicationRecord
  extend Enumerize
  enumerize :role, in: %i[guest user admin], default: :guest

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable,
         :registerable,
         :recoverable,
         :rememberable,
         :trackable,
         :timeoutable,
         :validatable,
         :confirmable

  before_save :change_role

  def change_role
    self.role = :user
  end
end
