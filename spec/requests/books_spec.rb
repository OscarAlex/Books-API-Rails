#response_body from rails_helper from request_helper
require 'rails_helper'

#Unit tests
describe 'Books API', type: :request do
    #Create authors
    let(:author1) {FactoryBot.create(:author, first_name:'F1', last_name:'L1', age:12)}
    let(:author2) {FactoryBot.create(:author, first_name:'F2', last_name:'L2', age:13)}

    describe 'GET /books' do
        before do
            #Data for the test database
            FactoryBot.create(:book, title:'TBook1', author:author1)
            FactoryBot.create(:book, title:'TBook2', author:author2)
    
        end
        
        it 'returns all books' do
            get '/api/v1/books'
    
            #Check the response
            expect(response).to have_http_status(:success)
            #Check the number of books
            expect(response_body.size).to eq(2)
            #Check if the body content is
            expect(response_body).to eq(
                [
                    {
                        "id" => 1,
                        "title" => 'TBook1',
                        "author_name" => 'F1 L1',
                        "author_age" => 12
                    },
                    {
                        "id" => 2,
                        "title" => 'TBook2',
                        "author_name" => 'F2 L2',
                        "author_age" => 13
                    }
                ]
            )
        end

        #Pagination= It is used to return a subset of books instead of all
        #of them. In case of a larger database, it helps a lot.
        it 'returns a subset of books based on limit' do
            get '/api/v1/books', params: {limit:1}

            #Check the response
            expect(response).to have_http_status(:success)
            #Check the number of books
            expect(response_body.size).to eq(1)
            expect(response_body).to eq(
                [
                    {
                        "id" => 1,
                        "title" => 'TBook1',
                        "author_name" => 'F1 L1',
                        "author_age" => 12
                    }
                ]
            )
        end

        it 'returns a subset of books based on limit and offset' do
            get '/api/v1/books', params: {limit:1, offset:1}

            #Check the response
            expect(response).to have_http_status(:success)
            #Check the number of books
            expect(response_body.size).to eq(1)
            #The response should be the second book because the data was
            #splitted in a 1 object chunck (limit) and we get the position 1 (offset)
            expect(response_body).to eq(
                [
                    {
                        "id" => 2,
                        "title" => 'TBook2',
                        "author_name" => 'F2 L2',
                        "author_age" => 13
                    }
                ]
            )
        end
    end

    describe 'POST /books' do
        it 'creates a new book' do
            expect{
                #Post test book
                #post '/api/v1/books', params: {title:'C from test', author:'Rsp3c'}
                
                #New
                puts(Author.all)
                post '/api/v1/books', params: {
                    book: {title: 'The martian'},
                    author: {first_name: 'Andy', last_name: 'Weir', age: 48}
                }
            #Check if the test database change from 0 to 1
            }.to change{ Book.count }.from(0).to(1)
            
            #Check the number of authors
            expect(Author.count).to eq(1)
            expect(response).to have_http_status(:created)
            #Check the response of the JSON body
            expect(response_body).to eq(
                {
                    "id" => 1,
                    "title" => 'The martian',
                    "author_name" => 'Andy Weir',
                    "author_age" => 48
                }
            )
        end
    end

    describe 'DELETE /books/:id' do
        #Add test data
        let!(:book) {FactoryBot.create(:book, title:'TBook1', author:author1)}

        it 'deletes a book' do
            expect{
                delete "/api/v1/books/#{book.id}"
            }.to change{ Book.count }.from(1).to(0)
            
            #Check no content
            expect(response).to have_http_status(:no_content)
        end
    end
end