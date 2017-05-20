# Understanding how Kernel::Array works

# Pretty much most of my time as a Ruby developer has revolved around checking if the argument
# passed is of the right type. And I know you can relate at some point. Let me share to you
# what this means.

def print_each(collection)
  collection.each do |item|
    puts item
  end
end

print_each(["kotlin", "swift"]) # All is well

# Here we are looping through a collection and print each element using the #puts method. Now, what
# if you called that method like this. What do you think will happen? You got that right. The method
# return an exception and that is something we would like to avoid.

begin
  print_each("mark")
rescue
  "Undefined method `each` for String"
end

# This is where we will use Kernel::Array for. Basically, it tries to convert an argument to an array. Now,
# let's try to use that.

def print_each(collection)
  Array(collection).each do |item|
    puts item
  end
end

print_each([1, 2, 3])
print_each("mark")
print_each(nil)

# That's how easy it is. By using the Kernel::Array, we have made the method more robust thus making it more
# error-free compared to our original implementation.

# Kernel::Array works by calling #to_ary or #to_a and if the argument cannot be called with those methods, Array
# tries it best to make it an array.

# However, passing a Hash to the Array method works very differently since Hash has a built-in #to_a method that
# does this. Please keep this in mind.

hash = { person: "mark", location: "philippines" }
p Array(hash) # [[:person, "mark"], [:location, "philippines"]]

# Things to Remember
# 1) Use the Array method to convert `nil` and scalar objects into arrays.
# 2) Don't pass a Hash to the Array method; it will get converted into a st of nested arrays.
