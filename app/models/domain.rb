class Domain < ActiveRecord::Base

  belongs_to :account
  has_many :events

  validates :address, :presence => true
  validates :name, :length => { :maximum => 20 }

  def new
    @title = "New Domain"
  end

  def create
    @domain = Domain.new(params[:domain])
    if @domain.save
      redirect_to #dashboard
    else
      @title = "New Domain"
      render 'new'
    end
  end
end
