class UserPermission
  include Ruby::Enum

  define :root, 0
  define :admin, 64
  define :leader, 128
  define :manager, 256
  define :user, 512
end

# enum user_permission_type: { root: 0, admin: 64 ,user: 512,manager: 256,leader: 128 }