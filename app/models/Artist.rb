class Artist < ActiveRecord::Base
  include Slugs::InstanceMethods
  extend Slugs::ClassMethods

  has_many :songs
  has_many :genres, through: :songs
end