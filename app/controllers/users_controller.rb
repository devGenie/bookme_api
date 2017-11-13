class UsersController < ApplicationController
    before_action :get_user, only: [:show, :update, :destroy]
    def index
        @users=User.select('id',
                           'first_name',
                           'last_name',
                           'email',
                           'date_added',
                           'updated_at')
        json_response(@users)
    end

    def show
        json_response(@user)
    end

    def create
        if user_params['password'] == user_params['repeat_password']
            new_params=user_params.except(:repeat_password)
            current_time = Time.now()
            new_params[:date_added] = current_time
            new_params[:updated_at] = current_time
            @user = User.create!(new_params)
            @user = @user.attributes.except("password_digest")
            json_response(@user, :created)
        end
    end

    def login
    end

    private

    def user_params
        params.permit(:first_name, 
                      :last_name,
                      :email,
                      :password,
                      :repeat_password)
    end

    def get_user
        @user = User.find(params[:id])
    end
end