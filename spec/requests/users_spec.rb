require "rails_helper"

RSpec.describe "Users API", type: :request do
    let!(:users) { FactoryBot.create_list(:random_user,10) }
    describe 'GET /users' do
        before { get '/users' }
        
        it 'returns users' do
            expect(json).not_to be_empty
        end
    end
end