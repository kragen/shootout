-- $Id: wc.lua,v 1.1 2004-05-19 18:13:52 bfulgham Exp $
-- http://www.bagley.org/~doug/shootout/
-- from Roberto Ierusalimschy

BUFSIZE = 2^12

local cc,lc,wc = 0,0,0
while 1 do
    local lines, rest = io.read(BUFSIZE, "*l")
    if lines == nil then break end
    if rest then lines = lines..rest..'\n' end
    cc = cc+string.len(lines)
    local _,t = string.gsub(lines, "%S+", "")   -- count words in the line
    wc = wc+t
    _,t = string.gsub(lines, "\n", "\n")   -- count newlines in the line
    lc = lc+t
end

io.write(lc, " ", wc, " ", cc, "\n")
