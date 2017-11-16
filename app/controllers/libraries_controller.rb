class LibrariesController < ApplicationController
    before_action :authenticate_request!, only:[:create, 
                                                :update,
                                                :destroy,
                                                :show]
    def index
    end

    def show
    end
    
    def create
        puts 'here'
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
    end

    def destroy
    end

    private
    def library_params
        params.permit( :name, :location, :contacts, :image_url)
    end

    
end
