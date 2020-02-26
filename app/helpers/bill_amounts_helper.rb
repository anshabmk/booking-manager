# frozen_string_literal: true

# BillAmounts helper methods
module BillAmountsHelper
  def bill_amounts_index_header_names
    ['Bill ID', 'Amount']
  end

  def bill_amounts_index_header_methods
    %w[bill_id amount]
  end
end
