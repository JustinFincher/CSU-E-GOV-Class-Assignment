class DocumentTag < ApplicationRecord
  include Ruby::Enum

  define :'普通事项', 1
  define :'急需处理', 2
end

# enum user_permission_type: { root: 0, admin: 64 ,user: 512,manager: 256,leader: 128 }