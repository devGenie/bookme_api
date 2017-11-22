class BooksController < ApplicationController
    before_action :authenticate_request!, only:[:create,
                                                :update,
                                                :destroy]
    before_action :get_category,:get_author, :get_category, only:[:create]
    def index
        books = Book.find_by(library_id:params[:library_id])
        if books.present?
            json_response({status:'success',message:'Books retrieved successfully',books:books})
        else
            json_response({status:'failed',message:'No Books found'},:not_found)
        end
    end

    def create
    end

    def show
        json_response({lib:@author.id})
    end

    def update
    end

    def destroy
    end

    private
    def get_library
        library = Library.find_by(id:book_params[:library_id],user_id:@current_user.id)
        if library.present?
            @library = library
        else
            json_response({status:'failed',message:'Library does not exist'},:not_found)
        end
    end

    def get_author
        author = Author.find_by(id:book_params[:author_id],user_id:@current_user.id)
        if author.present?
            @author = author
        else
            json_response({status:'failed',message:'Author does not exist'},:not_found)
        end
    end

    def get_category
        category = Category.find_by(id:book_params[:category_id],user_id:@current_user.id)
        if category.present?
            @category = category
        else
            json_response({status:'failed',message:'Category does not exist'},:not_found)
        end
    end

    def book_params
        params.permit(:title, 
                      :isbn, 
                      :copies,
                      :desription,
                      :author_id,  
                      :cover_type,
                      :category_id,
                      :library_id,
                      :author_id
                      )
    end
end