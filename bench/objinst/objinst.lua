-- $Id: objinst.lua,v 1.1 2004-05-19 18:11:03 bfulgham Exp $
-- http://www.bagley.org/~doug/shootout/
-- with help from Roberto Ierusalimschy

-- set up a simple object inheritance
settagmethod(tag{}, "index", function (object, field)
    if field ~= "parent" then
        local p = object.parent
        return p and p[field]
    end
end)


--------------------------------------------------------------
-- Toggle module
--------------------------------------------------------------

function new_Toggle(start_state)
    return {
	bool = start_state,
	value = function (self)
	    return self.bool
	end,
	activate = function(self)
	    self.bool = not self.bool
	    return self
	end,
    }
end

--------------------------------------------------------------
-- NthToggle module
--------------------------------------------------------------

function new_NthToggle(start_state, max_counter)
    return {
	parent = new_Toggle(start_state),
	count_max = max_counter,
	counter = 0,
	activate = function (self)
	    self.counter = self.counter + 1
	    if self.counter >= self.count_max then
		self.parent:activate()
		self.counter = 0
	    end
	    return self
	end
    }
end

-----------------------------------------------------------
-- main
-----------------------------------------------------------

function main ()
    local N = tonumber((arg and arg[1])) or 1
    local toggle = new_Toggle(1)
    for i=1,5 do
	toggle:activate()
	if toggle:value() then io.write("true\n") else io.write("false\n") end
    end
    for i=1,N do
	toggle = new_Toggle(1)
    end

    io.write("\n")

    local ntoggle = new_NthToggle(1, 3)
    for i=1,8 do
	ntoggle:activate()
	if ntoggle:value() then io.write("true\n") else io.write("false\n") end
    end
    for i=1,N do
	ntoggle = new_NthToggle(1, 3)
    end
end

main()
