# Before `make install' is performed this script should be runnable with
# `make test'. After `make install' it should work as `perl test.pl'

######################### We start with some black magic to print on failure.

# Change 1..1 below to 1..last_test_to_print .
# (It may become useful if the test is moved to ./t subdirectory.)

BEGIN { $| = 1; print "1..2\n"; }
END {print "not ok 1\n" unless $loaded;}
use Ackermann qw(Ack);
$loaded = 1;
print "ok 1\n";

######################### End of black magic.

# test for our Ackermann function:
# the value of Ack(3,8) should be 2045
if (Ack(3,8)==2045) {
    print "ok 2\n";
} else {
    print "not ok 2\n";
}
