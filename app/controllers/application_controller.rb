require 'json_web_token'
require 'macaddr'
class ApplicationController < ActionController::API
    include Response

    protected
    def authenticate_request!
    end

    def invalidate_authentication
    end

    private 
    def payload
    end

    def load_current_user!
    end

end
