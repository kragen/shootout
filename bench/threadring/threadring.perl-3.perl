# The Computer Language Benchmarks Game
#   http://shootout.alioth.debian.org/
#  contributed by Peter Corlett 

# This is really more a classic fork() and Unix IPC implementation, but it
# uses threads purely to satisfy the rules of the game. This makes it quite
# nippy as it doesn't have to worry about any sort of locking because we
# essentially have 503 independent processes that just happen to share an
# address space.
#
# Almost all of the time appears to be consumed by the thread library doing
# all the deep copying required to create a clone and then tearing it down
# afterwards. A fork() implementation is thus likely to be very fast as it'd
# use copy-on-write pages in the kernel.
#
# As a minor aside, IO::Pipe wasn't used here because it expects one to fork()
# and use ->reader and ->writer in different processes to set which side of
# the pipe the IO::Pipe object will now refer to.
#
# It requires at least perl 5.10.0, although it could be easily rewritten to
# use an earlier version.

use 5.010;
use warnings;
use strict;
use threads;
use IO::Handle; # for autoflush

use constant THREADS => 503;
# stack size may need tuning for your arch, default of 8MB is likely to not
# work well on 32 bit systems or those with limited memory.
use constant THREAD_STACK_SIZE => 512 * 1024;

my $passes = shift;
die "Usage: $0 [passes]\n"
  unless defined $passes && int($passes) > 0;
$passes = int($passes);

my(@pipes, @threads);

@pipes = map {
  pipe my($r, $w) or die "pipe() failed";
  { read => $r, write => $w }
} (0 .. THREADS-1);

@threads = map {
  my $in = $pipes[$_]{read};
  $in->autoflush;
  my $out = $pipes[($_ + 1) % THREADS]{write};
  $out->autoflush;
  my $thread_id = $_ + 1;
  threads->create
    ({ stack_size => THREAD_STACK_SIZE, },
     sub {	     # $in, $out and $thread_id are captured in this closure
       while(my $msg = <$in>) { # receive message
	 chomp $msg;
	 if($msg eq 'EXIT') {	# asked to exit
	   last;
	 } elsif($msg > 0) {	# still work to do
	   say $out --$msg;	# send message
	 } else {		# no more work to do
	   say $thread_id;	# output result
	   # tell all threads to exit
	   say $_ 'EXIT' foreach map { $_->{write} } @pipes;
	   last;
	 }
       }
     });
} (0 .. THREADS-1);

# inject initial message
my $start_fh = $pipes[0]{write};
say $start_fh $passes;

# collect exited threads
$_->join foreach @threads;

