class CategoriesController < ApplicationController
    before_action :authenticate_request!, only:[:index,
                                               :show,
                                               :create,
                                               :update,
                                               :destroy]
    
    def index
        categories = Category.find_by(user_id:@current_user.id)
        if categories.present?
            json_response({status:'success',
                        message:'Categories retrieved successfully',
                        categories:categories})
        else
            json_response({status:'failed',message:'Categories not found, please add some'},:not_found)
        end
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
        category = Category.where(id:params[:id],user_id:@current_user.id)
        if category.present?
            json_response({status:'success',
                        message:'Category fetched successfully',
                        category:category})
        else
            json_response({status:'failed',message:'Category not found'},:not_found)
        end
    end

    def update
        category = Category.find_by(id:params[:id],user_id:@current_user.id)
        if category.present?
            if category.update_attributes(category_params)
                json_response({status:'success',message:'Category updated successfully',category:category})
            else
                json_response({status:'success',message:'Category was not updated'})
            end
        else
            json_response({status:'failed',message:'Category not found'},:not_found)
        end
    end

    def destroy
        category = Category.find_by(id:params[:id],user_id:@current_user.id)
        if category.present?
            if category.destroy
                json_response({status:'success',message:'Category deleted successfully'})
            else
                json_response({status:'failed',message:'Category failed  to delete'})
            end
        else
            json_response({status:'failed',message:'Category not found'},:not_found)
        end
    end

    private
    def category_params
        params.permit(:name)
    end
end