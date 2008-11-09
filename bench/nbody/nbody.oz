% The Computer Language Benchmarks Game 
% http://shootout.alioth.debian.org/    
% contributed by Isaac Gouy

functor
import
   System Application 
   S at 'Include/oz/shootout.ozf'   

define
   Pi = 3.141592653589793
   SolarMass = 4.0 * Pi * Pi
   DaysPerYear = 365.24


   class Body
      attr x y z vx vy vz mass

      meth init(X Y Z Vx Vy Vz Mass)
         x := X
         y := Y
         z := Z
         vx := Vx 
         vy := Vy
         vz := Vz
         mass := Mass 
      end

      meth x($) @x end
      meth y($) @y end
      meth z($) @z end
      meth mass($) @mass end

      meth kineticEnergy($) 0.5 * @mass * (@vx*@vx + @vy*@vy + @vz*@vz) end

      meth potentialEnergy(B $)
         Dx = @x - {B x($)} 
         Dy = @y - {B y($)} 
         Dz = @z - {B z($)} 
         Distance = {Sqrt (Dx*Dx + Dy*Dy + Dz*Dz)}
      in 
         (@mass * {B mass($)}) / Distance
      end     

      meth increaseVelocity(Dx Dy Dz M)  
         vx := @vx + Dx*M
         vy := @vy + Dy*M
         vz := @vz + Dz*M
      end    

      meth decreaseVelocity(Dx Dy Dz M)  
         vx := @vx - Dx*M
         vy := @vy - Dy*M
         vz := @vz - Dz*M
      end    
  
      meth addMomentumTo(?A)
         A.1 := A.1 + @vx*@mass
         A.2 := A.2 + @vy*@mass
         A.3 := A.3 + @vz*@mass
      end

      meth offsetMomentum(A)
         vx := ~ A.1 / SolarMass
         vy := ~ A.2 / SolarMass
         vz := ~ A.3 / SolarMass
      end

      meth updatePositionAfter(Dt)
         x := @x + Dt*@vx
         y := @y + Dt*@vy
         z := @z + Dt*@vz
      end

      meth updateVelocitiesAfter(Dt ?B)
         Dx = @x - {B x($)} 
         Dy = @y - {B y($)} 
         Dz = @z - {B z($)} 
         Distance = {Sqrt (Dx*Dx + Dy*Dy + Dz*Dz)}
         Magnitude = Dt / (Distance * Distance * Distance)
      in 
         {self decreaseVelocity(Dx Dy Dz ({B mass($)} * Magnitude))}
         {B increaseVelocity(Dx Dy Dz (@mass * Magnitude))}
      end

   end   % Body


   Sun = {New Body init(0.0 0.0 0.0 0.0 0.0 0.0 SolarMass)}

   Jupiter = {New Body init(
      4.84143144246472090e00 
      ~1.16032004402742839e00 
      ~1.03622044471123109e~01
      1.66007664274403694e~03 * DaysPerYear
      7.69901118419740425e~03 * DaysPerYear
      ~6.90460016972063023e~05 * DaysPerYear
      9.54791938424326609e~04 * SolarMass 
      )}

   Saturn = {New Body init(
      8.34336671824457987e00
      4.12479856412430479e00
      ~4.03523417114321381e~01
      ~2.76742510726862411e~03 * DaysPerYear
      4.99852801234917238e~03 * DaysPerYear
      2.30417297573763929e~05 * DaysPerYear
      2.85885980666130812e~04 * SolarMass
      )}

   Uranus = {New Body init(
      1.28943695621391310e01
      ~1.51111514016986312e01
      ~2.23307578892655734e~01
      2.96460137564761618e~03 * DaysPerYear
      2.37847173959480950e~03 * DaysPerYear
      ~2.96589568540237556e~05 * DaysPerYear
      4.36624404335156298e~05 * SolarMass
      )}

   Neptune = {New Body init(
      1.53796971148509165e01
      ~2.59193146099879641e01
      1.79258772950371181e~01
      2.68067772490389322e~03 * DaysPerYear
      1.62824170038242295e~03 * DaysPerYear
      ~9.51592254519715870e~05 * DaysPerYear
      5.15138902046611451e~05 * SolarMass
      )}


   class NBodySystem
      attr bodies

      meth init()
         bodies := {Tuple.toArray Sun # Jupiter # Saturn # Uranus # Neptune} 
         A = {Tuple.toArray 0.0 # 0.0 # 0.0} 
         N = {Array.high @bodies} 
      in
         for I in 1..N do {@bodies.I addMomentumTo(A)} end
         {@bodies.1 offsetMomentum(A)}     
      end

      meth after(Dt)
         N = {Array.high @bodies} 
      in 
         for I in 1..N do 
            for J in I+1..N do 
               {@bodies.I updateVelocitiesAfter(Dt @bodies.J)}
            end
         end
         for I in 1..N do {@bodies.I updatePositionAfter(Dt)} end
      end

      meth energy($)
         E = {NewCell 0.0} 
         N = {Array.high @bodies} 
      in
         for I in 1..N do
            E := @E + {@bodies.I kineticEnergy($)}
            for J in I+1..N do
               E := @E - {@bodies.I potentialEnergy(@bodies.J $)}
            end
         end
         @E
      end

   end   % NBodySystem


   NBody = {New NBodySystem init}

   [Arg] = {Application.getArgs plain}
   N = {String.toInt Arg}

in   
   {System.showInfo {S.floatToString {NBody energy($)} 9}}
   for I in 1..N do {NBody after(0.01)} end
   {System.showInfo {S.floatToString {NBody energy($)} 9}}
   {Application.exit 0}   
end
