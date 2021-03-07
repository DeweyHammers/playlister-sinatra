class Genre < ActiveRecord::Base
  include Slugs::InstanceMethods
  extend Slugs::ClassMethods

  has_many :song_genres
  has_many :songs, through: :song_genres
  has_many :artists, through: :songs
end