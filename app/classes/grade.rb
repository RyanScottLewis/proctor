class Grade
  LETTERS = ('A'..'F').inject([]) { |m, l| m + "#{l}+ #{l} #{l}-".split }
  GRADES = LETTERS.reverse.each_with_object({}).with_index do |(g, m), i|
    m[ (i/18.0)*100.0..((i+1)/18.0)*100.0 ] = g
  end
  
  JUDGEMENTS = {
    (0.0...3.0) => 'horrible',
    (3.0...6.0) => 'failing',
    (6.0...9.0) => 'bad',
    (9.0...12.0) => 'alright',
    (12.0...15.0) => 'good',
    (15.0...18.0) => 'great'
  }
  
  attr_reader :passed, :count
  
  def initialize(opts={})
    raise(TypeError, 'opts must be a Hash or be Hash-like') unless opts.respond_to?(:to_hash)
    opts = HashWithIndifferentAccess.new(opts) unless opts.is_a?(HashWithIndifferentAccess)
    raise(ArgumentError, 'opts must contain key :passed') unless opts.has_key?(:passed)
    raise(ArgumentError, 'opts must contain key :count') unless opts.has_key?(:count)
    
    self.passed = opts[:passed]
    self.count = opts[:count]
  end
  
  def passed=(value)
    raise(TypeError, 'value must be an Integer or respond to :to_i') unless value.is_a?(Integer) || value.respond_to?(:to_i)
    value = value.to_i unless value.is_a?(Integer)
    
    @passed = value
  end
  
  def count=(value)
    raise(TypeError, 'value must be an Integer or respond to :to_i') unless value.is_a?(Integer) || value.respond_to?(:to_i)
    value = value.to_i unless value.is_a?(Integer)
    raise(ArgumentError, 'value must be greater than 0') unless value > 0
    
    @count = value
  end
  
  def percentage
    (@passed.to_f / @count.to_f) * 100.0
  end
  
  def grade
    GRADES.find { |range, g| range.include?(percentage) }.last
  end
  
  def judgement
    JUDGEMENTS.find { |range, j| range.include?( LETTERS.reverse.index(grade) ) }.last
  end
end