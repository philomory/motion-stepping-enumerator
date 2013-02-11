# Implementation inspired by _Practicing Ruby_ article:
# https://practicingruby.com/articles/shared/eislpkhxolnr

class StopIteration < IndexError; end

class Enumerator
  def peek
    @__stepping_fiber ||= Fiber.new do
      each { |e| Fiber.yield(e) }
      
      raise StopIteration
    end
    
    @__stepping_stored_value ||= if @__stepping_fiber.alive?
      result = @__stepping_fiber.resume
      raise result if result.is_a? StopIteration
      result
    else
      raise StopIteration
    end
    
    @__stepping_stored_value
  end
  
  def next
    result = peek
    @__stepping_stored_value = nil
    result
  end
  
  def rewind
    Fiber.delete_fiber @__stepping_fiber.__id__
    @__stepping_fiber = nil
    self
  end
end
      