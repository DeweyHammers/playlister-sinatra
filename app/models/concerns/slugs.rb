module Slugs
  module InstanceMethods
    def slug
      self.name.downcase.gsub(/\s/, '-')
    end
  end
  
  module ClassMethods
    def find_by_slug(slug)
      name = slug.gsub(/-/, ' ')
      name = name.split(' ').map {|word| word.capitalize!}
      self.find_by(name: name.join(' '))
    end
  end
end