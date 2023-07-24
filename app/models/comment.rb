class Comment < ApplicationRecord
  belongs_to :post

  after_create_commit -> { broadcast_append_to "comments" }
  after_update_commit -> { broadcast_replace_to "comments" }
  after_destroy_commit -> { broadcast_remove_to "comments" }
end
