class UsersController < ApplicationController
    before_action :get_user, only: [:show, :update, :destroy]
    def index
        @users=User.all
        json_response(@users)
    end

    def show
        json_response(@user)
    end

    def get_user
        @user = User.find(params[:id])
    end
end