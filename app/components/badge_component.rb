class BadgeComponent < ViewComponent::Base
  # Types:
  #   'gray'
  #   'red'
  #   'yellow'
  #   'green'
  #   'blue'
  #   'indigo'
  #   'purple'
  #   'pink'
  def initialize(text: 'NO DEFINED', type: 'red' )
    @text = text
    @type = type
  end

  def classes_by_type(type = @type)
    classes = {
      'gray' => 'inline-flex items-center rounded-xl bg-gray-50 px-4 py-2 text-xs font-medium text-shadowy-300 ring-1 ring-inset ring-gray-500/10',
      'red' => 'inline-flex items-center rounded-xl bg-red-50 px-4 py-2 text-xs font-medium text-red-700 ring-1 ring-inset ring-red-600/10',
      'yellow' => 'inline-flex items-center rounded-xl bg-yellow-50 px-4 py-2 text-xs font-medium text-yellow-800 ring-1 ring-inset ring-yellow-600/20',
      'green' => 'inline-flex items-center rounded-xl bg-green-50 px-4 py-2 text-xs font-medium text-green-700 ring-1 ring-inset ring-green-600/20',
      'blue' => 'inline-flex items-center rounded-xl bg-blue-50 px-4 py-2 text-xs font-medium text-blue-700 ring-1 ring-inset ring-blue-700/10',
      'indigo' => 'inline-flex items-center rounded-xl bg-indigo-50 px-4 py-2 text-xs font-medium text-indigo-700 ring-1 ring-inset ring-indigo-700/10',
      'purple' => 'inline-flex items-center rounded-xl bg-purple-50 px-4 py-2 text-xs font-medium text-purple-700 ring-1 ring-inset ring-purple-700',
      'pink' => 'inline-flex items-center rounded-xl bg-pink-50 px-4 py-2 text-xs font-medium text-pink-700 ring-1 ring-inset ring-pink-700/10',
      'primary' => 'inline-flex items-center rounded-xl bg-third px-4 py-2 text-xs font-medium text-primary ring-1 ring-inset ring-primary',
    }

    classes[type] || classes['gray']
  end

end
