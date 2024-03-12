class AvatarComponent < ViewComponent::Base
  SIZES = {
    small: "h-6 w-6",
    medium: "h-8 w-8",
    large: "h-10 w-10",
    xlarge: "h-12 w-12",
    xxlarge: "h-14 w-14"
  }.freeze

  def initialize(image_url: nil, size: :medium, alter: '', text: '', data: {}, zoomable: false)
    @zoomable = zoomable
    @image_url = image_url
    @size = size
    @alter = alter
    @text = text
    @data = data
    @data = @data.merge({ action: "click->avatar-component#showModal" }) if @zoomable
  end

  def tailwind_classes
    classes = "inline-block rounded-full #{SIZES[@size]} mx-2 object-cover object-center"
    classes += ' cursor-pointer hover:opacity-70' if @zoomable
    classes
  end

  def not_found_avatar_svg
    tag.svg class: "#{tailwind_classes} text-gray-300", "aria-hidden" => "true", fill: "currentColor", viewbox: "0 0 24 24", data: { form_field_component_controller_target: 'avatar' } do
      tag.path d: "M18.685 19.097A9.723 9.723 0 0021.75 12c0-5.385-4.365-9.75-9.75-9.75S2.25 6.615 2.25 12a9.723 9.723 0 003.065 7.097A9.716 9.716 0 0012 21.75a9.716 9.716 0 006.685-2.653zm-12.54-1.285A7.486 7.486 0 0112 15a7.486 7.486 0 015.855 2.812A8.224 8.224 0 0112 20.25a8.224 8.224 0 01-5.855-2.438zM15.75 9a3.75 3.75 0 11-7.5 0 3.75 3.75 0 017.5 0z"
    end
  end
end
