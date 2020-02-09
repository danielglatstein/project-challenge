# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

users = [
  {
    name: "Wade Boggs",
    email: "wade@gmail.com"
  },
  {
    name: "Ken Griffey Jr.",
    email: "griffey@gmail.com"
  },
  {
    name: "Adrian Beltre",
    email: "yoadrian@gmail.com"
  },
  {
    name: "Rod Beck",
    email: "beck@gmail.com"
  },
  {
    name: "Kevin Brown",
    email: "brownie@gmail.com"
  }
]

dogs = [
  {
    name: 'Bowie',
    description: 'Bowie dances when he walks'
  },
  {
    name: 'Brownie',
    description: 'Brownie only sits pretty'
  },
  {
    name: 'Jax',
    description: '',
  },
  {
    name: 'Jiro',
    description: 'Jiro takes a long time to destroy his toys'
  },
  {
    name: 'Pete',
    description: 'Pete has a best friend named Lua'
  },
  {
    name: 'Bijou',
    description: 'Bijou is the fluffiest of them all'
  },
    {
    name: 'Britta',
    description: 'Britta has two different colored eyes'
  },
  {
    name: 'Noodle',
    description: 'Noodle is an Instagram celebrity'
  },
  {
    name: 'Stella',
    description: 'Stella loves to dig'
  },
  {
    name: 'Tonks',
    description: 'Tonks loves to run'
  },
]

users.each do |u| 
  u = User.find_or_initialize_by(
    name: u[:name], 
    email: u[:email]
  )
  u.password = "123456"
  u.password_confirmation = "123456"
  u.save
end

dogs.each do |dog|
  dog = Dog.find_or_create_by(name: dog[:name], description: dog[:description])
  dog.update(user: User.all.sample)
  directory_name = File.join(Rails.root, 'db', 'seed', "#{dog[:name].downcase}", "*")

  Dir.glob(directory_name).each do |filename|
    if !dog.images.any?{|i| i.filename == filename}
      dog.images.attach(io: File.open(filename), filename: filename.split("/").pop)
      sleep 1
    end
  end
end
