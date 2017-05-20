# Using a Set for faster inclusion checking

# Inclusion checking on a set is an O(1) operation which makes it the best way to check if an element
# exists on a collection. Let me show you how it works.

# When checking if a Role has a specific permission, Ruby has to iterate each element to the permissions
# collection. This means that an O(n) operation is taking place which is not good if say, there are
# hundreds, or thousands of permissions needed to be passed.
class Role
  def initialize(name, permissions)
    @name = name
    @permissions = Array(permissions)
  end

  def can?(permission)
    @permissions.include?(permission)
  end
end

admin_permissions = ["company.manage", "reports.manage", "dashboard.manage"]
admin_role = Role.new(:admin, admin_permissions)
p admin_role.can?("dashboard.manage")

# It will be faster to use Set in this scenario because what we only need to do is check if the element
# is indeed in the collection. However, Set is not included in the Ruby core library but it is in the
# standard library. This means before using Set, we need to include the required library.

require 'set'

class Applicant
  def initialize(name, skills)
    @name = name
    @skills = Set.new(skills) # use Set
  end

  def can?(skill)
    @skills.include?(skill)
  end
end

skills = ["Ruby", "Ruby on Rails", "OOP", "SOLID"]
mark = Applicant.new("Mark Chavez", skills)
p mark.can?("Ruby")

# Things to Remember
# 1) Consider Set for efficient element inclusion checking
# 2) Objects inserted into a Set must also be usable as hash keys
# 3) Require the "set" file before using Set.
