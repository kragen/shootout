-- -*- mode: eiffel -*-
-- $Id: doubly_linked_list.e,v 1.1 2004-08-02 08:06:45 bfulgham Exp $
-- http://shootout.alioth.debian.org/
-- from Friedrich Dominicus

class DOUBLY_LINKED_LIST[G]


inherit
    TWO_WAY_LINKED_LIST[G]


creation
    make


feature
    element : like first_link;


    create_el_entry (elem: G): like first_link is
        do
            create Result.make(elem, Void, Void);
        end;

    print_list  is
        local
            it : ITERATOR[G]
        do
            
            from it := get_new_iterator
            until it.is_off
            loop
                io.put_string(it.item.out);
                io.put_string(" ");
                it.next;
            end;
        end;



    revert_in_place is
        local
            tmp, act_element: like last_link
            
        do
            if (count > 1) then
                -- special handling for the first change
                -- this was done to make the loop as slim as possible
                -- if that hasn't been done we had to check in each 
                -- loop whic makes a difference of at 10000 
                -- comparisons in the loop. Now we want to be fast 
                -- won't we ;-)
                act_element := first_link;
                tmp := last_link;
                first_link := tmp;
                last_link := last_link.previous;
                last_link.set_next(Void);
                tmp.set_previous (Void);
                act_element.set_previous(tmp);
                tmp.set_next(act_element);
                 
                from 
                until act_element.next = Void
                loop
                    tmp := last_link;
                    last_link := last_link.previous;
                    last_link.set_next(Void);
                    tmp.set_previous (act_element.previous);
                    tmp.set_next(act_element);
                    act_element.previous.set_next(tmp);
                    act_element.set_previous(tmp);
                end;
            end -- if (count > 1)
            last_link := act_element;
        end



    
            
    
end -- class DOUBLY_LINKED_LIST
