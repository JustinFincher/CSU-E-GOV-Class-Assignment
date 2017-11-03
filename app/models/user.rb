class User < ApplicationRecord
  has_secure_password
  has_many :documents
  serialize :to_review_documents,Array
end
