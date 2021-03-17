class Note < ApplicationRecord
    belongs_to :user
    attachment :image  
end
