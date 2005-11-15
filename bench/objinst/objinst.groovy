/*
	The Computer Language Shootout
	http://shootout.alioth.debian.org/

	contributed by Jochen Hinrichsen
*/

class Toggle {

	public state = false

	public activate() {
		state = !state
		this
	}

	public value() {
		state
	}

}

class NthToggle extends Toggle {

	public counter = 0
	public counterMax = 0

	public activate() {
		assert counter != null
		assert counterMax != null
		assert state != null
		counter ++
		if (counter >= counterMax) {
			state = !state
			counter = 0
		}
		this
	}
}

def n = args.length == 0 ? 1 : args[0].toInteger()

// Create a toggle object and activate 5 times
toggle = new Toggle(state:true)
(1..5).each() {
	println(toggle.activate().value() ? "true" : "false")
}

// Create N toggle objects and activate each 8 times
def toggles = new Toggle[n]
(0..<n).each() {
	toggles[it] = new Toggle(state:true)
}

println ""

(1..8).each() {
	toggles.each() {
		it.activate()
	}
}

def nthToggle = new NthToggle(state:true, counterMax:3)
assert nthToggle.counterMax = 3

(1..8).each() {
	println(nthToggle.activate().value() ? "true" : "false")
	// println(nthToggle.activate())
}

(1..n).each() {
	new NthToggle(state:true, counterMax:3)
}

// EOF

