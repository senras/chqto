class Link < ApplicationRecord
    belongs_to :user
    has_many :visits, dependent: :destroy
    validates :slug, presence: true, uniqueness: true
    validates :name, presence: false
    validates :link_type, presence: true
    validates :expiration_date, presence: true , if: :is_temporary?
    validates :password, presence: true , if: :is_private?
    validates :url, presence: true ,format: { with: URI.regexp }
    has_secure_password validations: false

    enum link_type: { regular: 'regular', temporary: 'temporary', private: 'private', ephemeral: 'ephemeral' }, _prefix: true

    before_validation :generate_slug_and_unique_url, on: :create
    
  # Types of links:
  # - Links regulares
  # - Links temporales - tiene atributo expiration_date datetime
  # - Links privados - tiene atributo password string
  # - Links efímeros - tiene atributo accessed boolean

  def self.link_disable
    update(accessed: true)
  end  

  private
  def generate_slug_and_unique_url
    self.slug ||= SecureRandom.hex(3)
  end

  def is_temporary?
    link_type == 'temporary'
  end

  def is_private?
    link_type == 'private'
  end

end