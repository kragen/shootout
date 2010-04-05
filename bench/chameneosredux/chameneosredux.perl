# The Computer Language Benchmark Game
# http://shootout.alioth.debian.org/
# contributed by Daniel Green 2010-4-1
#  a transliteration of Python 3 #2

use 5.10.0;
use strict;
use warnings;
use threads;
use threads::shared;
use Thread::Semaphore;
use List::Util qw(sum);

my @creature_colors = qw(blue red yellow);

sub complement {
    my ($c1, $c2) = @_;

    if ($c1 eq $c2) {
        return $c1;
    } elsif ($c1 eq 'blue') {
        if ($c2 eq 'red') {
            return 'yellow';
        } else {
            return 'red';
        }
    } elsif ($c1 eq 'red') {
        if ($c2 eq 'blue') {
            return 'yellow';
        } else {
            return 'blue';
        }
    } elsif ($c2 eq 'blue') {
        return 'red';
    } else {
        return 'blue';
    }
}

my %compl_dict;
foreach my $c1 (@creature_colors) {
    foreach my $c2 (@creature_colors) {
        $compl_dict{"$c1,$c2"} = complement($c1, $c2);
    }
}

sub check_complement {
    foreach my $c1 (@creature_colors) {
        foreach my $c2 (@creature_colors) {
            say "$c1 + $c2 -> " . $compl_dict{"$c1,$c2"};
        }
    }

    say '';
}

sub spellout {
    my ($n) = @_;

    my @numbers = qw(zero one two three four five six seven eight nine);

    return ' ' . join(' ', map { $numbers[$_] } split //, $n);
}

sub report {
    my ($input_zoo, $met, $self_met) = @_;

    say ' ' . join(' ', @{$input_zoo});

    for (my $x = 0; $x < scalar @{$met}; $x++) {
        say $met->[$x] . spellout($self_met->[$x]);
    }

    say spellout(sum(@{$met})) . "\n";
}

sub creature {
    my ($my_id, $venue, $my_lock, $in_lock, $out_lock) = @_;

    while (1) {
        $my_lock->down();
        $in_lock->down();

        $venue->[0] = $my_id;
        $out_lock->up();
    }
}

sub let_them_meet {
    my ($meetings_left, $input_zoo) = @_;

    my $c_no = scalar @{$input_zoo};
    my @venue :shared = (-1);
    my @met = (0) x $c_no;
    my @self_met = (0) x $c_no;
    my @colors = @{$input_zoo};

    my $in_lock = Thread::Semaphore->new();
    $in_lock->down();
    my $out_lock = Thread::Semaphore->new();
    $out_lock->down();
    
    my @locks;
    for my $ci (0 .. $c_no - 1) {
        $locks[$ci] = Thread::Semaphore->new();
        threads->new(\&creature, $ci, \@venue, $locks[$ci], $in_lock, $out_lock)->detach();
    }

    $in_lock->up();
    $out_lock->down();
    my $id1 = $venue[0];
    while ($meetings_left > 0) {
        $in_lock->up();
        $out_lock->down();
        my $id2 = $venue[0];
        if ($id1 != $id2) {
            my $new_color = $compl_dict{"$colors[$id1],$colors[$id1]"};
            $colors[$id1] = $new_color;
            $colors[$id2] = $new_color;
            $met[$id1] += 1;
            $met[$id2] += 1;
        } else {
            $self_met[$id1] += 1;
            $met[$id1] += 1;
        }
        $meetings_left -= 1;
        if ($meetings_left > 0) {
            $locks[$id1]->up();
            $id1 = $id2;
        } else {
            report($input_zoo, \@met, \@self_met);
        }
    }
}

check_complement();
let_them_meet($ARGV[0], ['blue', 'red', 'yellow']);
let_them_meet($ARGV[0], ['blue', 'red', 'yellow', 'red', 'yellow', 'blue', 'red', 'yellow', 'red', 'blue']);
