#!/bin/env groovy
/*
	$Id: chameneos.groovy,v 1.1 2005-09-23 15:18:28 igouy-guest Exp $

	The Great Computer Language Shootout
	http://shootout.alioth.debian.org/

	contributed by Jochen Hinrichsen
	modified by 

	For a description of the benchmark, check Chameneos.pdf
*/

class Colour {

    static public blue		= new Colour(colour:"blue")
    static public faded		= new Colour(colour:"faded")
    static public red		= new Colour(colour:"red")
    static public yellow	= new Colour(colour:"yellow")

	@Property colour

	// == operator
	public isCase(Object c) {
		colour == c.colour
	}

	// don't use arithmetic
	// use if-else or switch/case or pattern-match
	public Colour complement(Colour other) {
		if (this == other) return this

		def c = this
		switch (this) {
			case blue:		c = ( other == Colour.red  ? Colour.yellow : Colour.red)
			case red:		c = ( other == Colour.blue ? Colour.yellow : Colour.blue)
         	case yellow:	c = ( other == Colour.blue ? Colour.red    : Colour.blue)
      	}
	  	return c
	}

	public String toString() {
		return colour
	}

}

assert Colour.yellow.complement(Colour.blue) == Colour.red

class Mall {

    @Property AColour, BColour
    @Property FirstCall = true
    @Property MustWait = false
    
	@Property maxMeetings = 100

    public synchronized Colour Cooperation(id, Colour c) {
        def other = c
        while (MustWait) { try { wait () } catch (InterruptedException e) {} }
        
        if (FirstCall) {
			if (maxMeetings-- > 0) {
	            AColour = c
				FirstCall = false 
				while (!FirstCall) { try { wait () } catch (InterruptedException e) {} }
				MustWait = false 
				other = BColour
			 } else {
			 	// Thread termination condition
				other = Colour.faded
			}
        } else {
            BColour = c
            FirstCall = true
            MustWait = true
            other = AColour
        }
		assert other != null
        notifyAll()
        return other 
    }

}

class AChameneos extends Thread {

    @Property Mall mall 
    @Property id
    @Property Colour myColour, otherColour
	@Property meetings = 0
    
    private void Mutating() {
        otherColour = mall.Cooperation(id, myColour)
		if (otherColour == Colour.faded) {
			myColour = otherColour;
		} else {
			meetings++
        	myColour = myColour.complement(otherColour)
		}
    }
    
    public void run() {
        while(myColour != Colour.faded) {
	        // EatingHoneysuckleAndTraining()
   	      	// GoingToTheMall()
   	       	Mutating()
        }
    }
}

def N = (args.length == 0) ? 10000 : args[0].toInteger()
def colours = [
	Colour.blue,
	Colour.red,
	Colour.yellow,
	Colour.blue,
]
    
def chameneos = []
def myMall = new Mall(maxMeetings: N)
def i = 0
colours.each() { colour ->
    chameneos += new AChameneos(mall:myMall, id:i++, myColour:colour)
}

chameneos.each() { 
	it.start()
}

chameneos.each() { 
	it.join()
}

// Count total meetings
def total = chameneos.inject(0) { sum, it ->
	sum += it.meetings
}

println total
assert total == 2 * N

// EOF

