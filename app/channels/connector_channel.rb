class ConnectorChannel < ApplicationCable::Channel

  def subscribed
    stream_from "connector-#{params[:tunnel]}"
  end

  def unsubscribed
    stop_all_streams
  end

end