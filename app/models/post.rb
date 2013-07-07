class Post < ActiveRecord::Base
	attr_accessible :title,:body,:photo,:showpost
	has_attached_file :photo,
								:url => "/system/:class/:attachment/:id/:style/:basename.:extension",
  								:path => ":rails_root/public/system/:class/:attachment/:id/:style/:basename.:extension"
	has_many :comments
	validates :title,presence: true
	validates :body,presence: true
	def previous_post
    @post=Post.find_by_id(id-1)
  end
  def next_post
    @post=Post.find_by_id(id+1)

  end
end
