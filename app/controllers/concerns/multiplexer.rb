module Multiplexer
  @@cache ||= ActiveSupport::Cache::MemoryStore.new

  def cache_channel(account_id, channel_id)
    @@cache.write("account_#{account_id}", channel_id)
  end

  def fetch_channel(account_id)
    @@cache.fetch("account_#{account_id}")
  end

  def broadcast_to_multiple(account_ids, data)
    account_ids.each do |account_id|
      broadcast_to(account_id, data)
    end
  end

  def broadcast_to_all(from, data)
    ActionCable.server.broadcast "connector-global", from: from, data: data
  end

  def broadcast_to(id, data)
    channel_uuid = fetch_channel(id)
    unless channel_uuid.blank?
      ActionCable.server.broadcast "connector-#{channel_uuid}", from: id, data: data
    end
  end

end