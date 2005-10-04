#!/usr/bin/env slsh
% The Computer Language Shootout Benchmarks
% http://shootout.alioth.debian.org/
%
% contributed by John E. Davis

typedef struct { left, right, item } TreeNode_Type;

private define item_check ();
private define item_check (tree)
{
   variable left = tree.left;
   if (left == NULL)
     return tree.item;

   return tree.item + item_check(left) - item_check (tree.right);
}

private define bottomup_tree ();
private define bottomup_tree (item, depth)
{   
   variable s = @TreeNode_Type;
   !if (depth)
     {
	s.item = item;
	return s;
     }
   depth--;
   set_struct_fields (s, bottomup_tree (2 * item - 1, depth),
		      bottomup_tree (2 * item, depth), item);
   return s;
}

define slsh_main ()
{
   variable N = 1;
   if (__argc > 1) N = integer (__argv[1]);

   variable max_depth = N, min_depth = 4;

   if (min_depth + 2 > N)
     max_depth = min_depth + 2;

   variable stretch_depth = max_depth + 1;
   variable stretch_tree = bottomup_tree(0, stretch_depth);
   () = fprintf (stdout, "stretch tree of depth %u\t check: %ld\n",
		 stretch_depth, item_check (stretch_tree));
   stretch_tree = NULL;

   variable longlived_tree = bottomup_tree (0, max_depth);

   _for (min_depth, max_depth, 2)
    {
       variable depth = ();
       variable iterations = 1 shl (max_depth - depth + min_depth);
       variable check = 0;

       _for (1, iterations, 1)
	 {
	    variable i = ();
            variable tmp = bottomup_tree (i, depth);
            check += item_check (tmp);
	    tmp = NULL;
            tmp = bottomup_tree (-i, depth);
            check += item_check (tmp);
	    tmp = NULL;
        }

       () = fprintf (stdout, "%d\t trees of depth %u\t check: %d\n",
		     iterations * 2, depth, check);
    }

   () = fprintf (stdout, "long lived tree of depth %u\t check: %d\n",
		 max_depth, item_check (longlived_tree));
}
