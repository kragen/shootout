-- $Id: moments.lua,v 1.1 2004-05-19 18:10:47 bfulgham Exp $
-- http://www.bagley.org/~doug/shootout/
-- implemented by: Roberto Ierusalimschy

local nums = {}
local n = 0
local sum = 0
while 1 do
  local line = read()
  if line == nil then break end
  line = line+0        -- convert line to number
  sum = sum + line
  n = n + 1
  nums[n] = line
end

local mean = sum/n

local average_deviation, variance, skew, kurtosis = 0, 0, 0, 0

for i = 1, n do
  local deviation = nums[i] - mean
  average_deviation = average_deviation + abs(deviation)
  variance = variance + deviation^2
  skew = skew + deviation^3
  kurtosis = kurtosis + deviation^4
end

average_deviation = average_deviation/n
variance = variance/(n-1)
local standard_deviation = sqrt(variance)
if variance ~= 0 then
  skew = skew / (n * variance * standard_deviation)
  kurtosis = kurtosis/(n * variance * variance) - 3.0
end

sort(nums)
local mid = floor(n/2)
local median
if mod(n,2) == 1 then
  median = nums[mid+1]
else
  median = (nums[mid] + nums[mid+1])/2
end

io.write(format("n:                  %d\n", n))
io.write(format("median:             %f\n", median))
io.write(format("mean:               %f\n", mean))
io.write(format("average_deviation:  %f\n", average_deviation))
io.write(format("standard_deviation: %f\n", standard_deviation))
io.write(format("variance:           %f\n", variance))
io.write(format("skew:               %f\n", skew))
io.write(format("kurtosis:           %f\n", kurtosis))
