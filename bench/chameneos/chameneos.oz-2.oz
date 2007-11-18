% The Computer Language Shootout                              
% http://shootout.alioth.debian.org/    
% contributed by Isaac Gouy

functor
import Application System 

define
   fun {NewMeetingPlace}
      ColourList
      ColourPort = {Port.new ColourList}
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

      fun {OtherColour Me}
         Other
      in 
         {Port.send ColourPort Me}
         {Port.send OtherPort Other} 
         Other 
      end

   in
      thread {Meetings ColourList OtherList} end
      place(otherCreaturesColour: OtherColour)
   end



   class Creature
      attr creaturesMet:0 colour

      meth init(Colour) 
         colour := Colour
         thread {self meetCreatures} end 
      end 
      
      meth meetCreatures()
         Other = {MeetingPlace.otherCreaturesColour @colour}
      in
         % We might be Done before Other has a value
         if Other \= faded then  
            creaturesMet := @creaturesMet + 1
            colour := {self complement(Other $)}
            {self meetCreatures}
         end
      end

      meth creaturesMet($) @creaturesMet end    

      meth complement(Other $)
         if @colour == Other then 
            Other
         else
            case @colour
            of blue then if Other == red then yellow else red end
            [] red then if Other == blue then yellow else blue end
            [] yellow then if Other == blue then red else blue end
            end
         end
      end
   end   % Creature


 
   [Arg] = {Application.getArgs plain}
   N = {String.toInt Arg}
 
   MeetingPlace = {NewMeetingPlace}
   Colours = [blue red yellow blue]
   Creatures = {Map Colours fun{$ C} {New Creature init(C)} end}
   Done
in  
   {Wait Done}

   {System.show
      {FoldL 
         Creatures 
         fun{$ Count C} {C creaturesMet($)} + Count end 
         0} }

   {Application.exit 0}   % exit without cleaning up
end
