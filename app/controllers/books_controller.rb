class BooksController < ApplicationController
    def index
        json_response({lib_id:params[:library_id]})
    end

    def create
    end

    def show
    end

    def update
    end

    def destroy
    end

    private
    def get_library
        @library_id = params[:library_id]
    end

    def book_params
        params.permit(:title, 
                      :isbn, 
                      :copies,
                      :desription,
                      :author_id,  
                      :cover_type,
                      :category
                      )
    end
end