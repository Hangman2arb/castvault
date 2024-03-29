class ProfileCardComponent < ViewComponent::Base
  def initialize(photo: nil, name: 'No name', surname: 'No surname', agency: 'No agency', email: 'No email', phone: 'No email', id:)
    @initial_photo = photo
    @name = name
    @surname = surname
    @agency = agency
    @email = email
    @phone = phone
    @id = id
  end

  def photo
    if @initial_photo&.attached?
      url_for(@initial_photo.variant(resize_to_limit: [150, 150]).processed)
    else
      image_url('no_profile_photo.svg')
    end
  end
end
