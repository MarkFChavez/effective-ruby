# Ruby's `dup` and `clone` methods

# The dup and clone methods returns a shallow copy of an object. Let me show you what this means.

# 1) `dup` does not copy singleton methods
# 2) `dup` does not retain an object being frozen
# 3) `clone` does otherwise

class Person; end
original_person = Person.new

# add a singleton method for the original_person
def original_person.eat
  "Eating on a singleton method"
end
duped_person = original_person.dup

begin
  duped_person.eat
rescue
  puts "Cannot call #eat because you are calling it from a `duped` instance"
end

# Compared to `dup`, `clone` works very differently. Check this out.

# Even if the receving object is in a frozen state, the cloned object will also be frozen
an_array = ["mark", "ian", "david", "joni"].map(&:freeze).freeze # freeze this array and its elements
cloned_array = an_array.clone
puts "Cloned array is frozen" if cloned_array.frozen?

# Another good uses of `clone` method is it also copies the receiving object's singleton methods. Here is
# an example.
class Animal; end
dog = Animal.new

def dog.bark
  "I am barking using a singleton method"
end

cloned_dog = dog.clone
puts cloned_dog.bark

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

# Things to Remember
# 1) Method arguments in Ruby are passed by "reference", not by "value". Exceptions to this rule are Fixnum objects.
# 2) Duplicate collections passed as arguments before mutating them.
# 3) "dup" and "clone" methods only create shallow copies.
