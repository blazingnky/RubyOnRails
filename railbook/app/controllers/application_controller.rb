class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  # RecordNotFound 예외는 id_invalid 메서드에서 처리합니다.
	rescue_from ActiveRecord::RecordNotFound, with: :id_invalid

	private
	def id_invalid(e)
		#상태 코드 404(Not Found)로 뷰를 출력합니다.
		render 'shared/record_not_found', status: 404	
	end
end
