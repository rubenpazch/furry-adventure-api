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
@sales_tours = Profile.create(name: 'salesman-tours')

#admin user
@user_admin = User.create(email: 'admin@testing.com', password: 'CuscoPeru123.', first_name: 'admin', last_name: 'user') 
#basic user
@user_basic = User.create(email: 'basic@testing.com', password: 'CuscoPeru123.', first_name: 'basic', last_name: 'user')

#Modules
ModuleApp.create(name: 'Tours', description: 'Option to offer tours')
ModuleApp.create(name: 'Restaurant', description: 'Option to offer tours')
ModuleApp.create(name: 'Cloths', description: 'Option to offer tours')

#CreateRoles
@superAdmin = Role.create(name: 'SuperAdministrator', profile_id: @admin_profile.id, is_root: true, parent_id: 0)

@admin = Role.create(name: 'Admin', profile_id: @manager_profile.id, is_root: false, parent_id: @superAdmin.id)

@owner = Role.create(name: 'Owner', profile_id: @manager_profile.id, is_root: false, parent_id: @admin.id)
@itsupport = Role.create(name: 'IT support', profile_id: @manager_profile.id, is_root: false, parent_id: @admin.id)
@salesmanager = Role.create(name: 'Sales Manager', profile_id: @manager_profile.id, is_root: false, parent_id: @admin.id)

@salesman = Role.create(name: 'Salesman', profile_id: @manager_profile.id, is_root: false, parent_id: @salesmanager.id)

@traveler = Role.create(name: 'Traveler', profile_id: @sales_tours.id, is_root: false, parent_id: @salesman.id)
@client = Role.create(name: 'Client', profile_id: @sales_tours.id, is_root: false, parent_id: @salesman.id)


#privileges
@privilegeManageUser = Privilege.create(name: 'Manage Users')
@privilegeManageTours = Privilege.create(name: 'Manage Tours')
@privilegeManageRestaurant = Privilege.create(name: 'Manage Restaurants')

AccessPrivilege.create( profile_id: @admin_profile.id, privilege_id: @privilegeManageUser.id)
AccessPrivilege.create( profile_id: @manager_profile.id, privilege_id: @privilegeManageUser.id)
AccessPrivilege.create( profile_id: @sales_tours.id, privilege_id: @privilegeManageTours.id)

#Permission.create(name: 'Create')
#Permission.create(name: 'Edit')
#Permission.create(name: 'View')
#Permission.create(name: 'Delete')