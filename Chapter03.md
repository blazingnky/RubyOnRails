# 스캐폴딩 기능을 사용한 Rails 개발 기초
-----------------------------------------

## 3.1 스캐폴딩 기능으로 애플리케이션 개발
---------------------------------------

###### *스캐폴딩 ( Scaffolding )*
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
* CRUD ( Create - Read - Update - Delete )
* 기본 기능을 미리 구현한 애플리케이션의 골격(기반)을 생성하기 위한 기능
* 애플리케이션 동작에 필요한 컨트롤러 클래스, 템플릿 파일, 모델 클래스, 마이그레이션 파일 모두를 자동 생성
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

###### *스캐폴딩 장점*
~~~~~~~~~~~~~~~~~~~~~~~~
* 일단 동작하는 애플리케이션을 만들고 싶을 때
* 데이터 유지 관리 등의 레이아웃을 열심히 만들 필요가 없는 페이지를 대량으로 만들어야 할 때
* Rails의 기본적인 CRUD 구현을 이해하고 싶을 때
~~~~~~~~~~~~~~~~~~~~~~

---------------------------
## 3.1.1 스캐폴딩 개발 순서
####1. 기존의 파일 제거

    > rails destroy model book
    > rake db:drop

####2. books 테이블과 관련된 기능을 한꺼번에 생성 ( rails generate 명령어 사용 )

    rails generate scaffold name field:type [...] [options]
    name : 모델 이름
    field : 필드 이름
    type : 자료형
    options : 동작 옵션
~~~~~~~~~~~~~~~~~
ex)
> rails generate scaffold book isbn:string title:string price:integer publish:string published:date cd:boolean
~~~~~~~~~~~~~~~~~

####3. 마이그레이션 파일 실행
* 마이그레이션으로 데이터를 생성하는 것만은 rake 명령어를 통해 별도로 실행해줘야 함
~~~~~~~~~~~~~~~~~~~
> rake db:migrate
~~~~~~~~~~~~~~~~~
------------------------
### 3.1.2 자동 생성된 라우트 확인 - resources 메서드
* routes.rb
~~~~~~~~~~~~~~~~~~
Railbook:Application.routes.draw do
  *resources :books*
  ..생략..
end
~~~~~~~~~~~~~~~~~
~~~~~~~~
> rake routes #현재 사용되고 있는 라우트를 목록으로 표시해주는 메서드
~~~~~~~~
-------------------------

## 3.2 목록 화면 작성
####3.2.1 index 액션 메서드
* books#index 액션은 "/books"에 들어가면 호출되는 메인 페이지를 생성하는 액션
* ex) books_controller.rb
~~~~~~~
def index
	@books = Book.all
end
~~~~~~

* 템플릿 파일 위치 : /app/views 폴더
~~~~
<컨트롤러 이름>/<액션 이름>.html.erb
~~~~

* ex) 실제로 index 액션에 대응하는 파일들
~~~~~
> index.html.erb : ERB로 HTML 형식을 출력할 때 사용하는 템플릿
> index.jason.builder : JSON 형식으로 형식으로 출력할 때 사용하는 템플릿, URL입력 필요
~~~~~
-----------------------------------------

####3.2.2 index.html.erb 템플릿
* ex) books/index.html.erb

        ...생략...
        <td><%= link_to 'Show', book %></td>
        <td><%= link_to 'Edit', edit_book_path(book) %></td>
        <td><%= link_to 'Destroy', book, method: :delete, data: { confirm: 'Are you sure?' } %></td>

        ...생략...

        <%= link_to 'New Book', new_book_path %>

1. 뷰 헬퍼 활용
    * 뷰 헬퍼(View Helper)는 템플릿 파일을 작성할 때 도움을 주는 메서드를 의미
    * 입력 양식 요소 생성을 비롯해 문자열 또는 숫자 정형화, 인코딩 처리 등 뷰에서 자주 사용되는 처리를 손쉽게 해낼 수 있게 함
    * 모델 또는 라우터를 연동하는 등 많은 기능이 있음
~~~~~~~~~~~~~~~~~
ex) link_to 메서드
link_to(body, url, [html_options])
    body : 링크 덱스트
    url : 링크 대상 경로(또는 매개 변수 정보)
    html_options : <a>태그에 적용할 옵션 정보 ("<속성 이름>:<값>"의 해시 형태)
~~~~~~~~~~~~~~~~~

2. link_to 메서드로 특정한 경로 표기(객체)
<%= link_to 'Show', book %>
3. link_to 메서드로 특정한 경로 표기(뷰 헬퍼)
~~~~~~~~
<%= link_to 'Edit', edit_book_path(book) %>
...생략...
<%= link_to 'New Book', new_book_path %>
~~~~~~~~
* routes.rb에서 resources 메서드를 호출할 떄 자동으로 사용되는 뷰 헬퍼

4. 링크를 클릭할 때 확인 대화상자 표시
 		<%= link_to 'Destroy', book, method: :delete, data: { confirm: 'Are you sure?' } %>
5. 링크 대상에 HTTP GET 이외의 것으로 접근

---------------------------------

##3.3 상세 화면 작성
####3.3.1 show 액션 메서드
~~~~~
ex) books_controller.rb
before_action :set_book, only: [:show, :edit, :update, :destroy] ---> 1
...생략...
def show ---> 2
end
...생략...
private ---> 3
	def set_book ---> 4
    	@book = Book.find(params[:id]) ---> 4
    end
~~~~~

1. before_action 메서드는 액션 메서드가 실행되기 전에 실행할 메서드를 지정함
	* show, edit, update, destroy 액션이 실행되기 전에 set_book 메서드가 실행
	* 여러 개의 액션에서 공통으로 사용되는 처리는 이렇게 필터화할 수 있음
~~~~
before_action method, only: action
method : 필터로 실행되는 메서드
action : 필터를 적용할 액션 매서드(배열)
~~~~

2. show 액션은 필터 메서드에서 처리하는 내용이 전부이므로 메서드 내부에 아무것도 없음
3. 필터가 하는 일, 필터는 액션으로 호출되지 않게 private 선언으로 되어 있다.
4. show 액션은 "/books/:id(.:format)" 이라는 URL 패턴과 연결되어 있음. 따라서 "/books/1" 같은 URL로 show 액션을 호출할 수 있다.
	* params 매서드는 URL에서 전달받은 매개 변수(여기서는 id)를 추출할 수 있게 함
	* "params[:id]"로 :id 매개 변수 값을 추출함
	* :id 매개 변수(Book 객체의 id)를 키로 books 테이블을 검색하는 것이 find 메서드의 역할
	* find 메서드는 id를 기반으로 해당하는 레코드를 검색하고, 결과를 모델 객체(여기서는 Book 객체)로 리턴
	* find 메서드에서 리턴한 결과를 템플릿에서 참조할 수 있도록 템플릿 변수 @book에 할당함
---------------

##3.4 새로운 데이터 등록 화면 작성 (new/create 액션)
####3.4.1 new.html.erb 템플릿 파일
~~~~
ex) books/new.html.erb
<h1>New Book</h1>

<%= render 'form' %>

<%= link_to 'Back', books_path %>
~~~~
* 부분 템플릿 : 메인 템플릿에서 불러들이는 템플릿
* 부분 템플릿을 출력할 떄는 render 메소드를 활용
* 부분 템플릿은 "_<이름>.html.erb" 형태로 파일의 이름 앞에 "_"가 붙어야 함
	(부분 템플릿으로 사용하겠다는 의미)

~~~~~
ex) books/_form.html.erb

<%= form_for(@book) do |f| %> ---> 1
  <% if @book.errors.any? %>
    <div id="error_explanation">
      <h2><%= pluralize(@book.errors.count, "error") %> prohibited this book from being saved:</h2>

      <ul>
      <% @book.errors.full_messages.each do |message| %>
        <li><%= message %></li>
      <% end %>
      </ul>
    </div>
  <% end %>

  <div class="field"> ----> 2
    <%= f.label :isbn %><br>
    <%= f.text_field :isbn %>
  </div>
  <div class="field">
    <%= f.label :title %><br>
    <%= f.text_field :title %>
  </div>
  <div class="field">
    <%= f.label :price %><br>
    <%= f.number_field :price %>
  </div>
  <div class="field">
    <%= f.label :publish %><br>
    <%= f.text_field :publish %>
  </div>
  <div class="field">
    <%= f.label :published %><br>
    <%= f.date_select :published %>
  </div>
  <div class="field">
    <%= f.label :cd %><br>
    <%= f.check_box :cd %>
  </div>
  <div class="actions">
    <%= f.submit %>
  </div>
<% end %>
~~~~~
1. 모델과 연동되는 입력 양식 생성
	* form_for 메서드는 뷰 헬퍼의 일종으로, 모델과 연동되는 입력 양식을 생성할 때 사용
	* form_for 메서드
~~~~
form_for(model) do |f|
	...입력 양식...
end
> model : 모델 객체
~~~~

	* 모델과 입력 양식 연동 시
		* 입력 값을 모델의 속성으로 변환
		* 수정 또는 오류가 발생할 때 모델의 현재 값을 입력 양식에 출력

2. 모델의 속성에 대응되는 입력 양식 위치 지정

####3.4.2 new와 create 액션 메서드
* 새로운 데이터 등록 페이지는 두 개의 액션과 연결되어 있습니다. 첫 번째 액션은 입력 양식을 출력하는 *new 액션*입니다. 그리고 두 번째 액션은 입력 양식에서 *[Create Book] 버튼*을 클릭했을 때 호출되는 데이터 등록 처리를 수행하는 *create 액션*입니다.
1. 입력 양식의 내용을 기반으로 객체 생성
2. POST 요청으로 보내진 데이터 추출(book_params 메서드)
	* 입력 양식으로부터 입력 받은 데이터(POST 데이터)를 추출할 때
~~~~
params.require(:book).permit(:isbn, :title, :price, :publish, :published, :cd)
~~~~
3. 입력 값으로 모델 재구성
~~~~
@book = Book.new(book_params)
~~~~
	* 해시의 값이 모델에 대응되는 속성으로 한꺼번에 설정됨
	* 해시를 객체로 재구성했다면 save() 메서드를 호출해 해당 내용 저장할 수 있음
4. 데이터 저장과 결과 처리 관련 조건 분기
* 매개 변수로 지정한 url로 리다이렉트(이동)하게 만드는 메서드
~~~~
redirect_to url, [option]
url:리다이렉트 대상 경로
option:옵션
~~~~

~~~~
format.html { redirect_to @book, notice: 'Book was successfully created.' }
~~~~

~~~~
<p id="notice"><%= notice %></p>
* notice 옵션으로 설정하 글자는 뷰 템플릿에서 지역 변수처럼 참조할 수 있으며, 리다이렉트 대상에 글자를 전달하는 수단으로 자주 사용된다. 기억하시길..
~~~~

-----------

##3.5 수정 화면 작성(edit/update 액션)
####3.5.1 edit 와 update 액션 메서드
* 수정 화면은 두 개의 액션과 연결되어 있다. 첫 번째 액션은 편집 입력 양식을 출력하는 *edit 액션*, 두 번째는 입력 양식에서 *[Update Book]* 버튼을 누를 때 호출되는 데이터 수정 처리를 수행하는 *update 액션*

~~~~
ex) boks_controller.rb

before_action :set_book, only: [:show, :edit, :update, :destroy]

  def edit
  end

  def update
    respond_to do |format|
      if @book.update(book_params)
        format.html { redirect_to @book, notice: 'Book was successfully updated.' }
        format.json { render :show, status: :ok, location: @book }
      else
        format.html { render :edit }
        format.json { render json: @book.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    def set_book
      @book = Book.find(params[:id])
    end
~~~~
* edit 액션은 set_book 함수로 객체를 추출하고 출력하는 것이 전부, 필로도 id 매개 변수를 주고 받음
* update 액션은 "입력된 데이터를 데이터베이스에 반영하고 결과를 기반으로 출력하는 흐름

1. 기존에 존재하는 객체를 수정

 * update 메서드
~~~~
> update(attrs) : attr(수정할 데이터("속성:값" 형태로 입력))
> 기존의 객체를 수정
> 매개 변수로 받은 값을 사용해 데이터를 변경하고 결과를 데이터베이스에 저장
~~~~

  * .update 메서드를 사용할 때는 find 메서드 등으로 편집하고 싶은 객체를 미리 얻어와야 한다는 점에 주위 (현재와 같은 경우는 set_book 필터에서 얻어옴)
  * save 메서드로 마찬가지로 수정 성공 여부를 true 나 false로 리턴

2. head 메서드로 헤더만 출력
~~~~~
head status
status: 응답 상태
~~~~~

####3.5.2 edit.html.erb
~~~~
<h1>Editing Book</h1>

<%= render 'form' %>

<%= link_to 'Show', @book %> |
<%= link_to 'Back', books_path %>
~~~~

1. 송신 대상 주소 변화
  * @book 객체의 내용이 비었는지(정확하게는 신규 레코드인지)에 따라서 form_for 메서드는action 속성을 변화, 객체가 신규 레코드라면 create 액션, 기존의 레코드라면 update 액션으로 전달하는 경로(URL)를 생성

2. HTTP 메서드와 관련된 추가 정보 설정

---------------------------

##3.6 제거 기능 확인 (destroy 액션)
~~~~
  def destroy
    @book.destroy
    respond_to do |format|
      format.html { redirect_to books_url, notice: 'Book was successfully destroyed.' }
      format.json { head :no_content }
    end
  end
~~~~
* destroy 액션은 /books/1 과 같은 URL로 호출됨.
* URL에 있는 id 매개 변수를 키로 Book 객체를 추출하고 이를 제거함
* 데이터를 제거할 때는 destroy 메서드를 사용
----------------------
