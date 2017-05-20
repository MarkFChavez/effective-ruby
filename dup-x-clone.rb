# Ruby's `dup` and `clone` methods

# The dup method duplicates an object but does not copy all of the object's contents. For instance, singleton
# methods are not copied. Let me show what this means.

class Person
  def name
    "a string that represents a name"
  end
end

p = Person.new.freeze
dup = p.dup
puts "Duped array is not frozen" unless dup.frozen?

# The clone method on the otherhand, copies the receiving object exactly. Even if the receving object is in a
# frozen state, the cloned object will also be frozen.

an_array = ["mark", "ian", "david", "joni"].map(&:freeze).freeze
cloned_array = an_array.clone
puts "Cloned array is frozen" if cloned_array.frozen?

# Let's see how are we actually going to apply these methods IRL

an_initial_array = ["Australia", "Singapore", "Malaysia", "Taiwan", "Australia"]
def a_method_that_mutates_array(array_arg)
  array_arg << "Iceland"
end
p a_method_that_mutates_array(an_initial_array)
p an_initial_array

# As you can see in the above example, the `an_initial_array` array object was also mutated and this doesn't seem
# right. Let's solve this problem by using `dup` instead.

def a_method_that_mutates_array(array_arg)
  array_arg.dup << "Iceland" # note my use of `dup` here
end
p a_method_that_mutates_array(an_initial_array)
p an_initial_array
