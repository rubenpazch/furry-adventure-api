# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

@organization_sulca = Organization.create!(name: "Artexaperu", description: "Empresa de textiles peru")
@account_sulca = Account.create!(name: "Museo Sulca Textiles", organizations_id: @organization_sulca.id)

@global_organization = Organization.create!(name: "Ruben Paz Chuspe", description: "Empresa de desarrollo")
@global_account = Account.create!(name: "administrators", organizations_id: @global_organization.id)

@daniel_organization = Organization.create!(name: "Daniel Cusihuaman", description: "Lunotopia")
@daniel_account = Account.create!(name: "Luneteria", organizations_id: @daniel_organization.id)

#menus
@menu1 = Profiles::Menu.create!(title: "MENU.ORDER", link_to: "/work-order", hasSubMenu: true, isRoot: false, account_id: @daniel_account.id)
@sub_menu11 = Profiles::SubMenu.create!(title: "MENU.ORDER.NEW", link_to: "/work-order/new", hasSubMenu: false, menus_id: @menu1.id)
@sub_menu12 = Profiles::SubMenu.create(title: "MENU.ORDER.BUSCAR", link_to: "/work-order/find", hasSubMenu: false, menus_id: @menu1.id)

@menu2 = Profiles::Menu.create!(title: "MENU.CLIENT", link_to: "/clients", hasSubMenu: true, isRoot: false, account_id: @daniel_account.id)
@sub_menu21 = Profiles::SubMenu.create!(title: "MENU.CLIENT.NEW", link_to: "/clients/new", hasSubMenu: false, menus_id: @menu2.id)
@sub_menu22 = Profiles::SubMenu.create!(title: "MENU.CLIENT.BUSCAR", link_to: "/clients/find", hasSubMenu: false, menus_id: @menu2.id)

@menu3 = Profiles::Menu.create!(title: "MENU.USER.MANAGEMENT", link_to: "/apps/user-management/users", hasSubMenu: false, isRoot: false, account_id: @daniel_account.id)
#@menu4 = Profiles::Menu.create!(title: "MENU.USER.MANAGEMENT", link_to: "/apps/user-management/users", hasSubMenu: false, isRoot: false, account_id: @daniel_account.id)

#profiles
@super_admin_profile = Profile.create!(name: "super administrator")
@admin_profile = Profile.create!(name: "administrator")
@manager_profile = Profile.create!(name: "manager")
@sales_profile = Profile.create!(name: "salesman")

#menu access
Profiles::MenuAccess.create!(profile_id: @super_admin_profile.id, menus_id: @menu1.id)
Profiles::MenuAccess.create!(profile_id: @super_admin_profile.id, menus_id: @menu2.id)
Profiles::MenuAccess.create!(profile_id: @admin_profile.id, menus_id: @menu1.id)
Profiles::MenuAccess.create!(profile_id: @admin_profile.id, menus_id: @menu2.id)
Profiles::MenuAccess.create!(profile_id: @manager_profile.id, menus_id: @menu1.id)
Profiles::MenuAccess.create!(profile_id: @manager_profile.id, menus_id: @menu2.id)
Profiles::MenuAccess.create!(profile_id: @manager_profile.id, menus_id: @menu3.id)
Profiles::MenuAccess.create!(profile_id: @sales_profile.id, menus_id: @menu2.id)

#Modules
ModuleApp.create(name: "Tours", description: "Option to offer tours")
ModuleApp.create(name: "Restaurant", description: "Option to offer tours")
ModuleApp.create(name: "Cloths", description: "Option to offer tours")

#CreateRoles
@superAdmin = Profiles::Role.create!(name: "SuperAdministrator", profile_id: @super_admin_profile.id, is_root: true, parent_id: 0, account_id: @global_account.id)
@admin = Profiles::Role.create!(name: "Admin", profile_id: @admin_profile.id, is_root: false, parent_id: @superAdmin.id, account_id: @global_account.id)
@owner = Profiles::Role.create!(name: "Owner Optica", profile_id: @manager_profile.id, is_root: false, parent_id: @admin.id, account_id: @daniel_account.id)
@itsupport = Profiles::Role.create!(name: "IT support Optica", profile_id: @manager_profile.id, is_root: false, parent_id: @owner.id, account_id: @daniel_account.id)
@salesmanager = Profiles::Role.create!(name: "Sales Manager Optica", profile_id: @sales_profile.id, is_root: false, parent_id: @owner.id, account_id: @daniel_account.id)
@client = Profiles::Role.create!(name: "Client Optica", profile_id: @sales_profile.id, is_root: false, parent_id: @salesmanager.id, account_id: @daniel_account.id)

#super admin user
@user_admin = User.create(email: "admin@testing.com", password: "CuscoPeru123.", first_name: "admin", last_name: "user", account_id: @global_account.id, isSuperAdmin: true, role_id: @superAdmin.id)
#basic user
@user_basic = User.create(email: "basic@testing.com", password: "CuscoPeru123.", first_name: "basic", last_name: "user", account_id: @global_account.id, isSuperAdmin: false, role_id: @owner.id)
#sulca user
@sulca_admin = User.create(email: "artexaperu@gmail.com", password: "^C#XeZxm-V6ptE?", first_name: "sulca", last_name: "textiles", account_id: @account_sulca.id, isSuperAdmin: false, role_id: @owner.id)
#daniel user
@daniel_admin = User.create(email: "daniel@gmail.com", password: "^C#XeZxm-V6ptE?", first_name: "daniel", last_name: "lentes", account_id: @daniel_account.id, isSuperAdmin: false, role_id: @owner.id)
@daniel_sales_user1 = User.create(email: "daniel_sales@gmail.com", password:  "^C#XeZxm-V6ptE?", first_name: Faker::Name.first_name, last_name: Faker::Name.last_name, account_id: @daniel_account.id, isSuperAdmin: false, role_id: @salesmanager.id)
@daniel_sales_user2 = User.create(email: Faker::Internet.email, password: BCrypt::Password.create("secret"), first_name: Faker::Name.first_name, last_name: Faker::Name.last_name, account_id: @daniel_account.id, isSuperAdmin: false, role_id: @salesmanager.id)
@daniel_sales_user3 = User.create(email: Faker::Internet.email, password: BCrypt::Password.create("secret"), first_name: Faker::Name.first_name, last_name: Faker::Name.last_name, account_id: @daniel_account.id, isSuperAdmin: false, role_id: @salesmanager.id)
@daniel_sales_user4 = User.create(email: Faker::Internet.email, password: BCrypt::Password.create("secret"), first_name: Faker::Name.first_name, last_name: Faker::Name.last_name, account_id: @daniel_account.id, isSuperAdmin: false, role_id: @salesmanager.id)
@daniel_sales_user5 = User.create(email: Faker::Internet.email, password: BCrypt::Password.create("secret"), first_name: Faker::Name.first_name, last_name: Faker::Name.last_name, account_id: @daniel_account.id, isSuperAdmin: false, role_id: @salesmanager.id)
@daniel_sales_user6 = User.create(email: Faker::Internet.email, password: BCrypt::Password.create("secret"), first_name: Faker::Name.first_name, last_name: Faker::Name.last_name, account_id: @daniel_account.id, isSuperAdmin: false, role_id: @salesmanager.id)
@daniel_sales_user7 = User.create(email: Faker::Internet.email, password: BCrypt::Password.create("secret"), first_name: Faker::Name.first_name, last_name: Faker::Name.last_name, account_id: @daniel_account.id, isSuperAdmin: false, role_id: @salesmanager.id)
@daniel_sales_user8 = User.create(email: Faker::Internet.email, password: BCrypt::Password.create("secret"), first_name: Faker::Name.first_name, last_name: Faker::Name.last_name, account_id: @daniel_account.id, isSuperAdmin: false, role_id: @salesmanager.id)
@daniel_sales_user9 = User.create(email: Faker::Internet.email, password: BCrypt::Password.create("secret"), first_name: Faker::Name.first_name, last_name: Faker::Name.last_name, account_id: @daniel_account.id, isSuperAdmin: false, role_id: @salesmanager.id)
@daniel_sales_user10 = User.create(email: Faker::Internet.email, password: BCrypt::Password.create("secret"), first_name: Faker::Name.first_name, last_name: Faker::Name.last_name, account_id: @daniel_account.id, isSuperAdmin: false, role_id: @salesmanager.id)
@daniel_sales_user11 = User.create(email: Faker::Internet.email, password: BCrypt::Password.create("secret"), first_name: Faker::Name.first_name, last_name: Faker::Name.last_name, account_id: @daniel_account.id, isSuperAdmin: false, role_id: @salesmanager.id)
@daniel_sales_user12 = User.create(email: Faker::Internet.email, password: BCrypt::Password.create("secret"), first_name: Faker::Name.first_name, last_name: Faker::Name.last_name, account_id: @daniel_account.id, isSuperAdmin: false, role_id: @salesmanager.id)
@daniel_sales_user13 = User.create(email: Faker::Internet.email, password: BCrypt::Password.create("secret"), first_name: Faker::Name.first_name, last_name: Faker::Name.last_name, account_id: @daniel_account.id, isSuperAdmin: false, role_id: @salesmanager.id)
@daniel_sales_user14 = User.create(email: Faker::Internet.email, password: BCrypt::Password.create("secret"), first_name: Faker::Name.first_name, last_name: Faker::Name.last_name, account_id: @daniel_account.id, isSuperAdmin: false, role_id: @salesmanager.id)
@daniel_sales_user15 = User.create(email: Faker::Internet.email, password: BCrypt::Password.create("secret"), first_name: Faker::Name.first_name, last_name: Faker::Name.last_name, account_id: @daniel_account.id, isSuperAdmin: false, role_id: @salesmanager.id)
@daniel_sales_user16 = User.create(email: Faker::Internet.email, password: BCrypt::Password.create("secret"), first_name: Faker::Name.first_name, last_name: Faker::Name.last_name, account_id: @daniel_account.id, isSuperAdmin: false, role_id: @salesmanager.id)
@daniel_sales_user17 = User.create(email: Faker::Internet.email, password: BCrypt::Password.create("secret"), first_name: Faker::Name.first_name, last_name: Faker::Name.last_name, account_id: @daniel_account.id, isSuperAdmin: false, role_id: @salesmanager.id)
@daniel_sales_user18 = User.create(email: Faker::Internet.email, password: BCrypt::Password.create("secret"), first_name: Faker::Name.first_name, last_name: Faker::Name.last_name, account_id: @daniel_account.id, isSuperAdmin: false, role_id: @salesmanager.id)
@daniel_sales_user19 = User.create(email: Faker::Internet.email, password: BCrypt::Password.create("secret"), first_name: Faker::Name.first_name, last_name: Faker::Name.last_name, account_id: @daniel_account.id, isSuperAdmin: false, role_id: @salesmanager.id)
@daniel_sales_user20 = User.create(email: Faker::Internet.email, password: BCrypt::Password.create("secret"), first_name: Faker::Name.first_name, last_name: Faker::Name.last_name, account_id: @daniel_account.id, isSuperAdmin: false, role_id: @salesmanager.id)

#privileges
@privilegeManageUser = Profiles::Privilege.create(name: "Manage Users")
#----------orders
@privilegeManageOrders = Profiles::Privilege.create(name: "Manage Orders")
@privilegeManageOrdersNew = Profiles::Privilege.create(name: "Create Orders")
@privilegeManageOrdersSearch = Profiles::Privilege.create(name: "Search Orders")
#----------clients
@privilegeManageClient = Profiles::Privilege.create(name: "Manage Cliente")
@privilegeManageClientNew = Profiles::Privilege.create(name: "Create Clients")
@privilegeManageClientSearch = Profiles::Privilege.create(name: "Search Clients")

#Access Privileges
Profiles::AccessPrivilege.create!(profile_id: @super_admin_profile.id, privilege_id: @privilegeManageUser.id)

Profiles::AccessPrivilege.create!(profile_id: @admin_profile.id, privilege_id: @privilegeManageUser.id)

Profiles::AccessPrivilege.create!(profile_id: @manager_profile.id, privilege_id: @privilegeManageOrders.id)
Profiles::AccessPrivilege.create!(profile_id: @manager_profile.id, privilege_id: @privilegeManageOrdersNew.id)
Profiles::AccessPrivilege.create!(profile_id: @manager_profile.id, privilege_id: @privilegeManageOrdersSearch.id)

Profiles::AccessPrivilege.create!(profile_id: @manager_profile.id, privilege_id: @privilegeManageClient.id)
Profiles::AccessPrivilege.create!(profile_id: @manager_profile.id, privilege_id: @privilegeManageClientNew.id)
Profiles::AccessPrivilege.create!(profile_id: @manager_profile.id, privilege_id: @privilegeManageClientSearch.id)

Profiles::AccessPrivilege.create!(profile_id: @sales_profile.id, privilege_id: @privilegeManageOrders.id)
Profiles::AccessPrivilege.create!(profile_id: @sales_profile.id, privilege_id: @privilegeManageOrdersNew.id)
Profiles::AccessPrivilege.create!(profile_id: @sales_profile.id, privilege_id: @privilegeManageOrdersSearch.id)

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
  application_date: Faker::Date.between(from: "2022-01-23", to: "2022-01-25"),
  last_application_date: Faker::Date.between(from: "2022-01-25", to: "2022-02-15"),
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
  application_date: Faker::Date.between(from: "2022-01-23", to: "2022-01-25"),
  last_application_date: Faker::Date.between(from: "2022-01-25", to: "2022-02-15"),
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
  application_date: Faker::Date.between(from: "2022-01-23", to: "2022-01-25"),
  last_application_date: Faker::Date.between(from: "2022-01-25", to: "2022-02-15"),
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
  application_date: Faker::Date.between(from: "2022-01-23", to: "2022-01-25"),
  last_application_date: Faker::Date.between(from: "2022-01-25", to: "2022-02-15"),
  area: Faker::Number.between(from: 1, to: 50),
  location: Faker::Address.full_address,
  salary: Faker::Number.between(from: 1000, to: 5000),
  external_link: Faker::Internet.domain_name,
  job_organization_id: @jo4.id,
)

@category1 = Products::Category.create(
  title: "Tapices Inca",
  description: "Tapices Inca",
  slug: "tapices-inca",
  product_count: 0,
  icon: "/assets/images/category/tapices/tapices-inca-300x300.jpg",
  account_id: @account_sulca.id,
)

@image1 = Products::Categories::Image.create(
  thumbnail: "/assets/images/category/tapices/tapices-inca-300x300.jpg",
  original: "/assets/images/category/tapices/tapices-inca-300x300.jpg",
  product_categories_id: @category1.id,
)

@product1 = Product.create(
  title: "Tapiz Wari Images Zoomorfas",
  price: 12,
  published: true,
  description: "testing testing",
  slug: "tapiz-wari-images-zoomorfas",
  slug_collection: @category1.slug,
  sale_price: 14,
  product_category_id: @category1.id,
  account_id: @account_sulca.id,
)

@product1_image1 = Products::Image.create(
  thumbnail: "/assets/images/category/tapices/tapices-inca-300x300.jpg",
  original: "/assets/images/category/tapices/tapices-inca-300x300.jpg",
  product_id: @product1.id,
)

@product1_image2 = Products::Image.create(
  thumbnail: "/assets/images/category/tapices/tapices-inca-300x300.jpg",
  original: "/assets/images/category/tapices/tapices-inca-300x300.jpg",
  product_id: @product1.id,
)

@category2 = Products::Category.create(
  title: "Tapices Pre-Inca",
  description: "Tapices Pre-Inca",
  slug: "tapices-pre-inca",
  product_count: 0,
  icon: "/assets/images/category/icons/woman.png",
  account_id: @account_sulca.id,
)

@image2 = Products::Categories::Image.create(
  thumbnail: "/assets/images/category/tapices/tapices-pre-inca-300x300.jpg",
  original: "/assets/images/category/tapices/tapices-pre-inca-300x300.jpg",
  product_categories_id: @category2.id,
)

@category3 = Products::Category.create(
  title: "Tapices Coloniales",
  description: "Tapices Coloniales",
  slug: "tapices-coloniales",
  product_count: 0,
  icon: "/assets/images/category/icons/woman.png",
  account_id: @account_sulca.id,
)

@image3 = Products::Categories::Image.create(
  thumbnail: "/assets/images/category/tapices/tapiz-colonial-300x300.jpg",
  original: "/assets/images/category/tapices/tapiz-colonial-300x300.jpg",
  product_categories_id: @category3.id,
)

@category4 = Products::Category.create(
  title: "Arte Moderno",
  description: "Arte Moderno",
  slug: "arte-moderno",
  product_count: 20,
  icon: "/assets/images/category/icons/woman.png",
  account_id: @account_sulca.id,
)

@image4 = Products::Categories::Image.create(
  thumbnail: "/assets/images/category/tapices/arte-moderno-300x300.jpg",
  original: "/assets/images/category/tapices/arte-moderno-300x300.jpg",
  product_categories_id: @category4.id,
)

@category5 = Products::Category.create(
  title: "Arte 3D",
  description: "Arte 3D",
  slug: "arte-3d",
  product_count: 20,
  icon: "/assets/images/category/icons/woman.png",
  account_id: @account_sulca.id,
)

@image5 = Products::Categories::Image.create(
  thumbnail: "/assets/images/category/tapices/arte-3d-300x300.jpg",
  original: "/assets/images/category/tapices/arte-3d-300x300.jpg",
  product_categories_id: @category5.id,
)

@category6 = Products::Category.create(
  title: "Arte Pre-Colombino",
  description: "Arte Pre-Colombino",
  slug: "arte-pre-colombino",
  product_count: 20,
  icon: "/assets/images/category/icons/woman.png",
  account_id: @account_sulca.id,
)

@image6 = Products::Categories::Image.create(
  thumbnail: "/assets/images/category/tapices/arte-pre-colombino.jpg",
  original: "/assets/images/category/tapices/arte-pre-colombino.jpg",
  product_categories_id: @category6.id,
)

@category7 = Products::Category.create(
  title: "Tapices 3D",
  description: "Tapices 3D",
  slug: "tapices-3D",
  product_count: 20,
  icon: "/assets/images/category/icons/woman.png",
  account_id: @account_sulca.id,
)

@image7 = Products::Categories::Image.create(
  thumbnail: "/assets/images/category/tapices/tapices-arte-3d-5-300x300.jpg",
  original: "/assets/images/category/tapices/tapices-arte-3d-5-300x300.jpg",
  product_categories_id: @category7.id,
)

@category8 = Products::Category.create(
  title: "Arte Moderno",
  description: "Arte Moderno",
  slug: "arte-moderno",
  product_count: 20,
  icon: "/assets/images/category/tapices/tapiz-arte-moderno-2-300x300.jpg",
  account_id: @account_sulca.id,
)

@image8 = Products::Categories::Image.create(
  thumbnail: "/assets/images/category/tapices/tapiz-arte-moderno-2-300x300.jpg",
  original: "/assets/images/category/tapices/tapiz-arte-moderno-2-300x300.jpg",
  product_categories_id: @category8.id,
)

@person1 = Person.create(
  first_name: Faker::Name.first_name,
  last_name: Faker::Name.last_name,
  doc_id: Faker::IDNumber.brazilian_id,
  address: Faker::Address.full_address,
  cell_phone: Faker::PhoneNumber.cell_phone_in_e164,
  contact_phone: Faker::PhoneNumber.cell_phone_in_e164,
  district: 1,
  province: 1,
  deparment: 1,
  country: 1,
  nationality: Faker::Nation.nationality,
  age: Faker::Number.between(from: 1, to: 120),
  ocupation: Faker::Job.title,
)

OptometricHistory.create(
  av_od_sc: "string",
  av_oi_sc: "string",
  av_od_cc: "string",
  av_oi_cc: "string",
  ph_od: "string",
  ph_oi: "string",
  k_od: "string",
  k_oi: "string",
  ret_od: "string",
  ret_oi: "string",
  rx_sph_od: "string",
  rx_sph_oi: "string",
  rx_cyl_od: "string",
  rx_cyl_oi: "string",
  rx_eje_od: "string",
  rx_eje_oi: "string",
  rx_dip_od: "string",
  rx_dip_oi: "string",
  mot_ocular: "string",
  cover_test: "string",
  kappa_od: "string",
  kappa_oi: "string",
  hirschberg: "string",
  rpupilares_fotom: "string",
  rpupilares_consensual: "string",
  rpupilares_acomodativo: "string",
  dnp_od: "string",
  dnp_oi: "string",
  av_od: "string",
  av_oi: "string",
  a_v_ao_od: "string",
  a_v_ao_oi: "string",
  cerca_add_od: "string",
  cerca_add_oi: "string",
  people_id: @person1.id,
)
#Product.create(
#  title: 'Tapiz Wari Images Geometricas',
#  price: 12,
#  published: true,
#  description: "testing testing",
#  slug: "tapiz-wari-images-zoomorfas",
#  sale_price: 14,
#  product_category_id: @category1.id
#)

#Product.create(
#  title: 'Tapiz Wari Images Triangulares',
#  price: 12,
#  published: true,
#  description: "testing testing",
#  slug: "tapiz-wari-images-zoomorfas",
#  sale_price: 14,
#  product_category_id: @category1.id
#)

#Job::Type.create(title: "Convocatorias Vigentes")
#Job::Type.create(title: "Convocatorias Cas")
#Job::Type.create(title: "Practicas")
#Job::Type.create(title: "Anuncios Privados")

#Job::Profession.create(title: "Abogado")
#Job::Profession.create(title: "Ingeniero Civil")
#Job::Profession.create(title: "Administrador")
#Job::Profession.create(title: "Contador")
#Job::Profession.create(title: "Ingeniero de Sistemas")
