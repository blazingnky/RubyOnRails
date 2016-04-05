class LoginController < ApplicationController
	# [로그인]버튼을 클릭하면 실행되는 액션
	def auth
		#입력 값에 따라 인증 처리
		usr = User.authenticate(params[:username], params[:password])
		# 리턴 값(변수 usr)의 유무로 인증 성공 여부를 판정
		if usr then
			# 성공한 경우에는 세션에 id를 설정하고 원래 요구 페이지로 리다이렉트
			reset_session
			session[:usr] = usr.id
			redirect_to params[:referer]
		else
			# 실패한 경우에는 flash[:referer]를 다시 설정하고 로그인 페이지를 출력
			flash.now[:referer] = params[:referer]
			@error = '사용자 이름과 비밀번호가 다릅니다.'
			render 'index'
		end
	end
end
