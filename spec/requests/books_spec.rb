require 'rails_helper'

describe 'Books API', type: :request do
    describe 'GET /books' do
        before do
            #Data for the test database
            FactoryBot.create(:book, title:'TBook1', author:'Afrd G.')
            FactoryBot.create(:book, title:'TBook2', author:'AuthorBot')
    
        end
        
        it 'returns all books' do
            
            get '/api/v1/books'
    
            #Check the response
            expect(response).to have_http_status(:success)
            #Check the number of books
            expect(JSON.parse(response.body).size).to eq(2)
        end
    end

    describe 'POST /books' do
        it 'creates a new book' do
            expect{
                #Post test book
                #Why {title:'C from test', author:'Rsp3c'}
                #instead of {book:{title:'C from test', author:'Rsp3c'}} ?
                post '/api/v1/books', params: {title:'C from test', author:'Rsp3c'}
            #Check if the test database change from 0 to 1
            }.to change{ Book.count }.from(0).to(1)
            

            expect(response).to have_http_status(:created)
        end
    end

    describe 'DELETE /books/:id' do
        #Add test data
        let!(:book) {FactoryBot.create(:book, title:'TBook1', author:'Afrd G.')}

        it 'deletes a book' do
            expect{
                delete "/api/v1/books/#{book.id}"
            }.to change{ Book.count }.from(1).to(0)
            
            #Check no content
            expect(response).to have_http_status(:no_content)
        end
    end
end