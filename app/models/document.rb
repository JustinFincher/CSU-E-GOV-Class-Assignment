class Document < ApplicationRecord
  belongs_to :user
  serialize :reviews,Array
end
