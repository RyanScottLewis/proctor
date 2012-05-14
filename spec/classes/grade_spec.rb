require 'spec_helper'

RSpec::Matchers.define :have_passed do |expected|
  match { |grade| grade.passed == expected }
end

describe Grade do
  subject { Grade.new(passed: 5, count: 10) }
  
  describe "#passed" do
    it "should return the correct result" do
      subject.passed.should == 5
    end
  end
  
  describe "#count" do
    it "should return the correct result" do
      subject.count.should == 10
    end
  end
  
  describe "#percentage" do
    it "should return the correct result" do
      subject.percentage.should == 50.0
    end
  end
  
  describe "#grade" do
    it "should return the correct result" do
      subject.grade.should == 'D+'
    end
  end
  
  describe "#judgement" do
    it "should return the correct result" do
      subject.judgement.should == 'bad'
    end
  end
end