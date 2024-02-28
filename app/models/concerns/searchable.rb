module Searchable
  extend ActiveSupport::Concern

  class_methods do
    def search(term, search_fields)
      return all if term.blank?

      sanitized_query = sanitize_sql_like(I18n.transliterate(term).downcase.gsub(/\s+/, ''))

      conditions = search_fields.map do |key|
        "LOWER(regexp_replace(unaccent(#{key}), '\s+', '', 'g')) LIKE ?"
      end.join(' OR ')

      where(conditions, *search_fields.map { "%#{sanitized_query}%" })
    end

    def filter_by_dates(date_range, key)
      return all unless date_range.present?

      start_date, end_date = date_range.split(' - ').map do |date_str|
        Date.strptime(date_str, "%d/%m/%Y")
      end

      where("date(#{key}) BETWEEN ? AND ?", start_date, end_date)
    end

    def sort_direction direction
      %w( asc desc ).include?(direction) ? direction : 'asc'
    end

    def sort_column sort
      begin
        self::SORTING_KEYS.include?(sort) ? sort : 'id'
      rescue => e
        raise e.message
      end
    end
  end
end