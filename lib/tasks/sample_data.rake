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
    150.times do |n|
      Account.create!(:name => "Example Account #{n}")
    end
    150.times do |n|
      User.find(1+rand(50)).accounts << Account.find(n+1)
    end
    150.times do |n|
      account = Account.find(n+1)
      m = account.memberships.first
      m.owner = true
      m.save
    end
    450.times do |n|
      if rand(2) == 1
        Domain.create!(:name => "Example Domain #{n}", :address => "www.google.ca", :account_id => 1+rand(150), :check_interval => 0)
      else
        Domain.create!(:address => "www.google.ca", :account_id => 1+rand(150), :check_interval => 0)
      end
    end
    900.times do
      Event.create!(:status_change => rand(3), :domain_id => 1+rand(450), :created_at => Time.now + rand(61))
    end
    Domain.all.each do |domain|
      if domain.events.first
        domain.status = domain.events.first.status_change
        domain.save
      end
    end
  end
end
