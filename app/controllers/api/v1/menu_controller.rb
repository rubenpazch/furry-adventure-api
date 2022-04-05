class Api::V1::MenuController < ApplicationController
  before_action :check_login, only: %i[index]

  def menusubmenu
    @menu = Profiles::Menu.where(account_id: current_user.account_id)
    render json: @menu.to_json(
             :only => [:id, :title, :link_to, :hasSubMenu, :isRoot, :account_id],
             :include => {
               :sub_menus => { only: [:title, :link_to, :hasSubMenu, :menus_id] },
             },
           ),
           status: :ok
  end
end
