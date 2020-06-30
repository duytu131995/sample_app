class Micropost < ApplicationRecord
  MICROPOST_PARAMS = %i(content image).freeze

  belongs_to :user
  has_one_attached :image

  delegate :name, to: :user

  validates :user_id, presence: true
  validates :content, presence: true, length: {maximum: Settings.micropost.content.length}
  validates :image, content_type: {in: Settings.micropost.image.content_type.in,
                                  message: I18n.t("micropost_image_content_type")},
                    size: {less_than: Settings.micropost.image.size.number.megabytes,
                           message: I18n.t("micropost_image_size")}

  scope :recent_posts, -> {order created_at: :desc}
  scope :feeds, -> (user_ids){where user_id: user_ids}

  def display_image
    image.variant resize_to_limit: Settings.micropost.display_image.resize_to_limit
  end
end
