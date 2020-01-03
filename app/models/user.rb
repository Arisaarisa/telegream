# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  email                  :string(255)      default(""), not null
#  encrypted_password     :string(255)      default(""), not null
#  reset_password_token   :string(255)
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  name                   :string(255)      not null
#  username               :string(255)      not null
#  description            :text(65535)      not null
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_one_attached :avatar
  has_many :posts
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  attribute :new_avatar
  validates :name,          presence: true,   length: { maximum: 50 }
  validates :username,      presence: true,   length: { maximum: 50 }
  validates :description,   presence: true,   length: { maximum: 1000 }
  validate :new_avatar_check

  def new_avatar_check
    if new_avatar.present?
      unless new_avatar.content_type.in?(%(image/jpeg image/png))
        errors.add(:new_avatar, 'にはjpegまたはpngファイルを添付してください')
      end
    else
      unless avatar.attached?
        errors.add(:new_avatar, 'ファイルを添付してください')
      end
    end
  end


  before_save do
    self.avatar = new_avatar if new_avatar
  end
end
