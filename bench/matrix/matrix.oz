%%% $Id: matrix.oz,v 1.1 2004-05-23 07:14:27 bfulgham Exp $
%%% http://dada.perl.it/shootout/
%%% 
%%% contributed by Isaac Gouy

%%  Usage: start from command line with
%%     ozc -x matrix.oz -o matrix.oz.exe
%%     matrix.oz.exe 300

functor
import System Application

define

   proc {MakeMatrix Rows Cols M}
      local Count in
     {NewArray 0 Rows-1 0 M}
     Count ={NewCell 0}
     for I in 0..Rows-1 do
        local R in
           {NewArray 0 Cols-1 0 R}
           {Put M I R}
           for J in 0..Cols-1 do
          {Assign Count {Access Count}+1}
          {Put R J {Access Count}}
           end
        end
     end
      end
   end


   proc {MMult M1 M2 MM}
      local S1 N1 Prod S2 N2 in
     S1 = {Array.low M1}
     N1 = {Array.high M1}
     S2 = {Array.low {Get M1 S1}}
     N2 = {Array.high {Get M1 S1}}
     Prod = {NewCell 0}
     {NewArray S1 N1 0 MM}
     for I in S1..N1 do
        local R in
           {NewArray S1 N1 0 R}
           {Put MM I R}
           for J in S1..N1 do
          {Assign Prod 0}
          for K in S2..N2 do
             {Assign Prod {Get {Get M1 I} K}*
              {Get {Get M2 K} J}+{Access Prod}}
          end
          {Put R J {Access Prod}}
           end
        end
     end
      end
   end

   proc {RepeatMMult N M1 M2 MM}
      local T in
     if N > 1 then
        {MMult M1 M2 T}
        {RepeatMMult N-1 M1 M2 MM}
     else {MMult M1 M2 T} MM = T end
      end
   end
   
in 
   local Args Repeat N M1 M2 MM in
      [Args] = {Application.getArgs plain}
      Repeat = {String.toInt Args}
      N = 30
      {MakeMatrix N N M1}
      {MakeMatrix N N M2}
      {RepeatMMult Repeat M1 M2 MM}
      
      {System.printInfo {Get {Get MM 0} 0}}{System.printInfo ' '}
      {System.printInfo {Get {Get MM 2} 3}}{System.printInfo ' '} % get col 3 out of row 2
      {System.printInfo {Get {Get MM 3} 2}}{System.printInfo ' '} % get col 2 out of row 3
      {System.showInfo {Get {Get MM 4} 4} }     
   end
   {Application.exit 0}
end
