json.profile do |json|
  json.partial! 'profiles/profile', profile: @profile, current_user: current_user
end
