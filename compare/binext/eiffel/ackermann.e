-- -*- mode: eiffel -*-
-- $Id: ackermann.e,v 1.1 2004-05-19 18:14:32 bfulgham Exp $

class ACKERMANN

creation make

feature

   make is

      do
         std_output.put_string("Ack(3,8) is ");
         std_output.put_integer(Ack(3,8));
         std_output.put_new_line;
      end;

feature {NONE}

   Ack(m: INTEGER; n: INTEGER): INTEGER is
      external "C"
      end;

end -- ACKERMANN
