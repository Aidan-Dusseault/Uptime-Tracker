module DomainsHelper
  
  def domain_name(domain)
    unless domain.name.blank?
      domain.name
    else
      domain.address
    end
  end
end
