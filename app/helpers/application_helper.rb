module ApplicationHelper
  def navbar_menu_items
    return admin_navbar_menu_items if admin?

    player_navbar_menu_items
  end

  def player_navbar_menu_items
    [
      { item_name: 'Bill Amounts', url: '/bill_amounts' },
      { item_name: 'Profile', url: "/players/#{current_user.id}" }
    ]
  end

  def admin_navbar_menu_items
    [
      { item_name: 'Bills', url: '/bills' },
      { item_name: 'Games', url: '/games' },
      { item_name: 'Players', url: '/players' },
      {
        item_name: "Pending Activations(#{Player.inactive_players.count})",
        url: '/activations/index'
      }
    ]
  end

  def send_chain(obj, chained_method_names)
    chained_method_names.split('.').inject(obj) do |object, method|
      object.send(method)
    end
  end
end
