# == Schema Information
#
# Table name: likes
#
#  id         :bigint           not null, primary key
#  post_id    :bigint
#  user_id    :bigint
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Like < ApplicationRecord
  belongs_to :post, counter_cache: :likes_count
  belongs_to :user
end
