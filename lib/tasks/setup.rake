desc "drops the db, creates db, migrates db and populates with sample data"

task setup: [:environment, "db:drop", "db:create", "db:migrate"] do
  Rake::Task['populate_with_sample_data'].invoke if Rails.env.development?
end

task populate_with_sample_data: :environment do
  if Rails.env.production?
    puts "Skipping deleting and populating sample data in production"
  else
    create_sample_data!
    puts "Sample data has been added."
  end
end

def create_sample_data!
  puts "Seeding with sample data"
  create_user! email: "oliver@example.com", name: "Oliver"
  create_user! email: "bhat@dev.com", name: "Krishna Bhat", password: "thisisgreat"
  puts "Done, 2 users Oliver and Krishna Bhat created, with both password as welcome and thisisgreat respectively"
end

def create_user!(options={})
  # custom passwords can be specified at function call
  user_attributes = {password: "welcome"}
  attributes = user_attributes.merge options
  attributes[:password_confirmation] = attributes[:password]
  User.create! attributes
end
