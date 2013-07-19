class Student < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :username, :email, :password, :password_confirmation, :remember_me
  # attr_accessible :title, :body

  attr_accessible :xp_gained, :xp_used, :xp_current, :user_id
  attr_accessible :login
  attr_accessor :login

  belongs_to :user
  has_many :points, dependent: :destroy
  has_many :points_spents, dependent: :destroy

  def update_xp
    xp_total = points.sum(:xp_earned)
    xp_spent_total = points_spents.sum(:xp_spent)
    update_column(:xp_gained, xp_total)
    update_column(:xp_current, xp_total - xp_spent_total)
  end

  def update_xp_used
    xp_total = points.sum(:xp_earned)
    xp_spent_total = points_spents.sum(:xp_spent)
    update_column(:xp_used, xp_spent_total)
    update_column(:xp_current, xp_total - xp_spent_total)
  end

  def self.find_first_by_auth_conditions(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      where(conditions).where(["lower(username) = :value OR lower(email) = :value", { :value => login.downcase }]).first
    else
      where(conditions).first
    end
  end

end

