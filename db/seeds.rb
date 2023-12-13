# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).


# Users
user1 =  User.create(username: 'senras1', email: 'mailuser1@gmail.com', password: '123456')
user2 = User.create(username: 'senras2', email: 'mailuser2@gmail.com', password: '123456')


# Links
link1 = Link.create(
 name: 'Informática',
 slug: SecureRandom.hex(3),
 url: 'https://www.info.unlp.edu.ar/',
 user_id: user1.id,
 link_type: 'regular',
)

link2 = Link.create(
   name: 'Derecho',
   slug: SecureRandom.hex(3),
   url: 'https://www.jursoc.unlp.edu.ar/',
   user_id: user1.id,
   link_type: 'private',
   password: '123'
 )

link3 = Link.create(
   name: 'Medicina',
   slug: SecureRandom.hex(3),
   url: 'https://www.med.unlp.edu.ar/',
   user_id: user1.id,
   link_type: 'temporary',
   expiration_date: Time.now + 1.day,
 )

link4 = Link.create(
   name: 'Ingeniería',
   slug: SecureRandom.hex(3),
   url: 'https://ing.unlp.edu.ar/',
   user_id: user1.id,
   link_type: 'ephemeral',
   expiration_date: '',
 )

 link5 = Link.create(
   name: 'Artes',
   slug: SecureRandom.hex(3),
   url: 'https://fba.unlp.edu.ar/',
   user_id: user1.id,
   link_type: 'regular',
 )

 link6 = Link.create(
    name: 'Exactas',
    slug: SecureRandom.hex(3),
    url: 'https://www.exactas.unlp.edu.ar/',
    user_id: user1.id,
    link_type: 'temporary',
    expiration_date: Time.now - 1.day,
)
 

# Visits
Visit.create(link_id: link1.id, access_date: Time.now - 2.days, ip_address: '192.138.1.1')
Visit.create(link_id: link1.id, access_date: Time.now - 2.days, ip_address: '192.138.1.1')
Visit.create(link_id: link1.id, access_date: Time.now - 2.days, ip_address: '192.138.1.1')
Visit.create(link_id: link1.id, access_date: Time.now - 2.days, ip_address: '192.138.1.1')
Visit.create(link_id: link1.id, access_date: Time.now - 5.days, ip_address: '192.138.1.3')

Visit.create(link_id: link2.id, access_date: Time.now - 10.days, ip_address: '192.168.3.3')
Visit.create(link_id: link2.id, access_date: Time.now - 9.days, ip_address: '192.168.3.4')

Visit.create(link_id: link3.id, access_date: Time.now - 3.days, ip_address: '192.168.1.2')
Visit.create(link_id: link3.id, access_date: Time.now - 3.days, ip_address: '192.168.1.3')

Visit.create(link_id: link4.id, access_date: Time.now - 6.days, ip_address: '192.168.1.5')
Visit.create(link_id: link4.id, access_date: Time.now - 8.days, ip_address: '192.168.1.4')