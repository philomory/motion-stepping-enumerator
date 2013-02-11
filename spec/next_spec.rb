# Specs based off of RubySpec for Enumator
# https://github.com/rubyspec/rubyspec/blob/master/shared/enumerator/next.rb

describe "Enumerator#next" do
  before do
    @enum = (1..3).to_a.to_enum
  end
  
  it "returns the next element of the enumeration" do
    @enum.next.should == 1
    @enum.next.should == 2
    @enum.next.should == 3
  end
  
  it "raises a StopIteration exception at the end of the stream" do
    3.times { @enum.next }
    lambda { @enum.next }.should.raise(StopIteration)
  end
  
  it "cannot be called again until the enumerator is rewound" do
    3.times { @enum.next }
    lambda { @enum.next }.should.raise(StopIteration)
    lambda { @enum.next }.should.raise(StopIteration)
    lambda { @enum.next }.should.raise(StopIteration)
    @enum.rewind
    @enum.next.should == 1
  end
end
        