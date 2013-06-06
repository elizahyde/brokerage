class Client < ActiveRecord::Base
  def portfolios
    has_many :portfolios
  end
end