class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :wikis, dependent: :destroy

  validates :name, length: { minimum: 3, maximum: 100 }, presence: true

  validates :uname,
            presence: true,
            uniqueness: { case_sensitive: false },
            length: { minimum: 3, maximum: 100 }

  enum role: [:admin, :standard, :premium]

  #To allow signin using either email id or username
  attr_accessor :login

  after_initialize {
    self.role ||= :standard
    self.account_active = false if self.role == 'premium'
  }

  def self.find_for_database_authentication warden_conditions
    conditions = warden_conditions.dup
    login = conditions.delete(:login)
    where(conditions).where(["lower(uname) = :value OR lower(email) = :value", {value: login.strip.downcase}]).first
  end

  def avatar_url(size)
    gravatar_id = Digest::MD5::hexdigest(self.email).downcase
    "http://gravatar.com/avatar/#{gravatar_id}.png?s=#{size}"
  end
end
