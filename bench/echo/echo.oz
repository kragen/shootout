%%% $Id: echo.oz,v 1.4 2005-05-13 16:24:17 igouy-guest Exp $
%%% http://dada.perl.it/shootout/
%%% 
%%% contributed by Isaac Gouy

%%  Usage: start from command line with
%%     ozc -x echo.oz -o echo.oz.exe
%%     echo.oz.exe 100000 

functor
import
   System
   Application
   Open
   OS

define
   Data = "Hello there sailor\n"

proc {ServerThread Sock SPort Bytes}
   Sock = {New Open.socket server(port:SPort)}
   {ServerLoop Sock 0 Bytes}
   {Sock shutDown(how: [receive send])}{Sock close}
end

proc {ServerLoop Sock Sum Bytes}
   local Message NewSum DR DW CR ST in

      %% low-level Selects seem ~6% faster total
      {Sock getDesc(DR DW)}{OS.readSelect DR}
      {OS.read DR 1024 Message nil CR}      
      %% {Sock read(list: Message)} %% normal read
      
      if Message == nil then %% connection has been closed
         Bytes = Sum
      else
         NewSum = {Length Message} + Sum

         {OS.writeSelect DW}{OS.write DW Message ST}
         %% {Sock write(vs: Message)} %% normal write
      
         {ServerLoop Sock NewSum Bytes}
      end
   end
end


proc {ClientThread SPort N}
   local Sock in 
      Sock = {New Open.socket client(port:SPort)}
      {ClientLoop Sock N}
      {Sock shutDown(how: [receive send])}{Sock close}
   end
end

proc {ClientLoop Sock N}
   local Message DR DW CR ST in
      if N > 0 then

         {Sock getDesc(DR DW)}
         {OS.writeSelect DW}{OS.write DW Data ST}     
             {OS.readSelect DR}{OS.read DR 1024 Message nil CR}
     
         %% {Sock write(vs: Data)}     %% normal write
             %% {Sock read(list: Message)} %% normal read

         if Message == Data then {ClientLoop Sock N-1} end
      end
   end
end

in
   local Args A1 A2 A3 Socket SPort Bytes ArgList Pid in
      Args = {Application.getArgs plain}

      if {Length Args} == 1 then
         %% We are the server process      

         A3|nil = Args

         thread {ServerThread Socket SPort Bytes} end

         %% Prepare to fork an OS process for the client 
         %%    automatically close cmd.exe
         %%    start echo.oz.exe
         %%    pass a flag indicating the client process
         %%    pass the open server port SPort 
         %%    pass the number of times the client should send the data

         ArgList = ["/C" "echo.oz" "client" {IntToString SPort} A3]
         Pid = {New Open.pipe init(cmd: "/bin/sh" args: ArgList)}

         %% Synchronize with server thread completion and indirectly with
         %% the client process. Wait here until the dataflow variable Bytes 
         %% has been given a value in the server thread. That happens after
         %% the client process closes the socket connection, when the client
         %% process has sent all it's data and received all the replies.
 
         {System.showInfo 'server processed '#{IntToString Bytes}#' bytes'} 

      elseif {Length Args} == 3 then 
         %% We are the client process

         %% Take the flag, server port, times-to-repeat from the args
         %% and use the main thread for the client
         A1|A2|A3|nil = Args
         if A1 == "client" then
            {ClientThread {StringToInt A2} {StringToInt A3}}
         end  
      end
   end
   {Application.exit 0}
end
