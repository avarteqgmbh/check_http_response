require 'httparty'

module CheckHttpResponse
  class Request

    class HttpRequest
      include ::HTTParty
    end

    attr_reader :errors, :url, :headers

    def initialize(url, options)
      @headers = options[:headers] || {}
      @url = url

      clear_errors
    end

    # Returns true if the response redirects to the given location.
    #
    # Warning: '303 see other' is not supported
    #
    #   response = CheckHttpResponse.for('http://localhost:8080/page/1',
    #     :headers => { 'Host' => 'www.mydomain.com' }
    #   )
    #   response.redirects_to?('http://www.mydomain.com/page/1/index.html') #=> true
    #
    #   response.redirects_to?('http://www.nowhere.com/') #=> false
    #   response.errors #=> { :redirect => "Wrong location" }
    #
    # ==== Options
    # <tt>:permanent</tt> Specifies whether the redirect should be 'permanent', default: true
    def redirects_to?(location, options = {})
      clear_errors

      check_permanent = true
      check_permanent = options[:permanent] if not options[:permanent].nil?

      redirected = false
      begin
        HttpRequest.get(self.url,
          :headers => self.headers,
          :no_follow => true
        )

        @errors[:base] = "No redirect initiated"
      rescue HTTParty::RedirectionTooDeep => e
        is_correct_location = location == e.response['location']

        is_correct_redirect = if check_permanent
                                e.response.class == Net::HTTPMovedPermanently
                              else
                                e.response.class == Net::HTTPFound
                              end

        redirected = is_correct_location && is_correct_redirect
        @errors[:redirect] = "Wrong redirect type" if not is_correct_redirect
        @errors[:redirect] = "Wrong location" if not is_correct_location
      end

      return redirected
    end

    private

    def clear_errors
      @errors = {}
    end

  end

end
