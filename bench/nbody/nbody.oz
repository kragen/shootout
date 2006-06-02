% ----------------------------------------------------------------------
% The Great Computer Language Shootout                              
% http://shootout.alioth.debian.org/                                
%                                                                   
% Floating point conversion routines courtesy Juergen Stuber and Jorge
% Marques Pelizzoni [previously used in other Mozart/Oz Shooutout
% submissions].
%
% Contributed by Anthony Borla
% ----------------------------------------------------------------------

functor

import
  System(showInfo) Application(exit getArgs)

define

% ------------- %

  PI = 3.141592653589793
  SOLAR_MASS = 4.0 * PI * PI
  DAYS_PER_YEAR = 365.24

% ------------- %

  %% Single-body routines

  fun {NewBody X Y Z VX VY VZ MASS}
    body(x:{NewCell X} y:{NewCell Y} z:{NewCell Z} vx:{NewCell VX} vy:{NewCell VY} vz:{NewCell VZ} mass:{NewCell MASS})
  end

  proc {OffsetMomentum PX PY PZ Body}
    VX VY VZ
  in
    body(x:_ y:_ z:_ vx:VX vy:VY vz:VZ mass:_) = Body
    VX := ~PX / SOLAR_MASS
    VY := ~PY / SOLAR_MASS
    VZ := ~PZ / SOLAR_MASS
  end

% ------------- %

  %% Collection of bodies [Sun Jupiter Saturn Uranus Neptune]

  Bodies = [
    {NewBody 0.0 0.0 0.0 0.0 0.0 0.0 SOLAR_MASS}

    {NewBody 4.84143144246472090e00 ~1.16032004402742839e00 ~1.03622044471123109e~01
             (1.66007664274403694e~03 * DAYS_PER_YEAR) (7.69901118419740425e~03 * DAYS_PER_YEAR)
             (~6.90460016972063023e~05 * DAYS_PER_YEAR) (9.54791938424326609e~04 * SOLAR_MASS)}

    {NewBody 8.34336671824457987e00 4.12479856412430479e00 ~4.03523417114321381e~01
             (~2.76742510726862411e~03 * DAYS_PER_YEAR) (4.99852801234917238e~03 * DAYS_PER_YEAR)
             (2.30417297573763929e~05 * DAYS_PER_YEAR) (2.85885980666130812e~04 * SOLAR_MASS)}

    {NewBody 1.28943695621391310e01 ~1.51111514016986312e01 ~2.23307578892655734e~01
             (2.96460137564761618e~03 * DAYS_PER_YEAR) (2.37847173959480950e~03 * DAYS_PER_YEAR)
             (~2.96589568540237556e~05 * DAYS_PER_YEAR) (4.36624404335156298e~05 * SOLAR_MASS)}

    {NewBody 1.53796971148509165e01 ~2.59193146099879641e01 1.79258772950371181e~01
             (2.68067772490389322e~03 * DAYS_PER_YEAR) (1.62824170038242295e~03 * DAYS_PER_YEAR)
             (~9.51592254519715870e~05 * DAYS_PER_YEAR) (5.15138902046611451e~05 * SOLAR_MASS)}
  ]

% ------------- %

  %% Multi-body routines

  proc {Setup Bodies}
    PX = {NewCell 0.0} PY = {NewCell 0.0} PZ = {NewCell 0.0}
  in
    for body(x:_ y:_ z:_ vx:VX vy:VY vz:VZ mass:MASS) in Bodies do
      PX := @PX + @VX * @MASS
      PY := @PY + @VY * @MASS
      PZ := @PZ + @VZ * @MASS
    end

    {OffsetMomentum @PX @PY @PZ Bodies.1}
  end

% ------------- %

  proc {Advance DT Bodies}
    DX = {NewCell 0.0} DY = {NewCell 0.0} DZ = {NewCell 0.0} DISTANCE = {NewCell 0.0}
    MAG = {NewCell 0.0} Idx = {NewCell 1}
  in
    for body(x:Xo y:Yo z:Zo vx:VXo vy:VYo vz:VZo mass:MASSo) in Bodies do

      for body(x:X y:Y z:Z vx:VX vy:VY vz:VZ mass:MASS) in {List.drop Bodies @Idx} do
        DX := @Xo - @X
        DY := @Yo - @Y
        DZ := @Zo - @Z

        DISTANCE := {Sqrt (@DX * @DX + @DY * @DY + @DZ * @DZ)}
        MAG := DT / (@DISTANCE * @DISTANCE * @DISTANCE)

        VXo := @VXo - @DX * @MASS * @MAG
        VYo := @VYo - @DY * @MASS * @MAG
        VZo := @VZo - @DZ * @MASS * @MAG

        VX := @VX + @DX * @MASSo * @MAG
        VY := @VY + @DY * @MASSo * @MAG
        VZ := @VZ + @DZ * @MASSo * @MAG
      end

      Idx := @Idx + 1
    end

    for body(x:X y:Y z:Z vx:VX vy:VY vz:VZ mass:_) in Bodies do
      X := @X + DT * @VX
      Y := @Y + DT * @VY
      Z := @Z + DT * @VZ
    end
  end

% ------------- %

  fun {Energy Bodies}
    DX = {NewCell 0.0} DY = {NewCell 0.0} DZ = {NewCell 0.0} DISTANCE = {NewCell 0.0}
    E = {NewCell 0.0} Idx = {NewCell 1}
  in
    for body(x:Xo y:Yo z:Zo vx:VXo vy:VYo vz:VZo mass:MASSo) in Bodies do

      E := @E + 0.5 * @MASSo * (@VXo * @VXo + @VYo * @VYo + @VZo * @VZo)

      for body(x:X y:Y z:Z vx:_ vy:_ vz:_ mass:MASS) in {List.drop Bodies @Idx} do
        DX := @Xo - @X
        DY := @Yo - @Y
        DZ := @Zo - @Z

        DISTANCE := {Sqrt (@DX * @DX + @DY * @DY + @DZ * @DZ)}

        E := @E - (@MASSo * @MASS) / @DISTANCE
      end

      Idx := @Idx + 1
    end

    @E
  end

% ------------- %

  fun {CmdlNArg Nth Default} N Nt in
    try
      Nt = {String.toInt {Application.getArgs plain}.Nth}
      N = if Nt < Default then Default else Nt end
    catch error(...) then
      N = Default
    end
    N
  end

% ------------- %

  %% Floating Point Conversion Routines

  fun {FloatAbs X}
    if X >= 0.0 then X else ~X end
  end

  fun {FloatSquare X}
    X * X
  end

  fun {FloatPower X E}
    if E==0 then 1.0
    elseif E<0 then raise negativeExponent(E) end
    else
      if E mod 2 == 1 then X else 1.0 end
      * {FloatSquare {FloatPower X E div 2}}
    end
  end

  fun {MakePadding Ch L}
    if L > 0 then
      Padding = {MakeList L}
    in
      for V in Padding do V = Ch end
        Padding
      else
        nil
    end
  end

  fun {PadLeft Ch String L}
    PL = L - {List.length String}
  in
    {MakePadding Ch PL} # String
  end

  fun {FloatToVS F Prec}
    fun {FractionToString Frac Prec}
      if Prec =< 0 then ""
      elseif Prec > 10 then raise excessivePrecision(Prec) end
      else
        Shifted = {FloatPower 10.0 Prec} * Frac
        Digits = {FloatToInt {Round Shifted}}
        in {PadLeft &0 {IntToString Digits} Prec}
      end
    end

    I = {FloatToInt {if F >= 0.0 then Floor else Ceil end F}}
    Frac = {FloatAbs F - {IntToFloat I}}
  in
    {IntToString I} # "." # {FractionToString Frac Prec}
  end

  fun {FloatToString F Prec}
    Result = {NewCell {VirtualString.toString {FloatToVS F Prec}}}
    P = fun {$ C} if C == &~ then &- else C end end
  in
    if F < 0.0 andthen {Nth @Result 1} \= &~ then
      Result := &~|@Result 
    end
    {Map @Result P}
  end

% ------------- %

  N

% ------------- %

in
  N = {CmdlNArg 1 1}

  {Setup Bodies}

  {System.showInfo {FloatToString {Energy Bodies} 9}}
  for I in 1..N do {Advance 0.01 Bodies} end
  {System.showInfo {FloatToString {Energy Bodies} 9}}

  {Application.exit 0}
end

