class UsersController < ApplicationController
  before_action :set_user, only: %i[ show liked feed followers following discover ]
  before_action :limit_discover_feed_to_current_user, only: %i[ feed discover ]

  private

    def set_user
      if params[:username]
        @user = User.find_by!(username: params.fetch(:username))
      else
        @user = current_user
      end
    end

    def limit_discover_feed_to_current_user
      if @user != current_user 
        redirect_back(fallback_location: root_path, alert: "Nice Try, Sucker")
      end 
    end
end