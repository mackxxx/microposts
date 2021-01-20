class User < ApplicationRecord
  before_save { self.email.downcase! }
  has_many :active_relationships, class_name:  "Relationship",
                                  foreign_key: "follower_id",
                                  dependent:   :destroy
  has_many :followees, through: :active_relationships, source: :followee
  has_many :passive_relationships, class_name:  "Relationship",
                                   foreign_key: "followee_id",
                                   dependent:   :destroy
  has_many :followers, through: :passive_relationships, source: :follower
                                   validates :name, presence: true, length: { maximum: 50 }
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i },
                    uniqueness: { case_sensitive: false }
  has_secure_password

  def follow(other_user)
    followees << other_user
  end

  # ユーザーをフォロー解除する
  def unfollow(other_user)
    active_relationships.find_by(followee_id: other_user.id).destroy
  end

  # 現在のユーザーがフォローしてたらtrueを返す
  def followees?(other_user)
    followees.include?(other_user)
  end
end