REBOL [
	Title: "nbody" 
	Author: "Robert Brandner"
	Version: 1.0
]

solar-mass: 4 * pi * pi
days-per-year: 365.24

body: make object! [
	x: y: z: vx: vy: vz: mass: 0
	offset-momentum: func [px py pz][
		vx: - px / solar-mass
		vy: - py / solar-mass
		vz: - pz / solar-mass
   ]
]

sun: make body [
	mass: solar-mass
]

jupiter: make body [
	x: 4.84143144246472090e+00
	y: -1.16032004402742839e+00
	z: -1.03622044471123109e-01
	vx: 1.66007664274403694e-03 * days-per-year
	vy: 7.69901118419740425e-03 * days-per-year
	vz: -6.90460016972063023e-05 * days-per-year
	mass: 9.54791938424326609e-04 * solar-mass
]

saturn: make body [
	x: 8.34336671824457987e+00
	y: 4.12479856412430479e+00
	z: -4.03523417114321381e-01
	vx: -2.76742510726862411e-03 * days-per-year
	vy: 4.99852801234917238e-03 * days-per-year
	vz: 2.30417297573763929e-05 * days-per-year
	mass: 2.85885980666130812e-04 * solar-mass
]

uranus: make body [
	x: 1.28943695621391310e+01
	y: -1.51111514016986312e+01
	z: -2.23307578892655734e-01
	vx: 2.96460137564761618e-03 * days-per-year
	vy: 2.37847173959480950e-03 * days-per-year
	vz: -2.96589568540237556e-05 * days-per-year
	mass: 4.36624404335156298e-05 * solar-mass
]

neptune: make body [
	x: 1.53796971148509165e+01
	y: -2.59193146099879641e+01
	z: 1.79258772950371181e-01
	vx: 2.68067772490389322e-03 * days-per-year
	vy: 1.62824170038242295e-03 * days-per-year
	vz: -9.51592254519715870e-05 * days-per-year
	mass: 5.15138902046611451e-05 * solar-mass
]

bodies: [sun jupiter saturn uranus neptune]

advance: func [dt][
	forall bodies [
		b1: get first bodies
		rest: next bodies
		forall rest [
			b2: get first rest
			dx: b1/x - b2/x
			dy: b1/y - b2/y
			dz: b1/z - b2/z
			distance: square-root ((dx ** 2) + (dy ** 2) + (dz ** 2))
			mag: dt / (distance ** 3)
			b2massmag: b2/mass * mag
			b1massmag: b1/mass * mag
			b1/vx: b1/vx - (dx * b2massmag)
			b1/vy: b1/vy - (dy * b2massmag)
			b1/vz: b1/vz - (dz * b2massmag)
			b2/vx: b2/vx + (dx * b1massmag)
			b2/vy: b2/vy + (dy * b1massmag)
			b2/vz: b2/vz + (dz * b1massmag)
		]
	]
	forall bodies [
		b1: get first bodies
		b1/x: b1/x + (dt * b1/vx)	
		b1/y: b1/y + (dt * b1/vy)
		b1/z: b1/z + (dt * b1/vz)
	]		
]

energy: func [/local dx dy dz distance e b1 b2][
	e: 0.0
	forall bodies [
		b1: get first bodies
		rest: next bodies
		e: e + (0.5 * b1/mass * ((b1/vx ** 2) + (b1/vy ** 2) + (b1/vz ** 2)))
		forall rest [
			b2: get first rest
			dx: b1/x - b2/x
			dy: b1/y - b2/y
			dz: b1/z - b2/z
			distance: square-root ((dx ** 2) + (dy ** 2) + (dz ** 2))
			e: e - ((b1/mass * b2/mass) / distance)
		]
	]
	e
]

n: either n: system/script/args [to-integer n] [1000]

px: py: pz: 0
forall bodies [
	b1: get first bodies
	px: px + (b1/vx * b1/mass)
	py: py + (b1/vy * b1/mass)
	pz: pz + (b1/vz * b1/mass)
]	
sun/offset-momentum px py pz

print round/to energy 1e-09
loop n [advance 0.01]
print round/to energy 1e-09
