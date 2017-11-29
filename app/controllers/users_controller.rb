class UsersController < ApplicationController
    before_action :get_user, only: [:show, :update, :destroy]
    before_action :authenticate_request!, only:[:index, :logout, :show, :update, :destroy]

    def_param_group :user do
        param :first_name, String, "John"
        param :last_name, String, "Doe"
        param :email, String, "johndoor@mail.com"
        param :password, String, "abcdef"
        param :repeat_password, String, "abcdef"
    end

    api :GET, "/users", "Show logged in user's profile"
    show true
    error :code => 401, :desc => "User has not been logged in or the request has expired", :meta => {:status => "failed", :message => "Your request is invalid or expired"}
    description "You can display the current user's profile with this endpoint."\
                 "The User has to be logged in to be able to display their data."
    example "{
                'status': 'success',
                'messgae': 'User retrieved successfully',
                'profile': {
                            'id': 1,
                            'first_name': 'Onen',
                            'last_name': 'Julius',
                            'email': 'oj121@mail.com'
                            }
    }"
    
    def index
        json_response({status:'success',
                       messgae:'User retrieved successfully',
                       profile:@current_user})
    end

    api :GET, "/users/:id", "Show a user with the provided user ID"
    show true
    error :code => 401, :desc => "User is not authorized to access this profile",:meta => {:status => "failed", :message => "Your request is invalid or expired"}
    error :code => 404, :desc => "User with the provided ID does not exist", :meta => {:status=>'failed',:message => "User does not exist"}
    description "To display a user's profile, provide a user ID with the request. You can only view a user if you are logged in"
     example "{
                'status': 'success',
                'messgae': 'User retrieved successfully',
                'profile': {
                            'id': 1,
                            'first_name': 'Onen',
                            'last_name': 'Julius',
                            'email': 'oj121@mail.com'
                            }
    }"

    def show
        json_response(@user)
    end

    api :POST, "/users", "Add user into the system"
    description "Use this API endpoint to add users into the system"
    param_group :user
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

    api!
    def login
        user = User.find_by(email: params[:email].to_s.downcase)

        if user && user.authenticate(params[:password])
            macaddress = Mac.addr
            auth_token = JsonWebToken.sign({user: user.id,macaddress: macaddress, iat: Time.now.to_i}, key: ENV['hash_key'])
            json_response({status:'successful',
                           message:'User logged in successfully',
                           token:auth_token},:ok)
        else
            json_response({status:'failed',message:'User failed to login'},:unauthorized)
        end
    end

    api!
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