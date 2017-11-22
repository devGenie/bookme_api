class AuthorsController < ApplicationController
    before_action :authenticate_request!, only:[:index,
                                                :show,
                                                :create, 
                                                :update,
                                                :destroy]
    def index
        authors = Author.where(user_id:@current_user.id)
        if authors.present?
            json_response({status:'success',
                        message:'Authors retrieved successfully',
                        authors:authors})
        else
            json_response({status:'failed',message:'Authors not found'},:not_found)
        end
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
        authors = Author.find_by(id:params[:id],user_id:@current_user.id)
        if authors.present?
            json_response({status:'success',
                        message:'Authors retrieved successfully',
                        authors:authors})
        else
            json_response({status:'failed',message:'Authors not found'},:not_found)
        end
    end

    def update
        author = Author.find_by(id:params[:id],user_id:@current_user.id)
        if author.present?
            if author.update_attributes(author_params)
                json_response({status:'success',message:'Author updated successfully',author:author})
            else
                json_response({status:'failed',message:'Author failed to update'})
            end
        else
            json_response({status:'failed',message:'Author not found'},:not_found)
        end
    end

    def destroy
        author = Author.find_by(id:params[:id],user_id:@current_user.id)
        if author.present?
            if author.destroy
                json_response({status:'success',message:'Author deleted successfully',author:author})
            else
                json_response({status:'failed',message:'Author failed to delete'})
            end
        else
            json_response({status:'failed',message:'Author not found'},:not_found)
        end
    end

    private
    def author_params
        params.permit(:name)
    end
end