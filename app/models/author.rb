class Author < ApplicationRecord
    validates :name, presence: true
    validates :name, uniqueness: {case_sensitive: true}
    validates :phone_number, length: { is: 10 }

    def create
        author = Author.create!(author_params)
        render json: author, status: :created
    rescue ActiveRecord::RecordInvalid => invalid 
        render json:{error: invalid.record.errors}, status: :unprocessable_entity
    end

    private

    def author_params
        params.permit(:name, :phone_number)
    end

end
