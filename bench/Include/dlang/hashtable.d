/* The Computer Language Shootout
   http://shootout.alioth.debian.org/

   Converted to D by Dave Fladebo
*/

module hashtable;

private import std.c.string;
debug(1) private import std.c.stdio;

class HashTable(T)
{
    private const size_t[] ht_prime_list = [
    53,         97,         193,       389,       769,
    1543,       3079,       6151,      12289,     24593,
    49157,      98317,      196613,    393241,    786433,
    1572869,    3145739,    6291469,   12582917,  25165843,
    50331653,   100663319,  201326611, 402653189, 805306457, 
    1610612741, 3221225473, 4294967291 ];

    class HashTableNode
    {
        HashTableNode next;
        char[] key;
        T value;

        this(char[] key)
        {
            this.key = key;
            this.value = 0;
            this.next = null;
        }
    }

    private HashTableNode[] tbl;
    private size_t iterIndex, items;
    private HashTableNode iterNext;

    debug(1)
    {
    private size_t collisions;
    }

    private size_t hashCode(char[] key)
    {
        size_t val = 0;
        foreach(char c; key) val = 5 * val + c;
        return val % tbl.length;
    }

public:
    this(size_t size = 0)
    {
        size_t i = 0;
        while(ht_prime_list[i] < size) { i++; }
        tbl = new HashTableNode[](ht_prime_list[i]);
        iterIndex = 0;
        iterNext = null;
        items = 0;
        debug(1)
        {
        collisions = 0;
        }
    }

    this(size_t keyLen, size_t bufLen)
    {
        size_t maxsize1 = bufLen - keyLen, maxsize2 = 4;

        while(keyLen > 1 && maxsize2 < maxsize1)
        {
            maxsize2 = maxsize2 * 8;
            keyLen--;
        }

        this(maxsize1 < maxsize2 ? maxsize1 : maxsize2);
    }

    ~this()
    {
        debug(1)
        {
        size_t chain_len = 0, max_chain_len = 0, density = 0;
        fprintf(stderr, " HT: size            %d\n", tbl.length);
        fprintf(stderr, " HT: items           %d\n", items);
        fprintf(stderr, " HT: collisions      %d\n", collisions);
        for(size_t i = 0; i < tbl.length; i++)
        {
	    HashTableNode next = tbl[i];
	    if(next)
	        density++;
	    chain_len = 0;
	    while(next)
            {
	        next = next.next;
	        chain_len++;
	    }
	    if(chain_len > max_chain_len)
	        max_chain_len = chain_len;
        }
        fprintf(stderr, " HT: density         %d\n", density);
        fprintf(stderr, " HT: max chain len   %d\n", max_chain_len);
        }
    }

    HashTableNode find(char[] key)
    {
        HashTableNode node = tbl[hashCode(key)];
        while(node)
        {
	    if(key == node.key) return node;
	    node = node.next;
        }
        return null;
    }

    HashTableNode findNew(char[] key)
    {
	size_t hc = hashCode(key);
        HashTableNode prev = null, node = tbl[hc];
        while(node)
        {
            if(key == node.key) return node;
	    prev = node;
	    node = node.next;
            debug(1)
            {
	    collisions++;
            }
        }
        items++;
        if(prev)
	    return prev.next = new HashTableNode(key);
        else
	    return tbl[hc] = new HashTableNode(key);
    }

    /*
     *  Hash Table iterator data/functions
     */
    HashTableNode next()
    {
        HashTableNode node = iterNext;
        if(node)
        {
	    iterNext = node.next;
	    return node;
        }
        else
        {
	    while(iterIndex < tbl.length)
            {
	        size_t index = iterIndex++;
	        if(tbl[index])
                {
		    iterNext = tbl[index].next;
		    return tbl[index];
	        }
	    }
        }
        return null;
    }

    HashTableNode first()
    {
        iterIndex = 0;
        iterNext = null;
        return next;
    }

    size_t count()
    {
        return items;
    }
}
