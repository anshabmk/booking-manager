module BillsHelper
  def bills_index_header_names
    ['Name', 'Date range', 'Fee per game', 'Total amount']
  end

  def bills_index_header_methods
    %w[name strf_date_range fee_per_game total_amount]
  end
end
