#!/usr/bin/pike
// -*- mode: pike -*-
// $Id: except.pike,v 1.1 2004-05-19 18:09:43 bfulgham Exp $
// http://www.bagley.org/~doug/shootout/
// from: Per Hedbor

// this version requires Pike 7.1

class HiException( mixed value ) { constant IsHi = 1; }
class LoException( mixed value ) { constant IsLo = 1; }

void some_function( int num )
{
    if( mixed e = catch(  hi_function( num ) ) )
	error( "We shouldn't get here (%s)", describe_error( e ) );
}
  
int HI, LO;

void hi_function(int num)
{
    if( mixed e = catch( lo_function( num ) ) )
	if( e->IsHi )
	    HI++;
	else
	    throw( e );
}
  
void lo_function(int num)
{
    if( mixed e = catch(  blowup(num) ) )
	if( e->IsLo )
	    LO++;
	else
	    throw( e );
}
  
  
void blowup(int num)
{
    if( num & 1 )
	throw( LoException(num) );
    else
	throw( HiException(num) );
}
  
void main(int argc, array argv)
{
    int num = (int)argv[-1];
    if( num < 1 )
	num = 1;
    while(num)
	some_function( num-- );
    write( "Exceptions: HI=%d / LO=%d\n" , HI, LO );
}
