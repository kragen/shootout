-- $Id: matrix.lua,v 1.1 2004-05-19 18:10:34 bfulgham Exp $
-- http://www.bagley.org/~doug/shootout/
-- with help from Roberto Ierusalimschy

local n = tonumber((arg and arg[1]) or 1)

local size = 30

function mkmatrix(rows, cols)
    local count = 1
    local mx = {}
    for i=0,(rows - 1) do
	local row = {}
	for j=0,(cols - 1) do
	    row[j] = count
	    count = count + 1
	end
	mx[i] = row
    end
    return(mx)
end

function mmult(rows, cols, m1, m2)
    local m3 = {}
    for i=0,(rows-1) do
        m3[i] = {}
        local m1_i = m1[i]              -- "cache" m1[i]
        for j=0,(cols-1) do
            local rowj = 0
            for k=0,(cols-1) do
                rowj = rowj + m1_i[k] * m2[k][j]
            end
            m3[i][j] = rowj
        end
    end
    return(m3)
end

local m1 = mkmatrix(size, size)
local m2 = mkmatrix(size, size)
for i=1,n do
    mm = mmult(size, size, m1, m2)
end
io.write(format("%d %d %d %d\n", mm[0][0], mm[2][3], mm[3][2], mm[4][4]))
