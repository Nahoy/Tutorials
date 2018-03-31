module Api
	class BooksController < ApplicationController
		def index
			if rating = params[:rating] #Test and assign at the same time
				books = Book.where(rating: rating)
			else
				books = Book.all
			end
			render json: books, status: 200
		end

		def create
			book = Book.new(book_params)
			if book.save
				render json: book, status: 201, location: api_books_url(book)
			else
				render json: book.errors, status: 422
			end
		end

		def destroy
			book = Book.find(params[:id])
			book.destroy
			render nothing: true, status: 204
		end

		def book_params
			params.require(:book).permit(:title, :rating, :author, :genre_id, :review, :amazon_id)
		end
	end
end