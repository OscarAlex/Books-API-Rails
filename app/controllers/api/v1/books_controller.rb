module Api
  module V1
    class BooksController < ApplicationController
      #Created with rails g controller...  
      def index
        render json: Book.all
      end

      #Create book
      def create
        #Instead of Book.create, Book.new, and assigned to a variable.
        #This is for errors management, it is asigned to a variable instead
        #of being saved in the database directly.
        #params[:----] = the values from the JSON
        book= Book.new(title: params[:title], author: params[:author])

        #Check if model is valid
        #If the book is created succesfully, return created status
        if book.save
          render json: book, status: :created
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

      def book_params
        params.require(:book).permit(:title, :author)
      end
    end
  end
end
