json.user do |json|
  json.partial! 'devise/shared/user', user: current_user
end
