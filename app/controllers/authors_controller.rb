class AuthorsController < ApplicationController
    before_action :authenticate_request!, only:[:index,
                                                :show,
                                                :create, 
                                                :update,
                                                :destroy]
    def index
    end

    def create
        author = Author.new
        author.user = @current_user
        author.name = author_params[:name]
        if author.save!
            json_response({status:'success',
                           message:'Author created successfully',
                           author:author},:created)
        else
            json_response({status:'failed',
                           message:'Failed to add author'})
        end
    end

    def show
    end

    def update
    end

    def destroy
    end

    private
    def author_params
        params.permit(:name)
    end
end