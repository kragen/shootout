# The Great Computer Language Shootout
# http://shootout.alioth.debian.org/
#
# Contributed by Márton Papp

sub eval_A {
  my ( $i, $j ) = @_;
  return 1.0 / ( ( $i + $j ) * ( $i + $j + 1 ) / 2 + $i + 1 );
}

sub eval_A_times_u {
  my ( $N, $u, $Au ) = @_;
  my $i, $j;
  for ( $i = 0 ; $i < $N ; $i++ ) {
    $$Au[$i] = 0;
    for ( $j = 0 ; $j < $N ; $j++ ) { $$Au[$i] += eval_A( $i, $j ) * $$u[$j]; }
  }
}

sub eval_At_times_u {
  my ( $N, $u, $Au ) = @_;
  my ( $i, $j );
  for ( $i = 0 ; $i < $N ; $i++ ) {
    $$Au[$i] = 0;
    for ( $j = 0 ; $j < $N ; $j++ ) { $$Au[$i] += eval_A( $j, $i ) * $$u[$j]; }
  }
}

sub eval_AtA_times_u {
  my ( $N, $u, $AtAu ) = @_;
  my @v;
  eval_A_times_u( $N, $u, \@v );
  eval_At_times_u( $N, \@v, $AtAu );
}

my $i;
my $N = ( ( @ARGV == 1 ) ? $ARGV[0] : 500 );
my ( @u, @v, $vBv, $vv );
$| = 1;
for ( $i = 0 ; $i < $N ; $i++ ) { $u[$i] = 1; }
for ( $i = 0 ; $i < 10 ; $i++ ) {
  eval_AtA_times_u( $N, \@u, \@v );
  eval_AtA_times_u( $N, \@v, \@u );
}

$vBv = $vv = 0;
for ( $i = 0 ; $i < $N ; $i++ ) { $vBv += $u[$i] * $v[$i]; $vv += $v[$i] * $v[$i]; }
printf( "%0.9f\n", sqrt( $vBv / $vv ) );

exit 0;

