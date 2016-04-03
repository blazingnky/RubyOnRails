class HelloController < ApplicationController
	def view
		@msg = "Hello World!!! Come on!!"
	end
	
	def list
		@books = Book.all
	end
end
