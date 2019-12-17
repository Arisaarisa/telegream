# == Schema Information
#
# Table name: comments
#
#  id         :bigint           not null, primary key
#  body       :text(65535)      not null
#  post_id    :bigint
#  user_id    :bigint
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :post

  validates :body, presence: true, length: { maximum: 140 }
end
