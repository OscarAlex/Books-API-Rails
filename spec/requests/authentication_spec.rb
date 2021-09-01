#response_body from rails_helper from request_helper
require 'rails_helper'

#Unit tests
describe 'Authentication', type: :request do
    describe 'POST /authenticate' do
        it 'authenticates the client' do
            post '/api/v1/authenticate', params: {username: 'User1', password: 'password'}

            expect(response).to have_http_status(:created)
            #Check if the body content is
            expect(response_body).to eq(
                {
                    "token" => '123'
                }
            )
        end

        #Tests if a parameter is missing
        it 'return error when username is missing' do
            post '/api/v1/authenticate', params: {password: 'password'}

            expect(response).to have_http_status(:unprocessable_entity)
            expect(response_body).to eq(
                {
                    "error" => "param is missing or the value is empty: username\nDid you mean?  password\n               controller\n               action"
                }
            )
        end

        it 'return error when password is missing' do
            post '/api/v1/authenticate', params: {username: 'User1'}

            expect(response).to have_http_status(:unprocessable_entity)
            expect(response_body).to eq(
                {
                    "error" => "param is missing or the value is empty: password\nDid you mean?  action\n               username\n               controller"
                }
            )
        end
    end
end