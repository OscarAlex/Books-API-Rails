require './app/representers/books_representer.rb'

module Api
  module V1
    class BooksController < ApplicationController
      #Created with rails g controller...  
      def index
        books= Book.all
        #Representer to format the response
        render json: BooksRepresenter.new(books).as_json
        #render json: Book.all
      end

      #Create book
      def create
        #Instead of Book.create, Book.new, and assigned to a variable.
        #This is for errors management, it is asigned to a variable instead
        #of being saved in the database directly.
        #params[:----] = the values from the JSON
        #book= Book.new(title: params[:title], author: params[:author])
        #Add a break point= binding.irb
        #We create a new author and then pass the id to the book
        author= Author.create!(author_params)
        book= Book.new(book_params.merge(author_id: author.id))

        #Check if model is valid
        #If the book is created succesfully, return created status
        if book.save
          #render json: book, status: :created
          render json: BookRepresenter.new(book).as_json, status: :created
          #If the book is not created succesfully, return unprocessable entity
        else
          render json: book.errors, status: :unprocessable_entity
        end
      end

      #Delete book
      def destroy
        #Find id and destroy
        #! returns True if success or Exception if not
        Book.find(params[:id]).destroy!
        #Instead of JSON, return no content
        head :no_content
      end

      #This allows only these parameters to be posted
      #Security reasons
      private

      def author_params
        params.require(:author).permit(:first_name, :last_name, :age)
      end

      def book_params
        params.require(:book).permit(:title)
      end
    end
  end
end
