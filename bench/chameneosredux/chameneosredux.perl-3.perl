# The Computer Language Benchmarks Game
# http://shootout.alioth.debian.org/
# contributed by Jonathan DePeri 2010/5
# based on an earlier version by Jesse Millikan
# uses Perl interpreter threads with pthreads-like cond_wait and cond_signal

use threads;
use threads::shared;

sub complement
{
   my $_ = join('', @_);
   
   s/BB/B/;
   s/BR/Y/;
   s/BY/R/;
   s/RB/Y/;
   s/RR/R/;
   s/RY/B/;
   s/YB/R/;
   s/YR/B/;
   s/YY/Y/;
   
   return $_;
}

sub color_name
{
   my $_ = shift;

   s/B/blue/;
   s/R/red/;
   s/Y/yellow/;

   return $_;
}

sub display_complements
{
   local $\ = "\n";

   print 'blue + blue -> ', color_name(complement('B','B'));
   print 'blue + red -> ', color_name(complement('B','R'));
   print 'blue + yellow -> ', color_name(complement('B','Y'));
   print 'red + blue -> ', color_name(complement('R','B'));
   print 'red + red -> ', color_name(complement('R','R'));
   print 'red + yellow -> ', color_name(complement('R','Y'));
   print 'yellow + blue -> ', color_name(complement('Y','B'));
   print 'yellow + red -> ', color_name(complement('Y','R'));
   print 'yellow + yellow -> ', color_name(complement('Y','Y'));
   print '';
}

sub num2words
{
   my $_ = shift;

   s/0/ zero/g;
   s/1/ one/g;
   s/2/ two/g;
   s/3/ three/g;
   s/4/ four/g;
   s/5/ five/g;
   s/6/ six/g;
   s/7/ seven/g;
   s/8/ eight/g;
   s/9/ nine/g;

   return $_;
}

sub print_color_names
{
   for (@_) { print ' ', color_name($_); }
}


my @colors : shared;
my $meetings : shared;
my $first : shared = undef;
my $second : shared = undef;
my @met : shared;
my @met_self : shared;

sub chameneos
{
   my $id = shift;
   my $other = undef;
   
   while (1) {
      lock $meetings;
      last if ($meetings <= 0);
   
      if (not defined $first) {
         $first = $id;
         cond_wait $meetings;
      } else {
         cond_signal $meetings;
         
         $colors[$first] = $colors[$id] = complement($colors[$first], $colors[$id]);
         $met_self[$first]++ if ($first == $id);      
         $met[$first]++;  $met[$id]++;
         $meetings -= 1;
         
         $first = undef;
      }
   }
}

sub pall_mall
{
   my $N = shift;
   @colors = @_;
   my @threads;
   
   print_color_names(@colors);

   $meetings = $N;
   for (0..@colors-1) {
      $met[$_] = $met_self[$_] = 0;
      $threads[$_] = threads->create(\&chameneos, $_);
   }
   for (@threads) {
     $_->join();
   }
   
   $meetings = 0;
   for (0..@colors-1) {
      print "\n$met[$_]", num2words($met_self[$_]);
      $meetings += $met[$_];
     }
   print "\n", num2words($meetings), "\n\n";
}


display_complements();
pall_mall($ARGV[0], qw(B R Y));
pall_mall($ARGV[0], qw(B R Y R Y B R Y R B));
