class Comment < ApplicationRecord
  belongs_to :post, optional: true
  belongs_to :user, optional: true

  validates :body, length: { minimum: 5 }, presence: true
  validates :user, presence: true

  after_create :send_favorite_emails

   private

   def send_favorite_emails
     post.favorites.each do |favorite|
       FavoriteMailer.new_comment(favorite.user, post, self).deliver_now
     end
   end
end
