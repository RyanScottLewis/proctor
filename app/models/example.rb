class Example < ActiveRecord::Base
  belongs_to :iteration
  belongs_to :example_group
  
  after_create :update_iteration_state
  
  def iteration
    super.nil? ? example_group.nil? ? nil : example_group.iteration : super
  end
  
  private
  
  def update_iteration_state
    case self.state
    when 'passing'
      self.iteration.update_attribute(:state, 'passing') unless ['pending', 'failing'].include?(self.iteration.state)
    when 'pending'
      self.iteration.update_attribute(:state, 'pending')
    when 'failing'
      self.iteration.update_attribute(:state, 'failing') unless self.iteration.state == 'pending'
    end if self.iteration
  end
end