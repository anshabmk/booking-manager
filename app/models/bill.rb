class Bill < ApplicationRecord
  has_many :bill_amounts, dependent: :destroy

  def date_range
    from_date_parsed = parse_date(self.from_date)
    to_date_parsed = parse_date(self.to_date)

    "#{from_date_parsed} - #{to_date_parsed}"
  end

  private

  def parse_date(date)
    date&.strftime('%d %b %Y')
  end
end
