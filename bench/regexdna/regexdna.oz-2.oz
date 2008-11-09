% ----------------------------------------------------------------------
% The Computer Language Benchmarks Game  
% http://shootout.alioth.debian.org/
%
% Contributed by Anthony Borla [with thanks to Kevin Glynn]
% Further modified by YANG Shouxun
% ----------------------------------------------------------------------

functor

import
  System(showInfo) Application(exit) Open(file text)
  Regex at 'x-oz://contrib/regex'

define

% ------------- %

  VARIANTS = [
    "agggtaaa|tttaccct" "[cgt]gggtaaa|tttaccc[acg]"
    "a[act]ggtaaa|tttacc[agt]t" "ag[act]gtaaa|tttac[agt]ct"
    "agg[act]taaa|ttta[agt]cct" "aggg[acg]aaa|ttt[cgt]ccct"
    "agggt[cgt]aa|tt[acg]accct" "agggta[cgt]a|t[acg]taccct"
    "agggtaa[cgt]|[acg]ttaccct"]

  IUBS = ["B"#"(c|g|t)" "D"#"(a|g|t)" "H"#"(a|c|t)" "K"#"(g|t)"
	  "M"#"(a|c)" "N"#"(a|c|g|t)" "R"#"(a|g)" "S"#"(c|g)"
	  "V"#"(a|c|g)" "W"#"(a|t)" "Y"#"(c|t)"]

  LF = "\n"

% ------------- %

  class TextFile_
    from Open.file Open.text
  end

% ------------- %

  Initial_Length Code_Length SEQ = {NewCell nil}

% ------------- %

in
  % Load file as a list and record its length
  SEQ := {{New TextFile_ init(name:stdin)} read(list:$ size:all)}
  Initial_Length = {Length @SEQ}

  % Remove newline and segment divider line occurrences
  SEQ := {Regex.replace @SEQ {Regex.make "(>.*\n)|(\n)"} fun {$ X Y} "" end}
  Code_Length = {ByteString.length @SEQ}

  % Perform regexp counts
  for Item in VARIANTS do
    {System.showInfo Item # " " # {Length {Regex.allMatches {Regex.compile Item [icase extended]} @SEQ}}}
  end

  % Perform replacements
  for Key#S in IUBS do
     SEQ := {Regex.replace @SEQ {Regex.compile Key [icase]} fun {$ X Y} S end}
  end

  % Print statistics
  {System.showInfo LF # Initial_Length # LF # Code_Length # LF # {ByteString.length @SEQ}}

  {Application.exit 0}
end
