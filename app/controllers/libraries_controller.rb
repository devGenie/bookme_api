class LibrariesController < ApplicationController
    before_action :authenticate_request!, only:[:create, 
                                                :update,
                                                :destroy]
    def index
        current_page = (params[:page]).to_i
        count = (params[:count]).to_i

        libs = Library.all.paginate(page: current_page, per_page: count)
        base_url = request.original_url.split('?').first
        pagination = {
            "total_pages":(Library.count/count).ceil,
            "current_page":request.original_url,
            "next_page_url": "#{base_url}?page=#{current_page+1}&count=#{count}", 
            "prev_page_url": "#{base_url}?page=#{current_page-1}&count=#{count}"
        }
        json_response({status:'success',message:'Libraries retrieved successfully',libraries:libs,pagination:pagination})

    rescue ActiveRecord::RecordNotFound => e
        json_response({status:'failed',message:'Libraries not found'},:not_found)
    end

    def show
        library = Library.find(params[:id])
        json_response({status:'success',message:'Library retrieved successfully',library:library})

    rescue ActiveRecord::RecordNotFound => e
        json_response({status:'failed',message:'Library matching specified id does not exist'},:not_found)
    end
    
    def create
        library = Library.new
        library.user = @current_user
        library.name = library_params[:name]
        library.contacts = library_params[:contacts]
        library.location = library_params[:location]
        
        if library.save!
            data = {id:library.id,name:library.name,location:library.location,
                    contacts:library.contacts}
            json_response({status:'success',message:'Library created successfully',data:data},:created)
        end
    end

    def update
        library = Library.find(params[:id])
        if library.update_attributes(library_params)
            json_response({status:'success',message:'Library updated successfully',library:library})
        else
            json_response({status:'failed',message:'Library not updated'})
        end

    rescue ActiveRecord::RecordNotFound => e
        json_response({status:'failed',message:'Library matching specified id does not exist'},:not_found)
    end

    def destroy
    end

    private
    def library_params
        params.permit( :name, :location, :contacts, :image_url)
    end

    
end
