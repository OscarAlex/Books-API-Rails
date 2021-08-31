class Book < ApplicationRecord
    #Validations
    
    #validates :author, presence: true, length: {minimum: 3}
    validates :title, presence: true, length: {minimum: 3}

    #A book can have only one author
    belongs_to :author
end


#We want to add parameters for the author, but instead of put them right here,
#we are going to create an author model and associate it whith the book model
#rails g model Author first_name:string last_name:string age:integer
#rails db:migrate