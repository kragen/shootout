# The Computer Language Benchmarks Game
# http://shootout.alioth.debian.org/
# contributed by Jonathan DePeri 2010/5
# based on an earlier version by Jesse Millikan
# uses Perl interpreter threads with pthreads-like cond_wait and cond_signal
# Modified by Andrew Rodland, August 2010

use threads;
use threads::shared;

my %color = (
  blue => 1,
  red => 2,
  yellow => 4,
);

my @colors;
@colors[values %color] = keys %color;

my @complement;
for my $triple (
  [qw(blue blue blue)],
  [qw(red red red)],
  [qw(yellow yellow yellow)],
  [qw(blue red yellow)],
  [qw(blue yellow red)],
  [qw(red blue yellow)],
  [qw(red yellow blue)],
  [qw(yellow red blue)],
  [qw(yellow blue red)],
) {
  $complement[ $color{$triple->[0]} | $color{$triple->[1]} ] = $color{$triple->[2]};
}

my @numbers = qw(zero one two three four five six seven eight nine);

sub display_complements
{
  for my $i (1, 2, 4) {
    for my $j (1, 2, 4) {
      print "$colors[$i] + $colors[$j] -> $colors[ $complement[$i | $j] ]\n";
    }
  }
  print "\n";
}

sub num2words {
  join ' ', '', map $numbers[$_], split //, shift;
}

my @creatures : shared;
my $meetings : shared;
my $first : shared = undef;
my $second : shared = undef;
my @met : shared;
my @met_self : shared;

sub chameneos
{
   my $id = shift;

   while (1) {
      lock $meetings;
      last unless $meetings;

      if (defined $first) {
         cond_signal $meetings;
         $creatures[$first] = $creatures[$id] = $complement[$creatures[$first] | $creatures[$id]];
         $met_self[$first]++ if ($first == $id);
         $met[$first]++;  $met[$id]++;
         $meetings --;
         undef $first;
      } else {
         $first = $id;
         cond_wait $meetings;
      }
   }
}

sub pall_mall
{
   my $N = shift;
   @creatures = map $color{$_}, @_;
   my @threads;

   print " ", join(" ", @_);

   $meetings = $N;
   for (0 .. $#creatures) {
      $met[$_] = $met_self[$_] = 0;
      push @threads, threads->create(\&chameneos, $_);
   }
   for (@threads) {
     $_->join();
   }

   $meetings = 0;
   for (0 .. $#creatures) {
      print "\n$met[$_]", num2words($met_self[$_]);
      $meetings += $met[$_];
     }
   print "\n", num2words($meetings), "\n\n";
}


display_complements();
pall_mall($ARGV[0], qw(blue red yellow));
pall_mall($ARGV[0], qw(blue red yellow red yellow blue red yellow red blue));
