json.call(profile, :username, :bio, :image)
json.following current_user.following?(profile) if current_user
