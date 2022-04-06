class Api::V1::MenuController < ApplicationController
  before_action :check_login, only: %i[index]

  def menusubmenu
    @menu = current_user.is_super_admin? ? Profiles::Menu.all : current_user.role.profile.menus
    render json: @menu.to_json(
             :only => [:id, :title, :link_to, :hasSubMenu, :isRoot, :account_id],
             :include => {
               :sub_menus => { only: [:title, :link_to, :hasSubMenu, :menus_id] },
             },
           ),
           status: :ok
  end
end
