require 'spec_helper'

describe Event do
  
  before(:each) do
    @domain = Factory(:domain)
    @attr = { :status_change => 0, :domain => @domain }
  end
end
