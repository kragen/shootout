#!/usr/bin/pike
// -*- mode: pike -*-
// $Id: echo.pike,v 1.1 2004-05-19 18:09:37 bfulgham Exp $
// http://www.bagley.org/~doug/shootout/
// based on code from: Per Hedbor

#define DATA "Hello there sailor\n"

void echo_server(Stdio.Port p, int n) {
    Stdio.File f = p->accept();
    int tbytes;
    string q;
    while( (q = f->read( 8192,1  )) && strlen( q ) ) {
	tbytes += strlen(q);
	f->write( q );
    }
    write( "server processed %d bytes\n", tbytes );
}

void echo_client(int p, int n) {
    int i;
    Stdio.File f = Stdio.File();

    f->connect( "localhost", p );
    int s = strlen(DATA);
    for (i=0; i<n; i++) {
	f->write( DATA );
	if(  f->read( s ) != DATA ) {
	    werror( "Transfer error at repetition "+i+"\n");
	    _exit( 1 );
	}
    }
    f->close();
    _exit( 0 );
}

/* Fork is not really available in a threaded pike. Thus this hack. It
 * assumes the pike binary can be found in your path, and that you have
 * a /usr/bin/env
 */
void start_client( int p, int n )
{
    Process.create_process( ({ "/usr/bin/env", "pike", __FILE__,
			       (string)p, (string)n }) );
}

void main(int argc, array argv)
{
    if( argc < 3 )
    {
	int n = max((int)argv[-1],1);
	Stdio.Port p = Stdio.Port( 0 );
	int pno = (int)((p->query_address( )/" ")[1]);
	start_client( pno, n );
	echo_server( p, n );
    } else {
	echo_client( (int)argv[1], (int)argv[2] );
    }
    sleep(1);
}
