# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.create!(
  email: 'harubaruharu_over3010@yahoo.co.jp',
  name: '管理者',
  role: 'admin',
  password: 'RunYuto0818', 
  password_confirmation: 'RunYuto0818', 
  agreement: true,
  created_at: "2023-02-01 00:00:00", 
  updated_at: "2023-02-01 00:00:00")
