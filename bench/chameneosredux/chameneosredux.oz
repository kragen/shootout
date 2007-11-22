% The Computer Language Benchmarks Game                              
% http://shootout.alioth.debian.org/    
% contributed by Isaac Gouy

functor
import System Application

define
   fun {RendezvousServer Done N}
      CreatureList
      CreaturePort = {Port.new CreatureList}
      OtherList 
      OtherPort = {Port.new OtherList}     
      CountDown = {NewCell N}

      proc {Meetings C1|C2|C O1|O2|O}
         if @CountDown > 0 then
            O1 = C2
            O2 = C1
            CountDown := @CountDown - 1
            {Meetings C O}
         else
            Done = true   % exit without cleaning up
         end
      end

      fun {Notify Me}
         Other
      in 
         {Port.send CreaturePort Me}
         {Port.send OtherPort Other} 
         Other 
      end

   in
      thread {Meetings CreatureList OtherList} end
      rendezvous(notify: Notify)
   end



   class Creature
      attr name colour selfMet:0 creaturesMet:0 rendezvous

      meth init(Name Colour Rendezvous) 
         name := Name
         colour := Colour
         rendezvous := Rendezvous

         if Name \= 0 then 
            thread {self meetOthers} end 
         end
      end 
      
      meth meetOthers()
         Name Colour      
      in
         Name # Colour = {@rendezvous.notify @name # @colour}
         colour := {self complementColour(Colour $)}
         if Name == @name then selfMet := @selfMet + 1 end
         creaturesMet := @creaturesMet + 1
         {self meetOthers}
      end

      meth colour($) @colour end   

      meth selfMet($) @selfMet end    

      meth creaturesMet($) @creaturesMet end    

      meth complementColour(OtherColour $)
         if @colour == OtherColour then 
            OtherColour
         else
            case @colour
            of blue then if OtherColour == red then yellow else red end
            [] red then if OtherColour == blue then yellow else blue end
            [] yellow then if OtherColour == blue then red else blue end
            end
         end
      end
   end   % Creature



   fun {MakeCreatures ColourList}
      Done
      Rendezvous = {RendezvousServer Done N}

      C = {List.mapInd ColourList 
         fun{$ I C} {New Creature init(I C Rendezvous)} end}
   in
      {Wait Done}
      C
   end


   proc {TestColourChanges}
      ColourList = [blue red yellow]
      TestCreatures = {Map ColourList fun{$ C} {New Creature init(0 C nil)} end}   
   in
      {ForAll TestCreatures 
         proc {$ C} {
            ForAll ColourList 
               proc {$ X} { 
                  System.showInfo 
                     {C colour($)} # " + " # X # " -> " #
                        {C complementColour(X $)}
               } end
         } end
      }
      {System.showInfo ""}
   end


   proc {ReportRendezvouses ColourList}
      TestCreatures Sum
   in
      {System.showInfo
         {Flatten 
            {Map ColourList fun {$ C} [{AtomToString C} " "] end }
         }}

      TestCreatures = {MakeCreatures ColourList}

      Sum = {FoldL TestCreatures 
            fun{$ Count C} {C creaturesMet($)} + Count end 0}

      {System.show Sum}

      {ForAll TestCreatures 
         proc {$ C} {
             System.show {C creaturesMet($)}
         } end
      }

      {System.showInfo
         {Flatten 
            {Map TestCreatures fun {$ C} 
               if {C selfMet($)} == 0 then ["zero" " "] else ["ERROR" " "] end end }
         }}

      {System.showInfo ""}
   end

 
   [Arg] = {Application.getArgs plain}
   N = {String.toInt Arg}
in  
   {TestColourChanges}
   {ReportRendezvouses [blue red yellow]}
   {ReportRendezvouses [blue red yellow red yellow blue red yellow red blue]}

   {Application.exit 0}   % exit without cleaning up
end
