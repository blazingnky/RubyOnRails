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
end
