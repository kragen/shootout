"  The Computer Language Shootout
   http://shootout.alioth.debian.org/
   contributed by Isaac Gouy"!

!ComputerLanguageShootout.Benchmarks class methodsFor: 'benchmarking'!

nbody: argvString
   | n bodies |
   n := argvString asNumber.
   bodies := NBodySystem new initialize.

   OS.Stdout nextPutAll: ((bodies energy asFixedPoint: 9) printString copyWithout: $s); cr.
   n timesRepeat: [bodies after: 0.01d].
   OS.Stdout nextPutAll: ((bodies energy asFixedPoint: 9) printString copyWithout: $s); cr! !


Smalltalk.ComputerLanguageShootout defineClass: #NBodySystem
	superclass: #{Core.Object}
	indexedType: #none
	private: false
	instanceVariableNames: 'bodies '
	classInstanceVariableNames: ''
	imports: ''
	category: 'ComputerLanguageShootout'!

!ComputerLanguageShootout.NBodySystem methodsFor: 'nbody'!

after: dt
   1 to: bodies size do: [:i|
      i+1 to: bodies size do: [:j|                            
         (bodies at: i) and: (bodies at: j) velocityAfter: dt].
   ].   
   bodies do: [:each| each positionAfter: dt]!

energy
   | e |
   e := 0.0d.
   1 to: bodies size do: [:i|       
      e := e + (0.5d * (bodies at: i) momo).

      i+1 to: bodies size do: [:j| 
         e := e - ((bodies at: i) eFactorWith: (bodies at: j))].
   ].
   ^e! !

!ComputerLanguageShootout.NBodySystem methodsFor: 'initialize-release'!

initialize
   | px py pz |
   bodies := OrderedCollection new 
      add: Body sun; add: Body jupiter; add: Body saturn;
      add: Body uranus; add: Body neptune; yourself.

   px := 0.0d.
   py := 0.0d.
   pz := 0.0d.
   bodies do: [:each| 
      px := px + (each vx * each mass).
      py := py + (each vy * each mass).		
      pz := pz + (each vz * each mass).	
   ].
   bodies first offsetMomentum: px y: py z: pz! !


Smalltalk.ComputerLanguageShootout defineClass: #Body
	superclass: #{Core.Object}
	indexedType: #none
	private: false
	instanceVariableNames: 'x y z vx vy vz mass '
	classInstanceVariableNames: ''
	imports: ''
	category: 'ComputerLanguageShootout'!


!ComputerLanguageShootout.Body class methodsFor: 'constants'!

daysPerYear
   ^365.24d!

jupiter
   ^self new
      x: 4.84143144246472090d0
      y: -1.16032004402742839d0
      z: -1.03622044471123109d-1
      vx: 1.66007664274403694d-3 * self daysPerYear
      vy: 7.69901118419740425d-3 * self daysPerYear
      vz: -6.90460016972063023d-5 * self daysPerYear
      mass: 9.54791938424326609d-4 * self solarMass!

neptune
   ^self new
      x: 1.53796971148509165d1
      y: -2.59193146099879641d1
      z: 1.79258772950371181d-1
      vx: 2.68067772490389322d-3 * self daysPerYear
      vy: 1.62824170038242295d-3 * self daysPerYear
      vz: -9.51592254519715870d-5 * self daysPerYear
      mass: 5.15138902046611451d-5 * self solarMass!

pi
   ^3.141592653589793d!

saturn
   ^self new
      x: 8.34336671824457987d0
      y: 4.12479856412430479d0
      z: -4.03523417114321381d-1
      vx: -2.76742510726862411d-3 * self daysPerYear
      vy: 4.99852801234917238d-3 * self daysPerYear
      vz: 2.30417297573763929d-5 * self daysPerYear
      mass: 2.85885980666130812d-4 * self solarMass!

solarMass
   ^4.0d * self pi * self pi!

sun
   ^self new
      x: 0.0d0
      y: 0.0d0
      z: 0.0d0
      vx: 0.0d0
      vy: 0.0d0
      vz: 0.0d0
      mass: self solarMass!

uranus
   ^self new
      x: 1.28943695621391310d1
      y: -1.51111514016986312d1
      z: -2.23307578892655734d-1
      vx: 2.96460137564761618d-3 * self daysPerYear
      vy: 2.37847173959480950d-3 * self daysPerYear
      vz: -2.96589568540237556d-5 * self daysPerYear
      mass: 4.36624404335156298d-5 * self solarMass! !


!ComputerLanguageShootout.Body methodsFor: 'accessing'!

mass
   ^mass!

vx
   ^vx!

vy
   ^vy!

vz
   ^vz!

x
   ^x!

x: d1 y: d2 z: d3 vx: d4 vy: d5 vz: d6 mass: d7
   x := d1.
   y := d2. 
   z := d3. 
   vx := d4.
   vy := d5.
   vz := d6.
   mass := d7!

y
   ^y!

z
   ^z! !

!ComputerLanguageShootout.Body methodsFor: 'nbody'!

and: aBody velocityAfter: dt	     
   | dx dy dz distance mag |
   dx := x - aBody x.
   dy := y - aBody y.
   dz := z - aBody z.
   
   distance := ((dx*dx) + (dy*dy) + (dz*dz)) sqrt.
   mag := dt / (distance * distance * distance).

   self decreaseVelocity: dx y: dy z: dz m: aBody mass * mag.   
   aBody increaseVelocity: dx y: dy z: dz m: mass * mag!

decreaseVelocity: dx y: dy z: dz m: m
   vx := vx - (dx * m).
   vy := vy - (dy * m).
   vz := vz - (dz * m)!

eFactorWith: aBody
   | dx dy dz distance |
   dx := x - aBody x.
   dy := y - aBody y.
   dz := z - aBody z.

   distance := ((dx*dx) + (dy*dy) + (dz*dz)) sqrt.
   ^mass * aBody mass / distance!

increaseVelocity: dx y: dy z: dz m: m
   vx := vx + (dx * m).
   vy := vy + (dy * m).
   vz := vz + (dz * m)!

momo
   ^mass * ((vx * vx) + (vy * vy) + (vz * vz))!

offsetMomentum: px y: py z: pz
   | m |
   m := self class solarMass.
   vx := px negated / m.
   vy := py negated / m.
   vz := pz negated / m!

positionAfter: dt
   x := x + (dt * vx).
   y := y + (dt * vy).
   z := z + (dt * vz)! !
