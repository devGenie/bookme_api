class AuthorsController < ApplicationController
    before_action :authenticate_request!, only:[:index,
                                                :show,
                                                :create, 
                                                :update,
                                                :destroy]
    def index
        authors = Author.where(user_id:@current_user.id)
        json_response({status:'success',
                       message:'Authors retrieved successfully',
                       authors:authors})

    rescue ActiveRecord::RecordNotFound => e
        json_response({status:'failed',message:'Authors not found'},:not_found)
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
        authors = Author.find(params[:id])
        json_response({status:'success',
                       message:'Authors retrieved successfully',
                       authors:authors})

    rescue ActiveRecord::RecordNotFound => e
        json_response({status:'failed',message:'Authors not found'},:not_found)
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