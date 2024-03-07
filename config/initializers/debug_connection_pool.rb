class ActiveRecord::ConnectionAdapters::ConnectionPool
  # Based on ConnectionPool#stat
  def my_stat
    synchronize do
      {
        connections: @connections.size,
        thread_id: Thread.current.object_id,
        in_use: @connections.select(&:in_use?).map(&:object_id),
        owner_alive: @connections.select { |c| c.owner&.alive? }.map(&:object_id),
        owner: @connections.map { |c| c.owner },
        current_context: ActiveSupport::IsolatedExecutionState.context,
        waiting: num_waiting_in_queue
      }
    end
  end
end