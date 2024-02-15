class FlashMessageComponent < ViewComponent::Base
  def initialize(message:, text: nil, type:, delay: '3000')
    @message = message
    @text = text
    @delay = delay
    @type = type
  end

  def classes_by_type
    case @type
    when 'notice'
      [" transition transform duration-1000 fixed inset-0 flex items-end justify-center px-4 py-6 pointer-events-none sm:p-6 sm:pt-16 sm:items-start sm:justify-end z-50",
       " max-w-sm w-full bg-green-50 shadow-lg pointer-events-auto rounded-lg shadow-xs overflow-hidden p-4",
       " h-6 w-6 text-green-400 bi-check-circle-fill mt-1",
       " text-sm font-medium text-green-800",
       " bg-green-50 rounded-md inline-flex text-shadowy-200 hover:text-shadowy-200 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-green-500"]
    when 'alert'
      [" transition transform duration-1000 fixed inset-0 flex items-end justify-center px-4 py-6 pointer-events-none sm:p-6 sm:pt-16 sm:items-start sm:justify-end z-50",
       " max-w-sm w-full bg-red-50 shadow-lg pointer-events-auto rounded-lg shadow-xs overflow-hidden p-4",
       " h-6 w-6 text-red-400 bi-check-circle-fill mt-1",
       " text-sm font-medium text-red-800",
       " bg-red-50 rounded-md inline-flex text-shadowy-200 hover:text-shadowy-200 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-red-500"]
    else
      [" transition transform duration-1000 fixed inset-0 flex items-end justify-center px-4 py-6 pointer-events-none sm:p-6 sm:pt-16 sm:items-start sm:justify-end z-50",
       " max-w-sm w-full bg-blue-50 shadow-lg pointer-events-auto rounded-lg shadow-xs overflow-hidden p-4",
       " h-6 w-6 text-blue-400 bi-question-circle-fill",
       " text-sm font-medium text-blue-800",
       " bg-blue-50 rounded-md inline-flex text-shadowy-200 hover:text-shadowy-200 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-blue-500"]

    end
  end

  def svg_by_type
    case @type
    when 'notice'
      '<svg class="h-6 w-6 text-green-400" aria-hidden="true" fill="none" stroke="currentColor" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg"><path d="M9 12l2 2 4-4m6 2a9 9 0 11-18 0 9 9 0 0118 0z" stroke-linecap="round" stroke-linejoin="round" stroke-width="2"></path></svg>'.html_safe

    when 'alert'
      '<svg class="h-6 w-6 text-red-400" fill="none" stroke="currentColor" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg"><path d="M10 14l2-2m0 0l2-2m-2 2l-2-2m2 2l2 2m7-2a9 9 0 11-18 0 9 9 0 0118 0z" stroke-linecap="round" stroke-linejoin="round" stroke-width="2"></path></svg>'.html_safe

    else
      '<svg class="h-6 w-6 text-blue-400" aria-hidden="true" fill="none" stroke="currentColor" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg"><path d="M9 12l2 2 4-4m6 2a9 9 0 11-18 0 9 9 0 0118 0z" stroke-linecap="round" stroke-linejoin="round" stroke-width="2"></path></svg>'.html_safe
    end
  end

end