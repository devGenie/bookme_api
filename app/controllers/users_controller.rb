class UsersController < ApplicationController
    before_action :get_user, only: [:show, :update, :destroy]
    before_action :authenticate_request!, only:[:index, :logout, :show, :update, :destroy]
    def index
        json_response({profile:@current_user})
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
        user = User.find_by(email: params[:email].to_s.downcase)

        if user && user.authenticate(params[:password])
            macaddress = Mac.addr
            auth_token = JsonWebToken.sign({user: user.id,macaddress: macaddress, iat: Time.now.to_i}, key: ENV['hash_key'])
            json_response({status:'successful',
                           message:'User logged in successfully',
                           token:auth_token},:ok)
        else
            json_response({status:'failed',message:'User registration failed'},:unauthorized)
        end
    end

    def logout
        if @current_user
            token = request.headers['Authorization']
            BlacklistedToken.create(token: token,user_id: @current_user.id)
            json_response({status:'success',message:'User logged out successfuly'})
        end
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