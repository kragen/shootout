-- $Id: methcall.lua,v 1.1 2004-05-19 18:10:41 bfulgham Exp $
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

    local val = 1
    local toggle = new_Toggle(val)
    for i=1,N do
	val = toggle:activate():value()
    end
    if toggle:value() then io.write("true\n") else io.write("false\n") end
    
    val = 1
    local ntoggle = new_NthToggle(val, 3)
    for i=1,N do
	val = ntoggle:activate():value()
    end
    if ntoggle:value() then io.write("true\n") else io.write("false\n") end
end

main()
