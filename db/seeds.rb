# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

def random_record(model_class:)
  random_records(model_class: model_class)[0]
end

def random_records(model_class:, count: 1)
  model_class.where(id: model_class.ids.sample(count)).all
end

10.times do
  Customer.create!(
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    title: Faker::Lorem.word,
    email: Faker::Internet.email
  )
end

suppliers = []
5.times do
  supplier = Supplier.create!(name: Faker::Name.name)
  suppliers.push(supplier)
end

5.times do
  Author.create!(
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    title: Faker::Lorem.word
  )
end

5.times do
  Book.create!(
    title: Faker::Book.title,
    year_published: Faker::Book,
    isbn: Faker::Code.isbn,
    price: (100..500).step(100).to_a.sample,
    author: random_record(model_class: Author),
    supplier: random_record(model_class: Supplier)
  )
end

5.times do
  Order.create!(
    date_submitted: rand(10.weeks.ago..1.day.ago),
    shipping: (0..500).step(50).to_a.sample,
    tax: (0..5).to_a.sample,
    customer: random_record(model_class: Customer),
    books: random_records(model_class: Book, count: (1..5).to_a.sample)
  )
end
