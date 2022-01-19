# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

#profiles
@admin_profile = Profile.create(name: 'administrator')
@manager_profile = Profile.create(name: 'manager')
@client_profile = Profile.create(name: 'client')

#admin user
@user_admin = User.create(email: 'admin@testing.com', password: 'CuscoPeru123.', first_name: 'admin', last_name: 'user') 
#basic user
@user_basic = User.create(email: 'basic@testing.com', password: 'CuscoPeru123.', first_name: 'basic', last_name: 'user')

#Modules
ModuleApp.create(name: 'Tours', description: 'Option to offer tours')
ModuleApp.create(name: 'Restaurant', description: 'Option to offer tours')
ModuleApp.create(name: 'Cloths', description: 'Option to offer tours')

#CreateRoles
Role.create(name: 'SuperAdministrator', profile_id: @admin_profile.id)
Role.create(name: 'Owner', profile_id: @manager_profile.id)
Role.create(name: 'IT support', profile_id: @manager_profile.id)
Role.create(name: 'Sales Manager', profile_id: @manager_profile.id)
Role.create(name: 'Salesman', profile_id: @manager_profile.id)
Role.create(name: 'Traveler', profile_id: @client_profile.id)
Role.create(name: 'Client', profile_id: @client_profile.id)

@privilegeManageUser = Privilege.create(name: 'Manage Users')
@privilegeManageUser = Privilege.create(name: 'Manage Tours')
@privilegeManageUser = Privilege.create(name: 'Manage Restarants')

#Permission.create(name: 'Create')
#Permission.create(name: 'Edit')
#Permission.create(name: 'View')
#Permission.create(name: 'Delete')