class BooksController < ApplicationController
    before_action :authenticate_request!, only:[:create,
                                                :update,
                                                :destroy,
                                                :verify_ownership]
    before_action :get_library,:get_author, :get_category, only:[:create, :verify_ownership]
    before_action :get_subscriber,:get_book, only:[:borrow]
    before_action :verify_ownership, only:[:borrow, :return]

    def index
        books = Book.limit(10).includes(:book_collections)
                .where(:books=>{library_id:params[:library_id]})
        data = []
        books.each do |book|
            collection = {details:book,batch:book.book_collections}
            data.push(collection)
        end

        if books.present?
            json_response({status:'success',message:'Books retrieved successfully',books:data})
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
            book.copies.times do |i|
                book_collection = BookCollection.new
                book_collection.book = book
                book_collection.save!
            end
            json_response({status:'success',
                           message:'Book added successfully',
                           book:book},:created)
        else
            json_response({status:'failed',message:'Book failed to add'})
        end
    end

    def show
        book = Book.includes(:book).find_by(library_id:params[:library_id],id:params[:id])
        if book.present?
            json_response({status:'success',message:'Book retrieved successfully',book:book})
        else
            json_response({status:'failed',message:'Book not found'},:not_found)
        end
    end

    def update
        book = Book.find_by(library_id:params[:library_id],id:params[:id])
        if book.present?
            if book.update_attributes(book_params)
                json_response({status:'success',message:'Book edited successfully',book:book})
            else
                json_response({status:'failed',message:'Book not edited'})
            end

        else
            json_response({status:'failed',message:'Book not found'},:not_found)
        end
    end

    def destroy
        book = Book.find_by(library_id:params[:library_id],id:params[:id])
        if book.present?
            if book.destroy
                json_response({status:'success',message:'Book deleted successfully'})
            else
                json_response({status:'failed',message:'Book not deleted'})
            end
        else
            json_response({status:'failed',message:'Book not found'},:not_found)
        end
    end

    def borrow
        borrowed = BorrowedBook.where(["book_collection_id = ?", params[:collection_id]]).last

        if borrowed.present? && borrowed.return_status == false
            json_response({status:'failed',message:'Book already borrowed'},:conflict)
        else
            newly_borrowed = BorrowedBook.new
            newly_borrowed.book_collection = @book
            newly_borrowed.subscription = @subscriber
            newly_borrowed.date_borrowed = Time.zone.now
            newly_borrowed.date_due = (Date.today+3)
            
            if newly_borrowed.save!
                json_response({status:'success',message:'Book borrowed successfully',details:newly_borrowed},:created)
            else
                json_response({status:'failed',message:'Book not borrowed'})
            end
        end
    end

    def return
        borrowed = BorrowedBook.find_by(id:params[:borrowed_id])

        if borrowed.present?
            if borrowed.return_status == true
                json_response({status:'failed',message:'Book already returned'},:conflict)
            else
                return_details = {return_status:true,
                              date_returned:Time.zone.now,
                              comments:params[:comments]
                            }

                if borrowed.update(return_details)
                    json_response({status:'success',message:'Book returned successfully'})
                else
                    json_response({status:'failed',message:'Book not returned successfully'})
                end
            end
        else
            json_response({status:'failed',message:'Book not been borrowed'},:not_found)
        end
    end

    private
    def verify_ownership
        authenticate_request!
        get_library
        if @library.user_id != @current_user.id
            json_response({status:'failed',message:'User does not have access to this library'},:not_authorized)
        end
    end

    def get_library
        puts 'called'
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

    def get_subscriber
        @subscriber = Subscription.find(params[:subscription_id])

    rescue ActiveRecord::RecordNotFound => e
        json_response({status:'false',message:'User not subscribed to library'},:not_authorized)
    end

    def get_book
        @book = BookCollection.find(params[:collection_id])
    
    rescue ActiveRecord::RecordNotFound => e
        json_response({status:'failed',message:'Book not found'},:not_found)
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