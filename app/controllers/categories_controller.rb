class CategoriesController < ApplicationController
    before_action :authenticate_request!, only:[:index,
                                               :show,
                                               :create,
                                               :update,
                                               :destroy]
    
    def index
        categories = Category.where(user_id:@current_user.id)
        json_response({status:'success',
                       message:'Categories retrieved successfully',
                       categories:categories})

    rescue ActiveRecord::RecordNotFound => e
        json_response({status:'failed',message:'Categories not found, please add some'},:not_found)
    end

    def create
        category = Category.new
        category.name = category_params[:name]
        category.user = @current_user
        if category.save!
            json_response({status:'success',
                           message:'Category created successfully',
                           category:category},:created)
        else
            json_response({status:'failed',message:'Category failed to create'})
        end
    end

    def show
    end

    def update
    end

    def destroy
    end

    private
    def category_params
        params.permit(:name)
    end
end