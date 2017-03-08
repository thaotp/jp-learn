class SearchKotoba < ActiveRecord::Base
  self.primary_key = :id
  self.inheritance_column = :__disabled__
end
