--      AUTHOR: Jacques Bouchard <bouchard@mageos.com>
--      http://mageos.ifrance.com/bouchard/

class HASH_MAP[V, K->HASHABLE]
   --
   -- Associative memory (hash table implementation)
   -- Values of type `V' are stored using keys of type `K'
   --
   
creation make, with_capacity
   
feature {NONE} -- Internal storage management
   
   buckets: FIXED_ARRAY[HASH_ITEM[V, K]]
	 -- Internal storage
   
   new(capacity: INTEGER) is
	 -- Create an empty hash map in which `capacity' items
	 -- may be inserted without resizing the internal storage
      do
	 !!buckets.make(buckets_opt_size(capacity))
      ensure
	 buckets.lower = 0
	 buckets.count > 0
	 count = 0
      end
   
   hash_code(s: STRING): INTEGER is
      local
         i: INTEGER
      do
         from i := 1
	 until i > s.count 
	 loop
            Result := 5 * Result + (s @ i).code
            i := i + 1
         end
         if Result < 0 then
            Result := -(Result + 1)
         end
      end

   resize(capacity: INTEGER) is
	 -- Resize the hash map so that it may contain `capacity' items
      local
	 size, new_size: INTEGER
	 index, new_index: INTEGER
	 first, next: HASH_ITEM[V, K]
	 new_buckets: like buckets
      do
	 size := buckets.count
	 if capacity > size then
	    new_size := buckets_opt_size(capacity)
	    if new_size > size then
	       !!new_buckets.make(new_size)
	       from
		  index := 0
	       until
		  index >= size
	       loop
		  from
		     first := buckets.item(index)
		  until
		     first = Void
		  loop
		     new_index := hash_code(first.key) \\ new_size
		     next := first.next
		     first.set_next(new_buckets.item(new_index))
		     new_buckets.put(first, new_index)
		     first := next
		  end
		  index := index + 1
	       end
	       buckets := new_buckets
	    end
	 end
      ensure
	 buckets.lower = 0
	 buckets.count >= old buckets.count
	 count = old count
      end

   buckets_opt_size(capacity: INTEGER): INTEGER is
	 -- Return the optimal size of `buckets' array
	 -- for storing `capacity' items in the hash map
      local
	 index: INTEGER
      do
	 index := lower_bound(prime_list, capacity)
	 if index < prime_list.lower then
	    Result := prime_list.first
	 else
	    Result := prime_list.item(index)
	 end
      ensure
	 Result > 0
      end

   lower_bound(array: ARRAY[INTEGER]; item: INTEGER): INTEGER is
	 -- Returns the highest index i for which array.item(i) <= item
	 -- or array.lower - 1 if array.first > item
      require
	 array.count > 0
	 sorter.is_sorted(array)
      local
	 min_index, max_index, index: INTEGER
      do
	 from
	    min_index := array.lower
	    max_index := array.upper
	 until
	    max_index - min_index < 0
	 loop
	    index := (min_index + max_index) // 2
	    if array.item(index) <= item then
	       min_index := index + 1
	    else
	       max_index := index - 1
	    end
	 end
	 Result := min_index - 1
      ensure
	 Result >= array.lower implies array.item(Result)   <= item
	 Result <  array.upper implies array.item(Result+1) >  item
      end

   prime_list: ARRAY[INTEGER] is
	 -- Used by buckets_opt_size
      once
	 Result := <<       53,        97,       193,       389,       769,
			  1543,      3079,      6151,     12289,     24593,
			 49157,     98317,    196613,    393241,    786433,
		       1572869,   3145739,   6291469,  12582917,  25165843,
		      50331653, 100663319, 201326611, 402653189, 805306457,
		    1610612741 >>
      end

   sorter: COLLECTION_SORTER[INTEGER] is
      once
      end

feature -- Creation

   make is
	 -- Create an empty hash map initialized with the default capacity
      do
	 new(100)
      ensure
	 count = 0
      end

   with_capacity(capacity: INTEGER) is
	 -- Create an empty hash map in which `capacity' items
	 -- may be inserted without resizing the internal storage
      do
	 new(capacity)
      ensure
	 count = 0
      end

feature -- Counting

   count: INTEGER
	 -- number of items in the hash map

feature -- Inserting

   put (value: V; key: K) is
   do
	insert (value,key)
   end

   insert(value: V; key: K) is
	 -- Add a new item in the hash map, with key `key' and value `value'
      require
	 key /= Void
	 find(key) = Void
      local
	 index: INTEGER
	 item: HASH_ITEM[V, K]
      do
	 resize(count + 1)
	 index := hash_code(key) \\ buckets.count
	 !!item.make(value, key, buckets.item(index))
	 buckets.put(item, index)
	 count := count + 1
      ensure
	 find(key) /= Void
	 key.is_equal(find(key).key)
	 find(key).value = value
	 count = old count + 1
      end 

feature --  Removing

   remove (key: K) is
	 -- Remove the item with key `key' if it exists
      require
	 key /= Void
      local
	 index: INTEGER
	 item, prev: HASH_ITEM[V, K]
      do
	 index := hash_code(key) \\ buckets.count
	 from
	    item := buckets.item(index)
	 until
	    item = Void or else
	    key.is_equal(item.key)
	 loop
	    prev := item
	    item := item.next
	 end
	 if item /= Void then
	    if prev = Void then
	       buckets.put(item.next, index)
	    else
	       prev.set_next(item.next)
	    end
	    count := count - 1
	 end
      ensure
	 find(key) = Void
	 old find(key)  = Void implies count = old count
	 old find(key) /= Void implies count = old count - 1
      end

   clear is
	 -- Discard all items
      do
	 count := 0
	 buckets.clear_all
      ensure
	 count = 0
      end

feature -- Searching

   find(key: K): HASH_ITEM[V, K] is
	 -- Return the item with key `key' or `Void' if it doesn't exist
      require
	 key /= Void
      local
	 item: HASH_ITEM[V, K]
      do
	 from
	    item := buckets.item(hash_code(key) \\ buckets.count)
	 until
	    item = Void or else
	    key.is_equal(item.key)
	 loop
	    item := item.next
	 end
	 Result := item
      ensure
	 Result /= Void implies key.is_equal(Result.key)
	 count = old count
      end

      has (key: K) : BOOLEAN is
      require
	 key /= Void
      local
	 item: HASH_ITEM[V, K]
      do
	 from
	    item := buckets.item(hash_code(key) \\ buckets.count)
	 until
	    item = Void or else
	    key.is_equal(item.key)
	 loop
	    item := item.next
	 end

	 if item = Void then
	    Result := false
	 else
	    Result := key.is_equal(item.key)
	 end
      ensure
	--  Result implies key.is_equal(item.key)
	 count = old count
      end


feature -- Traversing

   start: HASH_ITEM[V, K] is
	 -- Return the first item or `Void' if it doesn't exist
      local
	 index, size: INTEGER
      do
	 size := buckets.count
	 from
	    index := 0
	 until
	    index >= size or else
	    buckets.item(index) /= Void
	 loop
	    index := index + 1
	 end
	 if index < size then
	    Result := buckets.item(index)
	 end
      ensure
	 count > 0 implies Result /= Void
	 count = old count
      end

   forth(item: HASH_ITEM[V, K]): like item is
	 -- Return the next item or `Void' if it doesn't exist
      require
	 item /= Void
      local
	 size, index: INTEGER
      do
	 Result := item.next
	 if Result = Void then
	    size := buckets.count
	    from
	       index := (hash_code(item.key) \\ size) + 1
	    until
	       index >= size or else
	       buckets.item(index) /= Void
	    loop
	       index := index + 1
	    end
	    if index < size then
	       Result := buckets.item(index)
	    end
	 end
      ensure
	 count = old count
      end

invariant

   count >= 0

end -- HASH_MAP[V, K->HASHABLE]
