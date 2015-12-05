# == Schema Information
#
# Table name: background_check_containers
#
#  id                :integer          not null, primary key
#  name              :string(255)
#  community_id      :integer
#  container_type    :string(255)
#  icon_file_name    :string(255)
#  icon_content_type :string(255)
#  icon_file_size    :integer
#  icon_updated_at   :datetime
#  button_text       :string(255)
#  placeholder_text  :text
#  active            :boolean
#  visible           :boolean
#  status            :text
#  status_bg_color   :string(255)
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#
# Indexes
#
#  index_background_check_containers_on_community_id  (community_id)
#

class BackgroundCheckContainer < ActiveRecord::Base
  attr_accessible :active, :button_text, :community_id, :container_type, :icon, :name, :placeholder_text, :status, :status_bg_color, :visible

  belongs_to :community
  has_attached_file :icon, :styles => {:thumb => "48x48#"},
                    :default_url => ActionController::Base.helpers.asset_path("/assets/profile_image/:style/missing.png", :digest => true)
  process_in_background :icon

  #validates_attachment_presence :image
  validates_attachment_size :icon, :less_than => 1.megabytes
  validates_attachment_content_type :icon,
                                    :content_type => ["image/jpeg", "image/png", "image/gif",
                                      "image/pjpeg", "image/x-png"] #the two last types are sent by IE.
end
