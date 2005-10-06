#!/usr/bin/perl -w
#
# Simple program to send an e-mail status message to everyone in
# the etc/mail.list file.

use Mail::Sendmail;

sub get_mail_list() {
    my @mailTo;

    if (open MAILLIST, "<./etc/mail.list") {
        while (<MAILLIST>) {
	    chomp();
	    push @mailTo, $_;
        }
    }

    return @mailTo;
}

sub send_a_mail($) {
    my $recipient = shift;

    my ($sec,$min,$hour,$mday,$month,$centm) = gmtime();

    print "Reading log\n";
    my $log = `cat /home/brent/shootout.run`;

    print $log;

    my $year = $centm + 1900;

    my $date = "$month-$mday-$year at $hour:$min:$sec GMT";

    %mail = ( 
              from      => 'bfulgham@debian.org',
              to	=> "$recipient",
	      subject   => 'Shootout Build Status',
	    );

    $mail{body} = 
    "Greetings!\n" .
    "This is an automated message from the Shootout build machine.\n" .
    "\n\n" .
    "Shootout Build Status:\n" .
    "======================\n" .
    "A build of the benchmark was successfully completed on $date\n" .
    "\n\n" .
    "Sincerely,\n\n" .
    "The Shootout Autobuilder\n\n" .

    "$log\n";

    if (sendmail %mail) {
        print "Mail send to $recipient SUCCEEDED.\n";
    } else {
        print "Error sending mail: $Mail::Sendmail::error \n"
    }
}

sub main() {
    # Set desired mail server
    unshift @{$Mail::Sendmail::mailcfg{'smtp'}} , 'localhost';

    # Read list of mail recipients
    my @mailTo = get_mail_list();

    foreach my $d (@mailTo) {
        send_a_mail( $d );
    }
}

main()
