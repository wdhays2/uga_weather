# frozen_string_literal: true

module ResultsHelper
  def link_to_js_method(category, results)
    date_str = (results[0][:date].to_date - 2.days).to_s.delete('-')
    link_to(
      category[:name],
      '#',
      onclick: "setCategoryAndDateToUse('#{category[:name]}', '#{date_str}')"
    )
  end
end
