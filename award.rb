module NormalAward
  def update_quality
    incr = @expires_in > 0 ? -1 : -2
    @quality = [0, @quality+incr].max
    @expires_in -= 1
  end
end

module BlueFirst
  def update_quality
    incr = if @expires_in > 0
             1
           else
             2
           end
    @quality = [50, @quality+incr].min
    @expires_in -= 1
  end
end

module BlueCompare
  def update_quality
    incr = if @expires_in <= 0
             @quality = 0
           elsif @expires_in <= 5
             3
           elsif @expires_in <= 10
             2
           else
             1
           end
    @quality = [50, @quality+incr].min
    @expires_in -= 1
  end
end

module BlueDistinctionPlus
  def update_quality
  end
end

module BlueStar
  def update_quality
    incr = @expires_in > 0 ? -2 : -4
    @quality = [0, @quality+incr].max
    @expires_in -= 1
  end
end


class Award
  attr_accessor :name, :expires_in, :quality

  def initialize(name, expires_in, quality)
    @name = name
    @expires_in = expires_in
    @quality = quality

    case name
    when 'Blue First'
      extend BlueFirst
    when 'Blue Compare'
      extend BlueCompare
    when 'Blue Distinction Plus'
      extend BlueDistinctionPlus
    when 'Blue Star'
      extend BlueStar
    else
      extend NormalAward
    end
  end
end

