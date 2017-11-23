class SubscriptionsController < ApplicationController
    before_action :authenticate_request!, :get_library, only:[:index,
                                                            :show,
                                                            :subscribe,
                                                            :unsubscribe]
    before_action :verify_ownership, only:[:index,:show]

    def index
        subscriptions = Subscription.joins(:user).joins(:library)
                        .select('subscriptions.id as id,users.first_name as first_name, users.last_name AS last_name')
                        .where(:libraries=>{:id=>@library.id})
        if subscriptions.present?
            json_response({status:'success',
                           message:'Subscriptions retrieved successfully',
                           subscriptions:subscriptions})
        else
            json_response({status:'failed',message:'No subscriptions found'})
        end
    end

    def show
        subscriber = Subscription.joins(:user).joins(:library)
                        .select('subscriptions.id as id,users.first_name as first_name, users.last_name AS last_name')
                        .where(:libraries=>{:id=>@library.id},:subscriptions=>{:id=>params[:id]})
        if subscriber.present?
            json_response({status:'success',
                           message:'Subscriptions retrieved successfully',
                           subscriber:subscriber})
        else
            json_response({status:'failed',message:'Subscriber not found'})
        end
    end

    def subscribe
        subscriber = Subscription.joins(:user)
                     .joins(:library).where(:libraries=>{:id=>@library.id},:users=>{:id=>@current_user.id})
        if subscriber.exists?
            json_response({status:'failed',message:'Already subscribed for this library'},:conflict)
        else
            subscription = Subscription.new
            subscription.library = @library
            subscription.user = @current_user
            subscription.date_subscribed = Time.zone.now

            if subscription.save!
                json_response({status:'success',
                            message:'User subscribed successfully',
                            subsciber:{
                                id:subscription.id,
                                first_name:@current_user.first_name,
                                last_name: @current_user.last_name,
                                date_subscribed:subscription
                            }},:created)
            else
                json_response({status:'failed',message:'Subscription failed'})
            end
        end
    end

    def unsubscribe
        subsciber = Subscription.joins(:user)
                    .joins(:library)
                    .where(:libraries=>{:id=>@library.id},:users=>{:id=>@current_user.id})
        if subsciber.present?
            if subsciber.destroy_all
                json_response({status:'success',message:'Subscription successfully canceled'})
            else
                json_response({status:'failed',message:'Subscription failed to cancel'})
            end
        else
            json_response({status:'failed',message:'Subscription not found'},:not_found)
        end
    end

    private
    def verify_ownership
        if @library.user_id != @current_user.id
            json_response({status:'failed',message:'Access denied'},:not_authorized)
        end
    end

    def get_library
        @library = Library.find(params[:library_id])
    rescue ActiveRecord::RecordNotFound => e
        json_response({status:'failed',message:'Library not found'},:not_found)
    end
end
