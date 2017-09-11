class MessagesChannel < ApplicationCable::Channel  
  
  def subscribed
    stream_from "MessagesChannel"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
    stop_all_streams
  end

  private

  def current_channel
    Channel.find_by(uuid: params[:channelUUID]) || nil
  end
end