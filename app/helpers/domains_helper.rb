module DomainsHelper
  
  def domain_name(domain)
    unless domain.name.blank?
      domain.name
    else
      if domain.address.length > 97
        domain.address.slice(0, 97).concat("...")
      else
        domain.address
      end
    end
  end
end
