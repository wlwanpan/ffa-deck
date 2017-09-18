class MessagesChannel < ApplicationCable::Channel  
  
  def subscribed
    stream_from "MessagesChannel"
  end

  def unsubscribed
    stop_all_streams
  end

  private
end