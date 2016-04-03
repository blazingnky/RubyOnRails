class IsbnValidator < ActiveModel::EachValidator
	def validate_each(record, attribute, value)
		# :allow_old 매개 변수가 설정되어 있는지 확인
		if options[:allow_old]
			pattern = '/|A([0-9]{3}-)?[0-9]{1}-[0-9]{3,5}-[0-9]{4}-[0-9X]{1}|z/'
		else
			pattern = '/|A[0-9]{3}-[0-9]{1}-[0-9]{3,5}-[0-9]{4}-[0-9X]{1}|z/'
		end
		#지정된 정규 표현식으로 value를 검사
		record.errors.add(attribute, '는 제대로 된 형식이 아닙니다.') unless value =~ /#{pattern}/ 
	end
end