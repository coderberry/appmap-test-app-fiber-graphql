Whoop.setup do |config|
  # config.logger = ActiveSupport::Logger.new("log/debug.log")
  # config.logger = ActiveSupport::Logger.new("log/#{Rails.env}.log")
  # config.logger = ActiveSupport::Logger.new($stdout)
  # config.logger = SemanticLogger["WHOOP"]
  config.logger = nil # uses `puts`

  config.level = :debug
  # config.level = :info
  # config.level = :warn
  # config.level = :error
end

class ActiveRecord::ConnectionAdapters::ConnectionPool
  # Based on ConnectionPool#stat
  def my_stat
    synchronize do
      {
        # size: size,
        connections: @connections.size,
        in_use: @connections.select(&:in_use?).map(&:object_id),
        owner_alive: @connections.select { |c| c.owner&.alive? }.map(&:object_id),
        owner: @connections.map { |c| c.owner },
        current_context: ActiveSupport::IsolatedExecutionState.context,
        # busy: @connections.count { |c| c.in_use? && c.owner.alive? },
        # dead: @connections.count { |c| c.in_use? && !c.owner.alive? },
        # idle: @connections.count { |c| !c.in_use? },
        waiting: num_waiting_in_queue,
      }
    end
  end
end

# ActiveSupport::Notifications.subscribe('sql.active_record') do |name, started, finished, unique_id, data|
#   sql = data.delete :sql
#   connection_id = data.delete :connection_id
#   # whoop("SQL QUERY", format: :sql, context: { name: name, started: started, finished: finished, unique_id: unique_id, connection_id: connection_id, data_keys: data.keys }) {
#   #   sql
#   # }
# end