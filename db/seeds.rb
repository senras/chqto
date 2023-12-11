# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
# db/seeds.rb

# Crear usuarios de ejemplo (si es necesario)
user1 =  User.create(username: 'senras1', email: 'mailuser1@gmail.com', password: '123456')
user2 = User.create(username: 'senras2', email: 'mailuser2@gmail.com', password: '123456')

# Crear dos links
link1 = Link.create(
 name: 'Informática',
 slug: SecureRandom.hex(3),
 url: 'https://www.info.unlp.edu.ar/',
 user_id: user1.id,
 link_category: 'regular',
 expires_at: '',
 password: ''
)

link2 = Link.create(
   name: 'Derecho',
   slug: SecureRandom.hex(3),
   url: 'https://www.jursoc.unlp.edu.ar/',
   user_id: user1.id,
   link_category: 'private_link',
   expires_at: '',
   password: '123'
 )

link3 = Link.create(
   name: 'Medicina',
   slug: SecureRandom.hex(3),
   url: 'https://www.med.unlp.edu.ar/',
   user_id: user1.id,
   link_category: 'temporary',
   expires_at: Time.now + 1.day,
   password: ''
 )

link4 = Link.create(
   name: 'Ingeniería',
   slug: SecureRandom.hex(3),
   url: 'https://ing.unlp.edu.ar/',
   user_id: user1.id,
   link_category: 'ephemeral',
   expires_at: '',
   password: ''
 )

 link5 = Link.create(
   name: 'Artes',
   slug: SecureRandom.hex(3),
   url: 'https://fba.unlp.edu.ar/',
   user_id: user1.id,
   link_category: 'regular',
   password: ''
 )

 link6 = Link.create(
    name: 'Exactas',
    slug: SecureRandom.hex(3),
    url: 'https://www.exactas.unlp.edu.ar/',
    user_id: user1.id,
    link_category: 'temporary',
    expires_at: Time.now - 1.day,
    password: ''
)
 

# Crear dos accesos para cada link con fechas distintas
LinkAccess.create(link_id: link1.id, access_time: Time.now - 2.days, ip_address: '192.168.1.1')
LinkAccess.create(link_id: link1.id, access_time: Time.now - 1.day, ip_address: '192.168.1.2')

LinkAccess.create(link_id: link2.id, access_time: Time.now - 3.days, ip_address: '192.168.1.3')
LinkAccess.create(link_id: link2.id, access_time: Time.now - 4.days, ip_address: '192.168.1.4')

LinkAccess.create(link_id: link3.id, access_time: Time.now - 5.days, ip_address: '192.168.1.5')
LinkAccess.create(link_id: link3.id, access_time: Time.now - 6.days, ip_address: '192.168.1.6')

LinkAccess.create(link_id: link4.id, access_time: Time.now - 7.days, ip_address: '192.168.1.7')
LinkAccess.create(link_id: link4.id, access_time: Time.now - 8.days, ip_address: '192.168.1.8')