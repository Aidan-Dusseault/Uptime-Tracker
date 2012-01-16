Factory.define :user do |user|
  user.name                  "User"
  user.username              "Username"
  user.email                 "example@email.com"
  user.password              "password"
  user.password_confirmation "password"
end

Factory.define :account do |account|
  account.name  "Account"
  account.users {|users| [users.association(:user)]}
end

Factory.define :domain do |domain|
  domain.name           "Domain"
  domain.address        "www.google.ca"
  domain.status         2
  domain.accounts       {|accounts| [accounts.association(:account)]}
  domain.check_interval 5
end

Factory.define :event do |event|
  event.status_change 0
  event.domains       {|domains| [domains.association(:domain)]}
end

Factory.sequence :username do |n|
  "Username #{n}"
end

Factory.sequence :email do |n|
  "email#{n}@example.com"
end
