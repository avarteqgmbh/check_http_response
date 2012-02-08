# CheckHttpResponse

## Usage

    response = CheckHttpResponse.for(
      'http://localhost:8080/page/1',
      :headers => { 'Host' => 'www.mydomain.com' }
    )

    response.redirects_to?("http://www.mydomain.com/page1") #=> true

    response.redirects_to?("http://nowhere.com/page2")      #=> false
    response.errors                                         #=> { :redirect => "Wrong location! Got: http://www.mydomain.com/page1 , expected: "http://nowhere.com/page2" }
