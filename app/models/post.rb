class Post < ApplicationRecord

    validates :title, presence: true
    validates :content, length: { minimum: 250 }
    validates :summary, length: { maximum: 250 }
    validates :category, inclusion: { in: %w(Fiction Non-Fiction) }
    validate :title_is_clickbait

    def create
        post = Post.create!(post_params)
        render json: post, status: :created
    rescue ActiveRecord::RecordInvalid => invalid 
        render json:{error: invalid.record.errors}, status: :unprocessable_entity
    end

    private

    def post_params
        params.permit(:title, :content, :summary, :category)
    end

    def title_is_clickbait 
        array = ["Won't Believe", "Secret", "Top", "Guess"]
        if array do |phrase| 
            title.match? phrase
            errors.add(:title, "error")
        end
    end

end
