class PricingComponent < ViewComponent::Base

  NUM_OF_FEATURES = 5

  def initialize(for_manager: false)
    @prices_monthly = fetch_prices_with_cache('prices_monthly', %w[basic_monthly pro_monthly elite_monthly])
    @prices_yearly = fetch_prices_with_cache('prices_yearly', %w[basic_yearly pro_yearly elite_yearly])
    @for_manager = for_manager

    @prices_monthly.each{ |price| price.product.description = I18n.t("landing_pricing_component.monthly_description.#{price.product.name.downcase}").html_safe }
    @prices_yearly.each{ |price| price.product.description = I18n.t("landing_pricing_component.yearly_description.#{price.product.name.downcase}").html_safe }

    @features = {}

    @prices_yearly.each do |price|
      @features[price.product.name.downcase] = []
      NUM_OF_FEATURES.times do |index|
        @features[price.product.name.downcase].push I18n.t("landing_pricing_component.features.#{price.product.name.downcase}.#{index}").html_safe
      end
    end

    # Intercambiando los elementos en los arrays
    @prices_monthly[0], @prices_monthly[1] = @prices_monthly[1], @prices_monthly[0]
    @prices_yearly[0], @prices_yearly[1] = @prices_yearly[1], @prices_yearly[0]
  end


  private

  def fetch_prices_with_cache(cache_key, lookup_keys)
    Rails.cache.fetch(cache_key, expires_in: 24.hours) do
      fetch_prices_from_stripe(lookup_keys)
    end
  end

  def fetch_prices_from_stripe(lookup_keys)
    Stripe::Price.list(lookup_keys: lookup_keys, active: true, expand: ['data.product']).data.sort_by(&:unit_amount)
  end

  def plan_classes(index)
    (index == 1) ? 'flex flex-col rounded-3xl px-6 sm:px-8 order-first bg-blue-600 py-8 lg:order-none' : 'flex flex-col rounded-3xl px-6 sm:px-8 lg:py-8'
  end

  def link_classes(index)
    (index == 1) ? 'cursor-pointer group inline-flex items-center justify-center rounded-full py-2 px-4 text-sm font-semibold focus:outline-none focus-visible:outline-2 focus-visible:outline-offset-2 bg-white text-slate-900 hover:bg-blue-50 active:bg-blue-200 active:text-slate-600 focus-visible:outline-white mt-8' : 'cursor-pointer group inline-flex ring-1 items-center justify-center rounded-full py-2 px-4 text-sm focus:outline-none ring-slate-700 text-white hover:ring-slate-500 active:ring-slate-700 active:text-slate-400 focus-visible:outline-white mt-8'
  end

  def list_text_classes(index)
    (index == 1) ? 'text-white' : 'text-slate-200'
  end

  def description_text_classes(index)
    (index == 1) ? 'text-white' : 'text-slate-400'
  end

  def icon_classes(index)
    (index == 1) ? 'h-6 w-6 flex-none fill-current stroke-current text-white' : 'h-6 w-6 flex-none fill-current stroke-current text-slate-400'
  end

  def rounded_classes(index)
    (index == 1) ? 'ring-primary' : 'ring-gray-200'
  end

  def manager_plan_classes(index)
    (index == 1) ? 'text-primary' : 'text-shadowy-300'
  end

  def manager_link_classes(index)
    (index == 1) ? 'cursor-pointer mt-6 block rounded-md py-2 px-3 text-center text-sm font-semibold leading-6 focus-visible:outline focus-visible:outline-2 focus-visible:outline-offset-2 focus-visible:outline-primary bg-primary text-white shadow-sm hover:bg-primary' : 'cursor-pointer mt-6 block rounded-md py-2 px-3 text-center text-sm font-semibold leading-6 focus-visible:outline focus-visible:outline-2 focus-visible:outline-offset-2 focus-visible:outline-primary text-primary ring-1 ring-inset ring-primary hover:ring-primary'
  end

end