require "check_http_response/version"
require "check_http_response/request"

module CheckHttpResponse

  def self.for(url, options = {})
    return Request.new(url, options)
  end

end
