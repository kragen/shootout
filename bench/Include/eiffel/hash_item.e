--	AUTHOR:	Jacques Bouchard <bouchard@mageos.com>
--      http://mageos.ifrance.com/bouchard/

class HASH_ITEM[V, K->HASHABLE]
   --
   -- Item of a HASH_MAP[V, K->HASHABLE]
   --

creation {HASH_MAP} make

feature -- Accessing

   value: V
         -- Item value

   key: K
         -- Item key

feature {HASH_MAP}

   next: like Current

feature -- Writing

   set_value(v: like value) is
         -- Set element value
      do
         value := v
      ensure
         value  = v
      end

feature {HASH_MAP}

   set_key(k: like key) is
      do
         key := k
      ensure
         key  = k
      end

   set_next(n: like next) is
      do
         next := n
      ensure
         next  = n
      end

feature {HASH_MAP}

   make(v: like value; k: like key; n: like next) is
      do
         value := v
         key  := k
         next := n
      ensure
         value  = v
         key   = k
         next  = n
      end

end --  HASH_ITEM[V, K->HASHABLE]
