define new_list (n)
{
   variable l = struct
     {
	root, tail, data, len
     };
   l.data = [1:n];
   l.root = 0;
   l.tail = n;
   l.len = n;
   return l;
}

define expand_list (l, len)
{
   len += 4096;
   variable data = Int_Type[len];
   variable root = l.root;
   variable tail = l.tail;
   variable n = (tail - root);
   if (n)
     data[[0:n-1]] = l.data[[root:tail-1]];
   l.data = data;
   l.root = 0;
   l.tail = n;
   l.len = len;
}

define list_append (l, value)
{
   variable tail = l.tail;

   if (l.tail == l.len)
     {
	expand_list (l, l.len + 1);
	tail = l.tail;
     }

   l.data[tail] = value;
   tail++;
   l.tail = tail;
}

define list_pop_right (l)
{
   variable tail = l.tail;
   if (tail == l.root)
     return NULL;
   tail--;
   l.tail = tail;
   return l.data[tail];
}

define list_pop_left (l)
{
   variable root = l.root;
   if (l.tail == root)
     return NULL;
   l.root = root+1;
   return l.data[root];
}

define list_length (l)
{
   return l.tail - l.root;
}

define reverse_list (l)
{
   variable tail = l.tail;
   variable root = l.root;
   if (tail == root)
     return;

   tail--;
   l.data[[root:tail]] = l.data[[tail:root:-1]];
}

define dup_list (l)
{
   variable new_l = @l;
   new_l.data = @l.data;
   return new_l;
}

define list_to_array (a)
{
   variable tail, root;
   tail = a.tail;
   root = a.root;
   if (root == tail)
     return NULL;
   tail--;
   return a.data[[root:tail]];
}

define check_eqs (a, b)
{
   if (list_length (a) != list_length (b))
     return 0;
   variable data_a = list_to_array (a);
   variable data_b = list_to_array (b);
   if (data_a == NULL)
     return 1;			       %  same length, but empty
   
   return not length (where (data_a != data_b));
}

variable SIZE = 10000;	
define test_lists ()
{
   variable L1 = new_list (SIZE);
   variable L2 = dup_list (L1);
   variable L3 = new_list (0);
   
   forever 
     {
	variable node = list_pop_left (L2);
	if (node == NULL)
	  break;

	list_append (L3, node);
     }

   forever 
     {
	node = list_pop_right (L3);
	if (node == NULL)
	  break;
	
	list_append (L2, node);
     }
   reverse_list (L1);

   if (L1.data[L1.root] != SIZE)
     return -1;

   if (0 == check_eqs (L1, L2))
     return -2;
   
   return list_length (L1);
}

    
define main ()
{
   variable num = 1;
   if (__argc > 1) num = integer (__argv[1]);
   loop (num)
     num = test_lists ();
   
   fprintf (stdout, "%d\n", num);
}

main ();
   
