-- -*- mode: eiffel -*-
-- $Id: nth_toggle.e,v 1.1 2004-05-19 18:09:07 bfulgham Exp $
-- http://www.bagley.org/~doug/shootout/
-- from Steve Thompson

class NTH_TOGGLE
inherit TOGGLE
      rename make as parent_make
      redefine activate
      end
   
creation make
   
feature -- Creation
   
   make(start_state: BOOLEAN; max_counter: INTEGER) is
      do
	 parent_make(start_state)
	 count_max := max_counter
	 counter := 0
      end -- make
   
feature -- Queries
   
   count_max: INTEGER
   counter: INTEGER
   
	activate: like Current is
      do
	 counter := counter + 1
	 if Current.counter >= Current.count_max then
	    state := state = False
	    counter := 0
	 end
	 Result := Current
      end -- activate
   
end -- class NTH_TOGGLE

