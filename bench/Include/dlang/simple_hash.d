module simple_hash;

// simple hashtable map: Cstring ==> Int
// adapted from simple_hash.h v1.4 by bearophile

import std.gc: malloc, realloc;
import std.c.stdio: perror, stderr, fprintf;
import std.c.string: memcmp, memset, strcmp;
import std.c.stdlib: exit;
extern(C) char* strdup(char*);


const HT_NUM_PRIMES = 28;

ulong ht_prime_list[HT_NUM_PRIMES] = [
    53UL,         97UL,         193UL,       389UL,       769UL,
    1543UL,       3079UL,       6151UL,      12289UL,     24593UL,
    49157UL,      98317UL,      196613UL,    393241UL,    786433UL,
    1572869UL,    3145739UL,    6291469UL,   12582917UL,  25165843UL,
    50331653UL,   100663319UL,  201326611UL, 402653189UL, 805306457UL,
    1610612741UL, 3221225473UL, 4294967291UL];


struct ht_node {
    char* key;
    int val;
    ht_node* next;
}


struct ht_ht {
    int size;
    ht_node** tbl;
    int iter_index;
    ht_node* iter_next;
    int nitems;

    debug {
        int collisions;
    }
}


int ht_val(ht_node* node) {
    return node.val;
}


char* ht_key(ht_node* node) {
    return node.key;
}


int ht_hashcode(ht_ht* ht, char* key) {
    ulong val = 0;

    for (; *key; ++key)
        val = 5 * val + *key;
    return val % ht.size;
}


ht_node* ht_node_create(char* key) {
    char* newkey;

    ht_node* node = cast(ht_node*)malloc(ht_node.sizeof);
    if (node is null) {
        perror("malloc ht_node");
        exit(1);
    }

    newkey = cast(char*)strdup(key);
    if (newkey is null) {
        perror("strdup newkey");
        exit(1);
    }

    node.key = newkey;
    node.val = 0;
    node.next = null;
    return node;
}


ht_ht* ht_create(int size) {
    int i = 0;
    ht_ht* ht = cast(ht_ht*)malloc(ht_ht.sizeof);
    if (ht is null) {
        perror("malloc ht_ht");
        exit(1);
    }

    while (ht_prime_list[i] < size)
        i++;

    ht.size = ht_prime_list[i];

    /*
    ht.tbl = (ht_node**)calloc(ht.size, sizeof(ht_node*));
    if (ht.tbl is null) {
        perror("malloc ht.tbl");
        exit(1);
    }
    */
    ht_node** ht_node_aux = cast(ht_node**)malloc(ht.size * (ht_node*).sizeof);
    if (ht_node_aux is null) {
        perror("ht_node_aux");
        exit(1);
    }
    memset(ht_node_aux, 0, ht.size * (ht_node*).sizeof);
    ht.tbl = ht_node_aux;

    ht.iter_index = 0;
    ht.iter_next = null;
    ht.nitems = 0;

    debug {
        ht.collisions = 0;
    }

    return ht;
}


void ht_destroy(ht_ht *ht) {
    ht_node* cur;
    ht_node* next;
    int i;

    debug {
        int chain_len;
        int max_chain_len = 0;
        int density = 0;
        fprintf(stderr, " HT: size            %d\n", ht.size);
        fprintf(stderr, " HT: nitems           %d\n", ht.nitems);
        fprintf(stderr, " HT: collisions      %d\n", ht.collisions);
    }

    for (i = 0; i < ht.size; i++) {
        next = ht.tbl[i];

        debug {
            if (next)
                density++;
            chain_len = 0;
        }

        while (next) {
            cur = next;
            next = next.next;
            realloc(cur.key, 0);
            realloc(cur, 0);

            debug {
                chain_len++;
            }
        }

        debug {
            if (chain_len > max_chain_len)
                max_chain_len = chain_len;
        }
    }
    realloc(ht.tbl, 0);
    realloc(ht, 0);

    debug {
        fprintf(stderr, " HT: density         %d\n", density);
        fprintf(stderr, " HT: max chain len   %d\n", max_chain_len);
    }
}


ht_node* ht_find(ht_ht* ht, char* key) {
    int hash_code = ht_hashcode(ht, key);
    ht_node* node = ht.tbl[hash_code];

    while (node) {
        if (strcmp(key, node.key) == 0)
            return node;
        node = node.next;
    }
    return null;
}


ht_node* ht_find_new(ht_ht* ht, char* key) {
    int hash_code = ht_hashcode(ht, key);
    ht_node* prev = null;
    ht_node* node = ht.tbl[hash_code];

    while (node) {
        if (strcmp(key, node.key) == 0)
            return node;
        prev = node;
        node = node.next;

        debug {
            ht.collisions++;
        }
    }

    ht.nitems++;
    if (prev) {
        prev.next = ht_node_create(key);
        return prev.next;
    } else {
        ht.tbl[hash_code] = ht_node_create(key);
        return ht.tbl[hash_code];
    }
}


/// Hash Table iterator data/functions
ht_node* ht_next(ht_ht* ht) {
    ulong index;

    ht_node* node = ht.iter_next;
    if (node) {
        ht.iter_next = node.next;
        return node;
    } else {
        while (ht.iter_index < ht.size) {
            index = ht.iter_index++;
            if (ht.tbl[index]) {
                ht.iter_next = ht.tbl[index].next;
                return ht.tbl[index];
            }
        }
    }
    return null;
}


ht_node* ht_first(ht_ht* ht) {
    ht.iter_index = 0;
    ht.iter_next = null;
    return ht_next(ht);
}


int ht_len(ht_ht* ht) {
    return ht.nitems;
}