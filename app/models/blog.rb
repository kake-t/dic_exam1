class Blog < ApplicationRecord
    validates :title,:content, {presence: true, length: {maximum: 140}}
end
