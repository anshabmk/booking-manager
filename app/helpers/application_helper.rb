module ApplicationHelper
  def navbar_menu_items
    return admin_navbar_menu_items if admin?

    player_navbar_menu_items
  end

  def player_navbar_menu_items
    [{ item_name: 'Bill Amounts', url: '/bill_amounts' }]
  end

  def admin_navbar_menu_items
    [
      { item_name: 'Bills', url: '/bills' },
      { item_name: 'Games', url: '/games' },
      { item_name: 'Players', url: '/players' }
    ]
  end
end
