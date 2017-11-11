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

    describe 'POST /users' do
        let(:valid_fields) { { first_name:"Onen", 
                               last_name:"Julius", 
                               email:"jonen54@gmail.com",
                               password:"256thjuly",
                               repeat_password:"256thjuly"} }

        context('when the request is valid') do
            before{ post '/users', params:valid_fields }

            it 'creates a user' do
                expect(json['first_name']).to eq("Onen")
            end

            it 'returns status 201' do
                expect(response).to have_http_status(201)
            end
        end
    end
end