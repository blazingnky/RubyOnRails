class CtrlController < ApplicationController
	def para
		render text: 'id 매개 변수: ' + params[:id]
	end

	def para_array
		render text: 'category 매개 변수: ' + params[:category].inspect
	end

	def req_head
		render text: request.headers['User-Agent']
	end

	def req_head2
		@headers = request.headers
	end

	def upload_process
		# 업로드 파일 추출
		file = params[:upfile]

		# 파일 이름 추출
		name = file.original_filename

		#사용 가능한 확장자 정의
		perms = ['.jpg', '.jpeg', '.gif', '.png']

		# 배열 {{perms}}를 기반으로 업로드된 파일의 확장자 확인
		if !perms.include?(File.extname(name).downcase)
			result = '이미지 파일만 업로드해주세요!!'
		# 업로드 파일의 크기가 1MB를 넘을 때
		elsif file.size > 1.megabyte
			result = '1MB 이하의 파일만 업로드해주세요!!'
		else
			# /public/docs 폴더에 파일을 저장
			File.open("public/docs/#{name}", 'wb') { |f| f.write(file.read) }
			result = "#{name}를 업로드했습니다."
		end

		# 성공 또는 오류 글자를 저장
		render text: result
	end


	# 업로드 입력 양식을 출력하기 위한 updb 액션
	# "~/ctrl/updb/108"처럼 경로로 호출
	def updb
		@author = Author.find(params[:id])
	end

	# [업로드] 버튼을 누르면 업로드와 관련된 처리를 수행
	def updb_process
		@author = Author.find(params[:id])

		# 업로드 파일을 데이터베이스에 저장(실패하면 첫 번째 오류를 출력)
		if @author.update(params.require(:author).permit(:data))
			render text: '저장에 성공했습니다.'
		else
			render text: @author.errors.full_messages[0]
		end
	end
end
