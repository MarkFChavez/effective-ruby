# Using delegation in Ruby

require 'forwardable' # in ruby standard library

# Delegation is better used instead of inheritance. Inheritance may produce confusing issues and is not a good
# design for this use case.

class Person
  extend Forwardable

  # delegate the #country method to the `address` object
  def_delegators :address, :country

  def initialize(name, address)
    @name = name
    @address = address
  end

  def address; @address; end
end

class Address
  attr_reader :country

  def initialize(country)
    @country = country
  end
end

address = Address.new("Australia")
person = Person.new("mark", address)

puts person.country

# When should I use delegation?
# If you think you will need to inherit some methods that belongs to a core Ruby class, then delegation
# might be a good solution.

# It is also a good approach to prevent Law of Demeter code smell.
