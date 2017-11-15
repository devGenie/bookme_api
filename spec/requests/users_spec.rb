require "rails_helper"

RSpec.describe "Users API", type: :request do
    let!(:users) { FactoryBot.create_list(:random_user,10) }
    let(:user_id) { users.first.id}
    let(:valid_fields) { { first_name:"Onen", 
                           last_name:"Julius", 
                           email:"jonen54@gmail.com",
                           password:"256thjuly",
                           repeat_password:"256thjuly"} }
    let(:login_details){{
                           email:valid_fields[:email],
                           password:valid_fields[:params]}}
    
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

    describe 'POST /users/login' do
        before :each do
            @user = FactoryBot.create(:user)
        end

        context('user is able to login') do
            before{ post '/users/login', params:{email:@user.email,password:@user.password}}
            it 'user can login after registration' do
                expect(response).to have_http_status(200)
            end

            it 'after login, token should be returned' do
                expect(json).to have_key('token')
            end

            it 'After login, correct message should be returned' do
                expect(json['message']).to eq("User logged in successfully")
            end

            it 'After login, response body has all fields' do
                expect(json.keys).to contain_exactly('status','message','token')
            end
        end

        context('user is not able to login') do
            before{ post '/users/login', params:{email:'jonen54@mail.com',password:'none'}} 

            it 'returns status code 401' do
                expect(response).to have_http_status(401)
            end

            it 'returns an error message' do
                expect(json['message']).to eq('User failed to login')
            end

            it 'returns status failed' do
                expect(json['status']).to eq('failed')
            end

            it 'returns both a status and a message' do
                expect(json.keys).to contain_exactly('status','message')
            end
        end
    end
end