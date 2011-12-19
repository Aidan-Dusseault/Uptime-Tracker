require 'net/http'

class SiteCheckController < ApplicationController

  def index
    check_domains
  end

  def check_domains
    check(Domain.all)
  end

  def check_user_domains
    User.find(params[:id]).accounts.each do |account|
      check(account.domains)
    end
  end

  def check_account_domains
    check(Account.find(params[:id]).domains)
  end

  def check_single_domain
    #The check method receives an array, so the single domain is wrapped in an array before being passed as an argument.
    check([Domain.find(params[:id])])
  end

  private

  def up?(url)
    Net::HTTP.new(url).head('/').kind_of? Net::HTTPOK
  end

  def check(domains)
    domains.each do |domain|
      http_response = up?(domain.address)

      if http_response && domain.status != 2
        domain.events.build(:status_change => 2)
        domain.status = 2
        domain.last_checked = Time.now.utc
        domain.save
      end

      if !http_response && domain.status != 0
        domain.events.build(:status_change => 0)
        domain.status = 0
        domain.last_checked = Time.now.utc
        domain.save
        end
      end
    if domains.empty?
      flash[:error] = "No domains found!"
    end
  end
end
