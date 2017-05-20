# Using the Struct, for building a collection of entity

# The powerful, yet unknown to most Ruby developers is the Struct. It is a very simple data
# structure that is similar to a class but less powerful. So, how can we use Struct to solve
# our day-to-day problems? First, let me show you how to use it on a very basic way.

Company = Struct.new(:name) # this is how you create a Struct

# create instances of the newly-created Struct
company_a = Company.new("Company A")
company_b = Company.new("Company B")

puts company_a.name
puts company_b.name

# You can even add instance methods to it if you want to, like this.
Point = Struct.new(:x, :y) do
  def coords
    [x, y]
  end
end

p Point.new(20, 50).coords

# Usually, we build collections and store hashes to it.
result = []
["Ruby", "Java", "C"].each do |language|
  result << {
    language: language
  }
end
p result

# Instead of stories the hashes, why don't we use Struct? Let's try it!
Language = Struct.new(:name)
result = []
["Ruby", "Java", "C"].each do |language|
  result << Language.new(language)
end
p result

# This solution is better and more readable.
