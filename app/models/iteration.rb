class Iteration < ActiveRecord::Base
  belongs_to :project
  has_many :example_groups, dependent: :destroy
end