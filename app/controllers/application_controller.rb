require 'json_web_token'
require 'macaddr'
class ApplicationController < ActionController::API
    include Response

    protected
    def authenticate_request!
        if !payload
            invalid_authentication
        else
            load_current_user!
            invalid_authentication unless @current_user
        end
    end

    def invalid_authentication
        json_response({status:'failed',message:'Your request is invalid or expired'},:unauthorized)
    end

    private 
    def payload
        auth_header = request.headers['Authorization']    
        token = auth_header
        JsonWebToken.verify(token, key: ENV['hash_key'])

    rescue
        nil                                                                                                                                                                                                                                                                                                                                            
    end

    def load_current_user!
        @current_user = User.find_by_id(3)
    end
end
