class Project < ActiveRecord::Base
  belongs_to :client
  has_many :iterations
end