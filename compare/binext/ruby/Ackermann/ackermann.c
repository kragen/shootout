#include <ruby.h>

/* recursive implementation of Ackermann's function */
static int
ack(int m, int n) {
	if (m == 0)
		return (n + 1);
	if (n == 0)
		return (ack(m - 1, 1));
	return (ack(m - 1, ack(m, n - 1)));
}

/* Ruby glue function to call Ackermann's function */
static VALUE
Ackermann_ack(VALUE obj, VALUE m, VALUE n) {

	return (INT2NUM(ack(NUM2INT(m), NUM2INT(n))));
}

/* create a module init function */
void
Init_ackermann(void) {
	VALUE Ackermann;

	/* create the new module */
	Ackermann = rb_define_module("Ackermann");
	/* add the module function (singleton method) Ackermann.ack */
	rb_define_module_function(Ackermann, "ack", Ackermann_ack, 2);
}
