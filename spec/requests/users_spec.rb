require "rails_helper"

RSpec.describe "Users API", type: :request do
    let!(:users) { FactoryBot.create_list(:random_user,10) }
    describe 'GET /users' do
        before { get '/users' }
        
        it 'returns users' do
            expect(json).not_to be_empty
            expect(json.size).to eq(10)
        end

        it 'returns status code 200' do
            expect(response).to have_http_status(200)
        end
    end
end