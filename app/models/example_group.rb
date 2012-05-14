class ExampleGroup < ActiveRecord::Base
  belongs_to :iteration
  belongs_to :example_group
  
  has_many :examples, dependent: :destroy
  has_many :example_groups, dependent: :destroy
  
  def iteration
    super.nil? ? example_group.nil? ? nil : example_group.iteration : super
  end
  
  # def as_json(opts={})
  #   super( opts.merge(:methods => [:example_ids, :example_group_ids]) )
  # end
end