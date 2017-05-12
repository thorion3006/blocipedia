class Wiki < ApplicationRecord
  has_many :collaborators, dependent: :destroy
  belongs_to :user

  validates :title, length: { minimum: 5 }, presence: true
  validates :body, length: { minimum: 20 }, presence: true
  validates :user, presence: true

  after_create :init

  scope :paid, -> { where(private: true) }
  scope :free, -> { where(private: false) }

  def init
    admins = User.admin
    admins.each do |admin|
      if self.private
        collaborator = self.collaborators.build
        collaborator.user = admin
        collaborator.save
      end
    end
    self.save
  end
end
