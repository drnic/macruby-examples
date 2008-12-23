require 'hotcocoa'

# Replace the following code with your own hotcocoa code

class Application

  include HotCocoa
  
  def start
    application :name => "Download And Scrape Html" do |app|
      app.delegate = self
      window :frame => [100, 100, 500, 500], :title => "Download And Scrape Html" do |win|
        @l = label(:text => "Hello from HotCocoa", :layout => {:start => false})
        win << @l
        url = NSURL.URLWithString("http://github.com/drnic")
        request = NSURLRequest.requestWithURL(url)
        NSURLConnection.connectionWithRequest(request, delegate: self)
        win.will_close { exit }
      end
    end
  end
  
  
  def connection(connection, didReceiveResponse:didReceiveResponse)
    @l.text = "connection_didReceiveResponse"
  end
  
  def connection(connection, didReceiveData:didReceiveData)
    @l.text = "connection_didReceiveData"
  end
  
  
  # file/open
  def on_open(menu)
  end
  
  # file/new 
  def on_new(menu)
  end
  
  # help menu item
  def on_help(menu)
  end
  
  # This is commented out, so the minimize menu item is disabled
  #def on_minimize(menu)
  #end
  
  # window/zoom
  def on_zoom(menu)
  end
  
  # window/bring_all_to_front
  def on_bring_all_to_front(menu)
  end
end

Application.new.start