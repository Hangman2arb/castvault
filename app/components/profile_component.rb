class ProfileComponent < ViewComponent::Base
  def initialize(profile:)
    @profile = profile
  end
end
