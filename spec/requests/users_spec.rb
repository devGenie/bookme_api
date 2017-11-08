require "rails_helper"

RSpec.describe "Users API", type: :request do
    let!(:users) { FactoryBot.create_list(:random_user,10) }
    let(:user_id) { users.first.id}
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

    describe 'GET /users/:id' do
        before { get "/users/#{user_id}"}

        context 'when the user exists' do
            it 'returns the user' do
                expect(json).not_to be_empty
                expect(json['id']).to eq(user_id)
            end

            it 'returns status code 200' do
                expect(response).to have_http_status(200)
            end
        end
    end
end