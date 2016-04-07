class AjaxController < ApplicationController
	def upanel
		@time = Time.now.to_s
	end

	def search
		# 선택 상자에 표시되는 출판사 이름 응답
		@books = Book.select(:publish).distinct
	end

	def result
		sleep(2) #2초 동안 처리를 정지
		# 선택 상자에 지정된 출판사에서 books 테이블을 검색
		@books = Book.where(publish: params[:publish])
	end
end
