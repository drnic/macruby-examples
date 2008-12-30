require 'hotcocoa'
include HotCocoa

class Application

  def start
    application :name   => "Download And Scrape Html" do |app|
      app.delegate = self
      window :frame     => [100, 100, 500, 500], :title => "Download And Scrape Html" do |win|
        win <<              label(:text => "Hello from HotCocoa", :layout => {:start => false})
        win << (@status   = label(:text => "...", :layout => {:start => false}, :frame => [0, 0, 300, 20]))
        win << (@data     = text_field(:text => "...", :layout => {:start => false}, :frame => [0, 0, 480, 400]))
        
        initiate_request("http://github.com/drnic", self)        
        win.will_close { exit }
      end
    end
  end
  
  def initiate_request(url_string, delegator)
    url         = NSURL.URLWithString(url_string)
    request     = NSURLRequest.requestWithURL(url)
    @connection = NSURLConnection.connectionWithRequest(request, delegate: delegator)
  end
  
  # Deal with the data response
  # 
  # Note: in Ruby, the method name is the method signature
  # Objective C uses what's called a selector
  # The objc selector for the method below would be:
  #   `connection:didReceiveResponse:`
  def connection(connection, didReceiveResponse:response)
    @status.text = (response.statusCode == 200) ? "Retrieving latest videos" : "There was an issue while trying to access the latest videos"
  end
  
  def connection(connection, didReceiveData:receivedData)
    @status.text  = "Data retrieved"
    page          = NSString.alloc.initWithData(receivedData, encoding:NSUTF8StringEncoding)
    NSLog(page)
    @data.text    = page
  end
end

Application.new.start
