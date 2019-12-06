# == Schema Information
#
# Table name: posts
#
#  id         :bigint           not null, primary key
#  caption    :text(65535)      not null
#  user_id    :bigint
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'test_helper'

class PostTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
