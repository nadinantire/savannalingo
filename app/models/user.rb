class User < ApplicationRecord
    has_many :posts, dependent: :destroy

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  enum user_role: { visitor: 'visitor', publisher: 'publisher', admin: 'admin' }

  after_initialize :set_default_role, if: :new_record?

  def set_default_role
    self.user_role ||= 'visitor'
  end
end
