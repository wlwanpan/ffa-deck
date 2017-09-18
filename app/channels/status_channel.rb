class StatusChannel < ApplicationCable::Channel  
  
  def subscribed
    stream_from "global-status-channel"
  end

  def unsubscribed
    stop_all_streams
  end

end