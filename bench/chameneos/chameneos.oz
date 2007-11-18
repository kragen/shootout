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
         else
            O1 = faded
            O2 = faded
         end
         {Meetings C O}
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

   MeetingPlace = {NewMeetingPlace}


   class Creature
      attr creaturesMet:0 colour

      meth init(Colour) colour := Colour end 
      meth creaturesMet($) @creaturesMet end    

      meth be(Done Marker)
         thread {self meet} Done=Marker end
      end

      meth meet()
         Other = {MeetingPlace.otherCreaturesColour @colour}
      in
         if Other \= faded then
            creaturesMet := @creaturesMet + 1
            colour := {self complement(Other $)}
            {self meet}
         end
      end

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
 
   Colours = [blue red yellow blue]
   Creatures = {Map Colours fun{$ C} {New Creature init(C)} end}

   proc {WaitForMeetingsToEnd Creatures Marker}
      if Creatures \= nil then
         C|Cs = Creatures
         Done
      in
         {C be(Done Marker)}         
         {WaitForMeetingsToEnd Cs Done}
      end
      {Wait Marker}
   end


in  
   {WaitForMeetingsToEnd Creatures unit}

   {System.show
      {FoldL 
         Creatures 
         fun{$ Count C} {C creaturesMet($)} + Count end 
         0} }

   {Application.exit 0}   
end
