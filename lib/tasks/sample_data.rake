namespace :db do
  desc "Fill database with sample data"
  task :populate => :environment do
    Rake::Task['db:reset'].invoke
    50.times do |n|
      username = "username#{n+1}"
      email = "example-#{n+1}@email.com"
      password = "password"
      User.create!(:name                  => "Example User",
                   :username              => username,
                   :email                 => email,
                   :password              => password,
                   :password_confirmation => password)
    end
    150.times do
      Account.create!(:name => "Example Account")
    end
    150.times do |n|
      User.find(1+rand(50)).accounts << Account.find(n+1)
    end
    150.times do |n|
      account = Account.find(n+1)
      account.memberships.first.owner = true
      account.memberships.first.save
    end
    450.times do
      Domain.create!(:name => "Example Domain", :address => "www.google.ca", :account_id => 1+rand(150), :check_interval => 0)
    end
  end
end
