require 'json_web_token'
require 'macaddr'
class ApplicationController < ActionController::API
    include Response

    protected
    def authenticate_request!
        if !payload
            invalid_authentication
        else
            auth_header = request.headers['Authorization']
            if !load_current_user! || Mac.addr != payload[:macaddress] || BlacklistedToken.exists?(token:auth_header)
                invalid_authentication
            else
                @current_user
            end
        end
    end

    def invalid_authentication
        json_response({status:'failed',message:'Your request is invalid or expired'},:unauthorized)
    end

    private 
    def payload
        token = request.headers['Authorization'] 
        JsonWebToken.verify(token, key: ENV['hash_key'])[:ok]
    rescue
        nil                                                                                                                                                                                                                                                                                                                                            
    end

    def load_current_user!
        @current_user = User.where(id:payload[:user]).select(:id, :first_name, :last_name, :email)[0]
    end
end
