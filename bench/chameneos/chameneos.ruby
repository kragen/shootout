#########################################
#     The Computer Language Shootout    #
#   http://shootout.alioth.debian.org/  #
#                                       #
#      contributed by Gordon Innes      #
#########################################
         
require 'thread'

$FADED=   0
$RED=     1
$BLUE=    2
$YELLOW=  3
  
class Chameneos

  def initialize(colour, meeting_point)
    @colour= colour
    @meeting_point= meeting_point
    @meetings= 0
  end

  def live()
    
    while true 
      @meeting_point.meet(self)
      if @colour == $FADED
        break
      else
        @meetings+=1
      end
    end
  end

  def met
    return @meetings
  end

  def complement(other_colour)
    case @colour
      when $BLUE
        @colour= other_colour == $RED ? $YELLOW : $RED
      when $RED
        @colour= other_colour == $BLUE ? $YELLOW : $BLUE
      when $YELLOW
        @colour= other_colour == $BLUE ? $RED : $BLUE
    end
  end

  def fade
    @colour= $FADED
  end
  
  def colour
    return @colour
  end
end

class MeetingPoint

  def initialize(total_meetings)
    @chameneos_waiting= nil
    @total_meetings= total_meetings

    @point_mutex= Mutex.new
    @waiting_cv= ConditionVariable.new
  end

  def meet(creature)
    @point_mutex.synchronize {
      if @total_meetings <= 0
        creature.fade
        return
      end
      
      if @chameneos_waiting
        creature.complement(@chameneos_waiting.colour)
        @waiting_cv.signal
        @chameneos_waiting= nil
        @total_meetings-=1
        return
      else
        @chameneos_waiting= creature
        @waiting_cv.wait(@point_mutex)
        return
      end
    }
  end
  
end


$creatures= []
meeting_point= MeetingPoint.new(ARGV[0].to_i)

[$BLUE, $RED, $YELLOW, $BLUE].each{ |colour|
  $creatures+= [Chameneos.new(colour, meeting_point)]
}

$creatures.each { |creature|
  Thread.new {
    creature.live
  }
}

Thread.list.each { |thread|
  thread.join if thread.alive? && thread != Thread.current
}

puts $creatures[0].met + $creatures[1].met + $creatures[2].met + $creatures[3].met
