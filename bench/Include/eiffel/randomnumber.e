-- -*- mode: eiffel -*-
-- $Id: randomnumber.e,v 1.1 2004-08-02 08:06:45 bfulgham Exp $
-- http://shootout.alioth.debian.org/
-- from Steve Thompson

class RANDOMNUMBER
   
creation make
   
feature -- Creation
   
   make is
      do
	 last := 42
      end -- make
   
feature -- Queries
   
   IM: INTEGER is 139968
   
   IA: INTEGER is 3877
   
   IC: INTEGER is 29573
   
   last: INTEGER
   
   next(max: DOUBLE): DOUBLE is
      do
	 last := (last * IA + IC) \\ IM
	 Result := max * last / IM
      end -- next
   
end
