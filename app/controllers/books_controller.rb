class BooksController < ApplicationController
    before_action :authenticate_request!, only:[:create,
                                                :update,
                                                :destroy]
    before_action :get_library,:get_author, :get_category, only:[:create]
    def index
        books = Book.find_by(library_id:params[:library_id])
        if books.present?
            json_response({status:'success',message:'Books retrieved successfully',books:books})
        else
            json_response({status:'failed',message:'No Books found'},:not_found)
        end
    end

    def create
        book = Book.new
        book.title = book_params[:title]
        book.isbn = book_params[:isbn]
        book.copies = book_params[:copies]
        book.description = book_params[:desription]
        book.author = @author
        book.cover_type = book_params[:cover_type]
        book.category = @category
        book.library = @library

        if book.save!
            json_response({status:'success',
                           message:'Book added successfully',
                           book:book},:created)
        else
            json_response({status:'failed',message:'Book failed to add'})
        end
    end

    def show
        book = Book.find_by(library_id:params[:library_id],id:params[:id])
        if book.present?
            json_response({status:'success',message:'Book retrieved successfully',book:book})
        else
            json_response({status:'failed',message:'Book not found'},:not_found)
        end
    end

    def update
    end

    def destroy
    end

    private
    def get_library
        library = Library.find_by(id:params[:library_id],user_id:@current_user.id)
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