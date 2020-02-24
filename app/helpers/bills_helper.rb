module BillsHelper
  def bills_index_header_names
    ['Date range', 'Fee per game', 'Total amount']
  end

  def bills_index_header_methods
    %w[strf_date_range fee_per_game total_amount]
  end
end
