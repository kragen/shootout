-- -*- mode: eiffel -*-
-- $Id: toggle.e,v 1.1 2004-05-19 18:09:09 bfulgham Exp $
-- http://www.bagley.org/~doug/shootout/
-- from Steve Thompson

class TOGGLE

creation make

feature -- Creation

   make(start_state: BOOLEAN) is
      do
	 state := start_state
      end
   
feature -- Queries
   
   state: BOOLEAN
   
   value: BOOLEAN is
      do
	 Result := state
      end -- value
   
   activate: like Current is
      do
	 state := state = False
	 Result := Current
      end -- activate
   
end -- class TOGGLE
