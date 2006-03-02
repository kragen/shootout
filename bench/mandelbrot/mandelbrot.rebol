REBOL [
	Title: "mandelbrot" 
	Author: "Robert Brandner"
	Version: 1.1
]
n: either n: system/script/args [to-integer n] [200]

header: rejoin ["P4^(0A)" n " " n "^(0A)"]
write-io system/ports/output header length? header  ; to write newline as 0A in windows

nn: n - 1
iter: 50
limit2: 4.0
byte_acc: #"^@"
bit_num: 0

for y 0 nn 1 [
	for x 0 nn 1 [
		zr: zi: 0.0
		zr2: zi2: 0.0
		cr: ((2.0 * x) / n) - 1.5
        ci: ((2.0 * y) / n) - 1.0
        dot: true
        loop iter [        
        	tr: zr2 - zi2 + cr
            ti: (2 * (zr * zi)) + ci
    		zr: tr
    		zi: ti 
        	zr2: zr * zr
        	zi2: zi * zi
    		if ((zr2 + zi2) > limit2) [dot: false break]
    	]
		byte_acc: byte_acc * 2
		if dot [byte_acc: byte_acc or 1]
		bit_num: bit_num + 1
        if (bit_num == 8) or (x == nn) [
        	byte_acc: byte_acc * (2 ** (8 - bit_num))
			write-io system/ports/output to-string byte_acc 1  ; needed to write ^(null)
			byte_acc: #"^@"
			bit_num: 0
    	]    	
	]
]
