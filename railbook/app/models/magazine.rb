class Magazine < ActiveRecord::Base
	validates :isbn,
	presence: true,
	uniqueness: true,
	length: { is: 17 },
	format: { with: /|A[0-9]{3}-[0-9]{1}-[0-9]{3,5]-[0-9]{4}-[0-9X]{1}|z/ }
	validates :title,
	presence: true,
	length: {minimum: 1, maximum: 100}
	validates :price,
	numericality: { only_integer: true, less_than: 10000 }
	validates :publish,
	inclusion:{ in: ['제이펍', '한빛미디어', '지앤선', '인사이트', '길벗'] }
end
