variable Toggle = struct { state, value, activate };

define toggle_value (this) 
{
   return this.state;
}

define toggle_activate (this)
{
   this.state = not this.state;
   return this;
}

define init_Toggle (this, start_state) 
{
   this.state = start_state;
   this.value = &toggle_value;
   this.activate = &toggle_activate;
   return this;
}
define new_Toggle (start_state) 
{
   return init_Toggle (@Toggle, start_state);
}

define NthToggle_activate (this)
{
   variable counter = this.counter;
   counter++;
   if (this.count_max <= counter)
     {
	this.state = not (this.state);
	counter = 0;
    }
   this.counter = counter;
   return this;
}

define init_NthToggle (this, max_count) 
{
   this.count_max = max_count;
   this.counter = 0;
   this.activate = &NthToggle_activate;
   return this;
}

define new_NthToggle (start_state, max_count) 
{
   variable this = @Struct_Type 
     ([get_struct_field_names(Toggle), "count_max", "counter"]);
   this = init_Toggle(this, start_state);
   return init_NthToggle(this, max_count);
}

define do_toggle (tog, n)
{
   variable val;
   loop (n)
     val = @((@tog.activate)(tog).value)(tog);
   if (val)
     fprintf (stdout, "true\n");
   else
     fprintf (stdout, "false\n");
}

define main ()
{
   variable n = 1;
   if (__argc == 2) n = integer (__argv[1]);

   do_toggle (new_Toggle (1), n);
   do_toggle (new_NthToggle (1, 3), n);
}
main();
