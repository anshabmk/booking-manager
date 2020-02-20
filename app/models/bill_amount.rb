class BillAmount < ApplicationRecord
  belongs_to :bill
  belongs_to :player
end
