class Visit < ApplicationRecord
  belongs_to :link
  scope :by_day, -> { group_by_day(:access_date).count }

    def self.ransackable_attributes(auth_object = nil)
        ["access_date", "created_at", "id", "id_value", "ip_address", "link_id", "updated_at"]
      end

    def self.create_visit(link, current_date, ip_address)
      create(link: link, access_date: current_date, ip_address: ip_address)
    end
end
