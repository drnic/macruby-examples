require 'hotcocoa'
include HotCocoa

class Application

  def start
    application :name               => "Download And Scrape Html" do |app|
      app.delegate                  = self
      window :frame                 => [100, 100, 500, 500], :title => "Download And Scrape Html" do |win|
        win << label(:text          => "Hello from HotCocoa", :layout => {:start => false})
        win << (@didReceiveResponse = label(:text => "...", :layout => {:start => false}, :frame => [0, 0, 300, 20]))
        win << (@didReceiveData     = label(:text => "...", :layout => {:start => false}, :frame => [0, 0, 300, 20]))
        url                         = NSURL.URLWithString("http://github.com/drnic")
        request                     = NSURLRequest.requestWithURL(url)
        NSURLConnection.connectionWithRequest(request, delegate: self)
        win.will_close { exit }
      end
    end
  end
  
  
  def connection(connection, didReceiveResponse:didReceiveResponse)
    @didReceiveResponse.text = "connection_didReceiveResponse"
  end
  
  def connection(connection, didReceiveData:didReceiveData)
    @didReceiveData.text = "connection_didReceiveData"
  end
end

Application.new.start
