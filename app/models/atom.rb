class Atom < ApplicationRecord
  self.abstract_class = true
  #establish_connection "atom_#{Rails.env}"
end