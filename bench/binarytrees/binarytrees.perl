# The Computer Language Benchmarks Game
# http://shootout.alioth.debian.org/
#
# contributed by Emanuele Zeppieri
# modified by Reini Urban

use integer;

sub bottomup_tree { # item, depth
    return $_[0] unless $_[1];
    my $value = $_[0] * 2;
    [ $_[0], bottomup_tree($value-1, $_[1]-1), bottomup_tree($value, $_[1]-1) ]
}

sub item_check {
    my ($value, $left, $right) = @{ $_[0] };
    return !ref($left) ? $value : $value + item_check($left) - item_check($right);
}

my $max_depth = shift @ARGV;
my $min_depth = 4;

$max_depth = $min_depth + 2 if $min_depth + 2 > $max_depth;

my $stretch_depth = $max_depth + 1;
my $stretch_tree = bottomup_tree(0, $stretch_depth);
print "stretch tree of depth $stretch_depth\t check: ",
    item_check($stretch_tree), "\n";
undef $stretch_tree;

my $longlived_tree = bottomup_tree(0, $max_depth);

for ( my $depth = $min_depth; $depth <= $max_depth; $depth += 2 ) {
    my $iterations = 2 << $max_depth - $depth + $min_depth - 1;
    my $check = 0;
    
    foreach my $i (1..$iterations) {
        $check += item_check( bottomup_tree($i, $depth) );
        $check += item_check( bottomup_tree(-$i, $depth) )
    }
    
    print 2*$iterations, "\t trees of depth $depth\t check: ", $check, "\n"
}

print "long lived tree of depth $max_depth\t check: ",
    item_check($longlived_tree), "\n"
