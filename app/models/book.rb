class Book < ApplicationRecord
    #Validations
    validates :author, presence: true, length: {minimum: 3}
    validates :title, presence: true, length: {minimum: 3}
end
