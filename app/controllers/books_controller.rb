class BooksController < ApplicationController
  #Created with rails g controller...
  def index
    render json: Book.all
  end

  def create
    #Instead of Book.create, Book.new, and asigned to a variable.
    #This for errors management, it is asigned to a variable instead
    #of being saved in the database directly.
    #params[:----] = the values from the JSON
    book= Book.new(title: params[:title], author: params[:author])

    #Check if model is valid
    if book.save
      render json: book, status: :created
    else
      render json: book.errors, status: :unprocessable_entity
    end
  end

  #This allows only these parameters to be posted
  #Security reasons
  private
  def book_params
    params.require(:book).permit(:title, :author)
  end
end
