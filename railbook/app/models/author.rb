class Author < ActiveRecord::Base
  belongs_to :user
  has_and_belongs_to_many :books

  validate :file_invalid?
  #data 속성(UploadedFile 객체) 정의
  def data=(data)
  	self.ctype = data.content_type	# ctype 속성에 콘텐츠 타입을 설정
  	self.photo = data.read	# photo 속성에 파일 자체를 설정  	
  end

  # 업로드 파일의 유효성을 검사하는 file_invalid? 메서드 정의
  private
  def file_invalid?
  	ps = ['image/jpeg', 'image/gif', 'image/png']
  	errors.add(:photo, '은 이미지 파일이 아닙니다.') if !ps.include?(self.ctype)
  	errors.add(:photo, '의 크기가 1MB를 넘습니다.') if self.photo.length > 1.megabyte
  end
end