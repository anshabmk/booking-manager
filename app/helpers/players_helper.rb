module PlayersHelper
  def players_index_header_names
    [
      'Name',
      'Mobile Number',
      'E-mail ID',
      'No. of games'
    ]
  end

  def players_index_header_methods
    %w[fullname mobile_number email_id games_count]
  end
end
