module UsersHelper
  # returns the gravatar for the given user.
  def gravatar_for(user, options = { size: 80 })
        size = options[:size]
        gravatar_id = Digest::MD5.hexdigest(user.email.to_s.strip.downcase)
        gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}?s=#{size}"
        image_tag(gravatar_url, atl: user.name, class: "gravatar")
  end
end
