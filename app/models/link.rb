class Link < ApplicationRecord
    validates :slug, presence: true
    belongs_to :user
    validates :user, presence: true
end

# Types of links:
# - Links regulares
# - Links temporales - tienen ExpirationDate
# - Links privados - tienen Password
# - Links efímeros - tienen Accessed

#$ rails generate scaffold Link name:string slug:string expiration_date:date password:string  accessed:boolean