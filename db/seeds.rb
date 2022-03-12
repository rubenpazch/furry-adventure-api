# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

#profiles
@admin_profile = Profile.create(name: "administrator")
@manager_profile = Profile.create(name: "manager")
@sales_tours = Profile.create(name: "salesman-tours")

#admin user
@user_admin = User.create(email: "admin@testing.com", password: "CuscoPeru123.", first_name: "admin", last_name: "user")
#basic user
@user_basic = User.create(email: "basic@testing.com", password: "CuscoPeru123.", first_name: "basic", last_name: "user")

#Modules
ModuleApp.create(name: "Tours", description: "Option to offer tours")
ModuleApp.create(name: "Restaurant", description: "Option to offer tours")
ModuleApp.create(name: "Cloths", description: "Option to offer tours")

#CreateRoles
@superAdmin = Role.create(name: "SuperAdministrator", profile_id: @admin_profile.id, is_root: true, parent_id: 0)

@admin = Role.create(name: "Admin", profile_id: @manager_profile.id, is_root: false, parent_id: @superAdmin.id)

@owner = Role.create(name: "Owner", profile_id: @manager_profile.id, is_root: false, parent_id: @admin.id)
@itsupport = Role.create(name: "IT support", profile_id: @manager_profile.id, is_root: false, parent_id: @admin.id)
@salesmanager = Role.create(name: "Sales Manager", profile_id: @manager_profile.id, is_root: false, parent_id: @admin.id)

@salesman = Role.create(name: "Salesman", profile_id: @manager_profile.id, is_root: false, parent_id: @salesmanager.id)

@traveler = Role.create(name: "Traveler", profile_id: @sales_tours.id, is_root: false, parent_id: @salesman.id)
@client = Role.create(name: "Client", profile_id: @sales_tours.id, is_root: false, parent_id: @salesman.id)

#privileges
@privilegeManageUser = Privilege.create(name: "Manage Users")
@privilegeManageTours = Privilege.create(name: "Manage Tours")
@privilegeManageRestaurant = Privilege.create(name: "Manage Restaurants")

AccessPrivilege.create(profile_id: @admin_profile.id, privilege_id: @privilegeManageUser.id)
AccessPrivilege.create(profile_id: @manager_profile.id, privilege_id: @privilegeManageUser.id)
AccessPrivilege.create(profile_id: @sales_tours.id, privilege_id: @privilegeManageTours.id)

#Permission.create(name: 'Create')
#Permission.create(name: 'Edit')
#Permission.create(name: 'View')
#Permission.create(name: 'Delete')

@jo1 = Jobs::Organization.create(
  title: Faker::Company.name,
  location: Faker::Address.full_address,
  logo: Faker::LoremFlickr.image(size: "50x60"),
)
@jo2 = Jobs::Organization.create(
  title: Faker::Company.name,
  location: Faker::Address.full_address,
  logo: Faker::LoremFlickr.image(size: "50x60"),
)
@jo3 = Jobs::Organization.create(
  title: Faker::Company.name,
  location: Faker::Address.full_address,
  logo: Faker::LoremFlickr.image(size: "50x60"),
)
@jo4 = Jobs::Organization.create(
  title: Faker::Company.name,
  location: Faker::Address.full_address,
  logo: Faker::LoremFlickr.image(size: "50x60"),
)

Job.create(
  title: Faker::Job.title,
  description: Faker::Job.title,
  total_vacancies: Faker::Number.between(from: 1, to: 50),
  application_date: Faker::Date.between(from: '2022-01-23', to: '2022-01-25'),
  last_application_date: Faker::Date.between(from: '2022-01-25', to: '2022-02-15'),
  area: Faker::Number.between(from: 1, to: 50),
  location: Faker::Address.full_address,
  salary: Faker::Number.between(from: 1000, to: 5000),
  external_link: Faker::Internet.domain_name,
  job_organization_id: @jo1.id,
)

Job.create(
  title: Faker::Job.title,
  description: Faker::Job.title,
  total_vacancies: Faker::Number.between(from: 1, to: 50),
  application_date: Faker::Date.between(from: '2022-01-23', to: '2022-01-25'),
  last_application_date: Faker::Date.between(from: '2022-01-25', to: '2022-02-15'),
  area: Faker::Number.between(from: 1, to: 50),
  location: Faker::Address.full_address,
  salary: Faker::Number.between(from: 1000, to: 5000),
  external_link: Faker::Internet.domain_name,
  job_organization_id: @jo2.id,
)

Job.create(
  title: Faker::Job.title,
  description: Faker::Job.title,
  total_vacancies: Faker::Number.between(from: 1, to: 50),
  application_date: Faker::Date.between(from: '2022-01-23', to: '2022-01-25'),
  last_application_date: Faker::Date.between(from: '2022-01-25', to: '2022-02-15'),
  area: Faker::Number.between(from: 1, to: 50),
  location: Faker::Address.full_address,
  salary: Faker::Number.between(from: 1000, to: 5000),
  external_link: Faker::Internet.domain_name,
  job_organization_id: @jo3.id,
)

Job.create(
  title: Faker::Job.title,
  description: Faker::Job.title,
  total_vacancies: Faker::Number.between(from: 1, to: 50),
  application_date: Faker::Date.between(from: '2022-01-23', to: '2022-01-25'),
  last_application_date: Faker::Date.between(from: '2022-01-25', to: '2022-02-15'),
  area: Faker::Number.between(from: 1, to: 50),
  location: Faker::Address.full_address,
  salary: Faker::Number.between(from: 1000, to: 5000),
  external_link: Faker::Internet.domain_name,
  job_organization_id: @jo4.id,
)

@category1 = Products::Category.create(
  title: 'Tapices Inca',
  description: 'Tapices Inca',
  slug: 'tapices-inca',
  product_count: 20,
  icon: '/assets/images/category/icons/woman.png',
)

@category2 = Products::Category.create(
  title: 'Tapices Pre-Inca',
  description: 'Tapices Pre-Inca',
  slug: 'tapices-pre-inca',
  product_count: 20,
  icon: '/assets/images/category/icons/woman.png',
)

@category3 = Products::Category.create(
  title: 'Tapices Coloniales',
  description: 'Tapices Coloniales',
  slug: 'tapices-coloniales',
  product_count: 20,
  icon: '/assets/images/category/icons/woman.png',
)

@category4 = Products::Category.create(
  title: 'Tapices Moderno',
  description: 'Tapices Moderno',
  slug: 'tapices-moderno',
  product_count: 20,
  icon: '/assets/images/category/icons/woman.png',
)

Product.create(
  title: 'Tapiz Wari Images Zoomorfas',
  price: 12,
  published: true,
  description: "testing testing",
  slug: "tapiz-wari-images-zoomorfas",
  sale_price: 14,
  product_category_id: @category1.id
)

Product.create(
  title: 'Tapiz Wari Images Geometricas',
  price: 12,
  published: true,
  description: "testing testing",
  slug: "tapiz-wari-images-zoomorfas",
  sale_price: 14,
  product_category_id: @category1.id
)

Product.create(
  title: 'Tapiz Wari Images Triangulares',
  price: 12,
  published: true,
  description: "testing testing",
  slug: "tapiz-wari-images-zoomorfas",
  sale_price: 14,
  product_category_id: @category1.id
)

#Job::Type.create(title: "Convocatorias Vigentes")
#Job::Type.create(title: "Convocatorias Cas")
#Job::Type.create(title: "Practicas")
#Job::Type.create(title: "Anuncios Privados")

#Job::Profession.create(title: "Abogado")
#Job::Profession.create(title: "Ingeniero Civil")
#Job::Profession.create(title: "Administrador")
#Job::Profession.create(title: "Contador")
#Job::Profession.create(title: "Ingeniero de Sistemas")
