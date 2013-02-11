# Specs based off of RubySpec for Enumator
# https://github.com/rubyspec/rubyspec/blob/master/shared/enumerator/rewind.rb

describe "Enumerator#rewind" do
  before do
    @enum = (1..3).to_a.to_enum
  end
  
  it "resets the enumerator to its initial state" do
    @enum.next.should == 1
    @enum.next.should == 2
    @enum.rewind
    @enum.next.should == 1
  end
  
  it "returns self" do
    @enum.rewind.should == @enum
  end
  
  it "has no effect on a new enumerator" do
    @enum.rewind
    @enum.next.should == 1
  end
  
  it "has no effect if called multiple, consecutive times" do
    @enum.next.should == 1
    @enum.rewind
    @enum.rewind
    @enum.next.should == 1
  end
  
  it "works with peek to reset the position" do
    @enum.next
    @enum.next
    @enum.rewind
    @enum.next
    @enum.peek.should == 2
  end
  
end