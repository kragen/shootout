# The Computer Language Shootout
# http://shootout.alioth.debian.org/
# Contributed by Kalev Soikonen

my @experiment = (
    '(2/3)^k'			=>	'(2/3) ** ($_ - 1)',
    'k^-0.5'			=>	'1 / sqrt $_',
    '1/k(k+1)'			=>	'1 / ($_ * ($_ + 1))',
    'Flint Hills'		=>	'1 / ($_ * $_ * $_ * sin() * sin())',
    'Cookson Hills'		=>	'1 / ($_ * $_ * $_ * cos() * cos())',
    'Harmonic'			=>	'1 / $_',
    'Riemann Zeta'		=>	'1 / ($_ * $_)',
    'Alternating Harmonic'	=>	'(-1, 1)[$_&1] / $_',
    'Gregory'			=>	'(-1, 1)[$_&1] / (2 * $_ - 1)',
);

my $N = shift || 2500000;

while (my ($desc, $fun) = splice @experiment, 0, 2) {
    my $psum = "my \$S = 0; \$S += $fun foreach (1..$N); \$S";
    printf "%.9f\t$desc\n", eval $psum;
}
