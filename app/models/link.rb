class Link < ApplicationRecord
    validates :slug, presence: true
end
