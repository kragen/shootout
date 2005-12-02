/*
	The Computer Language Shootout
	http://shootout.alioth.debian.org/

	contributed by Jochen Hinrichsen
*/

def sequence = readSequence(System.in, ">THREE").toUpperCase()
assert sequence.size() > 1000

[1, 2].each() {
    writeFrequency(sequence, it)
}

[ "GGT", "GGTA", "GGTATT", "GGTATTTTAATT", "GGTATTTTAATTTATAGT" ].each() {
        println "${sequence.count(it)}\t${it}"
}

def readSequence(streamin, id) {
    def sequence = ""
    def record = false
    streamin.eachLine() { line ->
        switch (line) {
            case ~"^$id.*":
                record = true
                break

            case [~"^>.*", ~"^;.*"]:
                record = false
                break
            
            default:
                if (record) {
                    sequence += line
                }
        }
    }
    sequence
}

def writeFrequency(sequence, f) {
    def count = [:]
    def formater = new java.text.DecimalFormat("#0.000")
    for (offset in 0..<f) frequency(sequence, f, offset, count)

    // default sort() is smallest first
    // sort for multiple properties: [ it.value, it.key ]
    count.values().sort({ l, r -> r <=> l}).each() { value ->
        def entry = count.find() { entry ->
            entry.getValue() == value
        }
    
        println "${entry.key} ${formater.format(100.0*value/(sequence.size()-f+1))}"
    }

    println ""
}

def frequency(sequence, f, offset, count) {
    def n = sequence.size()
    def last = n - f + 1

    (offset..<last).step(f) { i ->
        def key = sequence[i..<i+f]
        // No automatic defaulting
        if (count[key] == null) count[key] = 1
        // ++ results in error
        else count[key] += 1
    }
}

// EOF

