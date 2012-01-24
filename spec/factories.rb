Factory.define :user do |user|
  user.name                  "User"
  user.sequence(:username)   { |n| "Username #{n}" }
  user.sequence(:email)      { |n| "email#{n}@example.com" }
  user.password              "password"
  user.password_confirmation "password"
end

Factory.define :account do |account|
  account.name  "Account"
end

Factory.define :membership do |membership|
  membership.association :user
  membership.association :account
end

Factory.define :domain do |domain|
  domain.name           "Domain"
  domain.address        "www.google.ca"
  domain.status         1
  domain.association    :account
  domain.check_interval 5
end

Factory.define :event do |event|
  event.status_change 0
  event.association   :domain
end

Factory.sequence :username do |n|
  "Username #{n}"
end

Factory.sequence :email do |n|
  "email#{n}@example.com"
end
