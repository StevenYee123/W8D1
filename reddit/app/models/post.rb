# == Schema Information
#
# Table name: posts
#
#  id         :bigint           not null, primary key
#  title      :string           not null
#  url        :string
#  content    :text
#  author_id  :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Post < ApplicationRecord 
  validates :title, :author_id, presence: true 
  validates :url, uniqueness: true 


  belongs_to :author,
  foreign_key: :author_id,
  class_name: :User

  has_many :post_subs,
  foreign_key: :post_id,
  class_name: :PostSub

  has_many :subs,
    through: :post_subs,
    source: :sub

end
