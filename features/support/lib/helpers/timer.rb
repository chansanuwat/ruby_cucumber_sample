class Timer

  def initialize name
    Tracker.log("Creating timer: #{name}", 4)
    @name = name
    @start = Time.now
  end

  def stop
    @end = Time.now
    return duration
  end

  def duration
    dur = (@end - @start)
    Tracker.log("#{@name} duration: #{dur}")
    return dur
  end
end