class Author < ApplicationRecord
    #An author can have multiple books
    has_many :books
end

#Add an author_id to books table
#rails g migration add_author_to_books author:references