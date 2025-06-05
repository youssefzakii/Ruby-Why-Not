# == Schema Information
#
# Table name: posts
#
#  id         :integer          not null, primary key
#  hidden     :boolean          default(FALSE), not null
#  body       :text
#  flag_count :integer          default(0), not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :integer          not null
#
# Indexes
#
#  index_posts_on_user_id  (user_id)
#
# Foreign Keys
#
#  user_id  (user_id => users.id)
#
class Post < ApplicationRecord
    belongs_to :user
    has_one_attached :image

    def flag!
        increment!(:flag_count)
        hide! if flag_count >= 3
    end

    def hide!
        update!(hidden: true)
    end
end 