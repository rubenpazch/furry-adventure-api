# frozen_string_literal: true

module Api
  module V1
    class MenuController < ApplicationController
      before_action :check_login, only: %i[index]

      def menu_submenu
        @menu = current_user.is_super_admin? ? Profiles::Menu.all : current_user.role.profile.menus
        render json: Profiles::MenuSerializer.new(@menu),
               status: :ok
      end
    end
  end
end
