package Ackermann;

require 5.005_62;
use strict;
use warnings;
use Carp;

require Exporter;
require DynaLoader;
use AutoLoader;

our @ISA = qw(Exporter DynaLoader);

# Items to export into callers namespace by default. Note: do not export
# names by default without a very good reason. Use EXPORT_OK instead.
# Do not simply export all your public functions/methods/constants.

# This allows declaration	use Ackermann ':all';
# If you do not need this, moving things directly into @EXPORT or @EXPORT_OK
# will save memory.
our %EXPORT_TAGS = ( 'all' => [ qw(
	Ack
) ] );

our @EXPORT_OK = ( @{ $EXPORT_TAGS{'all'} } );

our @EXPORT = qw(
	
);
our $VERSION = '0.01';

bootstrap Ackermann $VERSION;

# Preloaded methods go here.

# Autoload methods go after =cut, and are processed by the autosplit program.

1;
__END__
# Below is stub documentation for your module. You better edit it!

=head1 NAME

Ackermann - Perl extension to calculate Ackermann's Function

=head1 SYNOPSIS

  use Ackermann qw(Ack);
  print "Ack(3,8)==", Ack(3,8) ,"\n";

=head1 DESCRIPTION

This module provides the function Ack, a recursive function to 
calculate Ackermann's function

=head2 EXPORT

None by default.

=head1 AUTHOR

(Doug Bagley) http://www.bagley.org/~doug/contact.shtml

=head1 SEE ALSO

perl(1).

=cut
