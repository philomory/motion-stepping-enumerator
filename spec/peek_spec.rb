# Specs based off of RubySpec for Enumator
# https://github.com/rubyspec/rubyspec/blob/master/core/enumerator/peek_spec.rb
describe "Enumerator#peek" do
  before do
    @e = (1..5).to_a.to_enum
  end
  
  it "returns the next element in self" do
    @e.peek.should == 1
  end
  
  it "does not advance the position of the current element" do
    @e.next.should == 1
    @e.peek.should == 2
    @e.next.should == 2
  end
  
  it "can be called repeatedly without advancing the position of the current element" do
    @e.peek
    @e.peek
    @e.peek.should == 1
    @e.peek.should == 1
  end
  
  it "works in concert with #rewind" do
    @e.next
    @e.next
    @e.rewind
    @e.peek.should == 1
  end
  
  it "raises StopIteration if called on a finished enumerator" do
    5.times { @e.next }
    lambda { @e.peek }.should.raise(StopIteration)
  end
end