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


#@jo1 = Jobs::Organization.new(title: "Poder Judicial", location: "ubicacion de la organizacion", logo: "http://www.google.com/log.png")
#@jo2 = Jobs::Organization.new(title: "Sunarp", location: "ubicacion de la organizacion", logo: "http://www.google.com/log.png")
#@jo3 = Jobs::Organization.new(title: "Sunat", location: "ubicacion de la organizacion", logo: "http://www.google.com/log.png")
#@jo4 = Jobs::Organization.new(title: "Reniec", location: "ubicacion de la organizacion", logo: "http://www.google.com/log.png")


#Job.create(title: "Gestora Local", description: "JUNTOS requiere nuevo personal.", total_vacancies: 1, application_date: "03/12/2022", last_application_date: "17/12/2022", area: "Programa Nacional Juntos", location: 1, salary: "S/. 2000.00", external_link:"wwww.google.com", job_organization_id: @jo1.id)
#Job.create(title: "Encuestadores", description: "Reniec requiere nuevo personal.", total_vacancies: 1, application_date: "03/12/2022", last_application_date: "17/12/2022", area: "Programa Nacional Juntos", location: 1, salary: "S/. 3000.00", external_link:"wwww.google.com", job_organization_id: @jo2.id)


#Job::Type.create(title: "Convocatorias Vigentes")
#Job::Type.create(title: "Convocatorias Cas")
#Job::Type.create(title: "Practicas")
#Job::Type.create(title: "Anuncios Privados")

#Job::Profession.create(title: "Abogado")
#Job::Profession.create(title: "Ingeniero Civil")
#Job::Profession.create(title: "Administrador")
#Job::Profession.create(title: "Contador")
#Job::Profession.create(title: "Ingeniero de Sistemas")
