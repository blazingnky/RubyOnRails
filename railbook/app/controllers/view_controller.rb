class ViewController < ApplicationController
	def form_tag
		@book = Book.new
	end

	def form_for
		@book = Book.new
	end

	def field
		@book = Book.new
	end

	def html5
		@book = Book.new
	end

	def select
		@book = Book.new(publish: '제이펍')
	end

	def col_select
		@book = Book.new(publish: '제이펍')
		@books = Book.select(:publish).distinct
	end

	def group_select
		@review = Review.new
		@authors = Author.all
	end

	def select_tag
		@book = Book.new(publish: '제이펍')
	end

	def col_select2
		@book = Book.new(publish: '제이펍')
		@books = Book.select(:publish).distinct
	end

	def multi
		render layout: 'layout'
	end

	def nest
		@msg = "아이유 분홍술ㅋㅋ"
		render layout: 'child'
	end

	def partial_basic
		@book = Book.find(3)
	end

	def partial_col
		@books = Book.all
	end

	def partial_spacer
		@books = Book.all
	end
end