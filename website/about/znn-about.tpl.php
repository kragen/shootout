<?=$Version;?>
<p>Home Page: <a href="http://www.zonnon.ethz.ch/">zonnon programming language & compiler</a></p>
<p>Download: <a href="http://www.zonnon.ethz.ch/compiler/download.html">compiler for Mono/Rotor (Eclipse plugin)</a></p>

<pre>
module BenchmarksGame;
import System;

procedure {public} argi(): integer;
var 
   objArray : System.Array;
   obj : System.Object;
begin
   objArray := System.Environment.GetCommandLineArgs();
   obj := objArray.GetValue(1);
   return integer(System.Int32.Parse(obj.ToString()));
end argi;


procedure {public} writex(x:real); 
begin
   System.Console.Write("{0:f9}",x); 
end writex;

end BenchmarksGame.
</pre>
