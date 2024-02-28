class ProfileCardComponent < ViewComponent::Base
  def initialize(photo: '', name: 'No name', surname: 'No surname', agency: 'No agency', email: 'No email', phone: 'No email')
    @photo = photo
    @name = name
    @surname = surname
    @agency = agency
    @email = email
    @phone = phone
  end
end
