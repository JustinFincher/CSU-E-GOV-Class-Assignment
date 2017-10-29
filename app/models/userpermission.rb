class Userpermission < ApplicationRecord
  enum phone_number_type: [:root, :admin, :user, :manager, :leader]
end
