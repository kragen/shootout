#!/usr/bin/perl -w
# The Great Computer Language Shootout
# http://shootout.alioth.debian.org/
# implemented by Greg Buchholz


use strict;

my $w=shift;
my $h=$w;
my $limit = 2; my $limit_sqr = $limit * $limit;
my $iter = 50;

print "P4\n$w $h\n";

my $Zr, my $Zi, my $Cr, my $Ci, my $Tr, my $Ti;
my $byte_acc=0, my $bit_num=0;

for my $y (0..$h-1) 
{
    for my $x (0..$w-1) 
    {
        $Zr= 0; $Zi=0;
        $Cr = (2*$x/$w - 1.5); $Ci=(2*$y/$h - 1);
        
        for (1..$iter)
        {
            $Tr = $Zr*$Zr - $Zi*$Zi + $Cr;
            $Ti = 2*$Zr*$Zi + $Ci;
            $Zr = $Tr; $Zi = $Ti;
            last if ($Zr*$Zr+$Zi*$Zi>$limit_sqr);
        }
        
        $byte_acc*=2;
        $byte_acc++ unless ($Zr*$Zr+$Zi*$Zi>$limit_sqr);
                
        $bit_num++; 
        if($bit_num == 8)
        {
            print chr($byte_acc);
            $byte_acc = 0;
            $bit_num = 0;
        }
        elsif($x == $w-1)
        {
            $byte_acc = $byte_acc * 2**(8-$w%8);
            print chr($byte_acc);
            $byte_acc = 0;
            $bit_num = 0;
        }
    }
}	