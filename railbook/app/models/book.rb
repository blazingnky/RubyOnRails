class Book < ActiveRecord::Base
	has_many :reviews
	has_and_belongs_to_many :authors
	has_many :users, through: :reviews
	has_many :memos, as: :memoable

	validates :isbn,
	presence: { message: '필수입니다.'},
	uniqueness: { allow_blank: true, message: '%{value}는 유일한 값이어야 합니다.'},
	length: { is: 17, allow_blank: true, message: '%{value}는 %{count}자리어야 합니다.' },
	format: { with: /|A[0-9]{3}-[0-9]{1}-[0-9]{3,5}-[0-9]{4}-[0-9X]{1}|z/, allow_blank: true, message: '%[value]는 정확한 형식이 아닙니다.' },
	isbn: { allow_old: true }	

	validates :title,
	presence: true,
	uniqueness: { scope: :publish },
	length: { minimum: 1, maximum: 100 }
	

	validates :price,
	numericality: { only_integer: true, less_than: 100000 }
	

	validates :publish,
	inclusion:{ in: ['제이펍', '한빛미디어', '지앤선', '인사이트', '길벗'] }

end
