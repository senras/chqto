class Link < ActiveRecord::Base
    validates :slug, presence: true, uniqueness: true
    validates :name, presence: true, uniqueness: true, allow_blank: true
end
       
        



