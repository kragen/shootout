// -*- mode: c++ -*-
// $Id: reversefile.gpp,v 1.2 2004-11-30 07:10:05 bfulgham Exp $
// http://shootout.alioth.debian.org/
// 
// Based on the C version by Alan Post <apost@recalcitrant.org>
// C++-ified by Brent Fulgham, based on an idea by Mark Fitzgerald

#include <assert.h>
#include <sys/uio.h>
#include <iostream>

using namespace std;

#if defined(__INTEL_COMPILER)
#define STDOUT_FILENO 1
#endif

//
// Note that malloc(3) seems happier with chunks of 4096
//
const int MAXREAD = (4096 - sizeof( size_t ) - sizeof( void* ));

struct buf_t
{
    char d[MAXREAD];
    size_t len;
    buf_t *next;
};

static buf_t* read_lines( buf_t* tail )
{
    buf_t* curr = tail;
    tail->next = NULL;

    while ( true )
    {
        cin.read(curr->d, MAXREAD );
	int nread = cin.gcount();
	curr->len = nread;
        if ( nread < MAXREAD ) { return curr; }
        buf_t* head = new buf_t;
        head->next = curr;
        curr = head;
    }
}

#define WRITEOUT( p_, l_ ) \
        do { \
            vec[ ivec ].iov_base = (char*) (p_); \
            vec[ ivec ].iov_len = (int) (l_); \
            ivec++; \
            if ( ivec == IOV_MAX ) \
            { \
                writev( STDOUT_FILENO, vec, ivec ); \
                ivec = 0; \
            } \
        } while (0)

#define LINEOUT \
        do { \
            WRITEOUT( pos, end - pos); \
            for (; loh != NULL; loh = loh->next ) \
                WRITEOUT( loh->d, loh->len ); \
        } while (0)

int main(int argc, char* argv[])
{
    buf_t tail;
    buf_t* head = read_lines( &tail );

    buf_t* loh = NULL;
    buf_t* curr = head;

    struct iovec vec[ IOV_MAX ];
    size_t ivec = 0;

    while ( true )
    {
        char* buf = curr->d;
        char* end = buf + curr->len;
        char* pos = end;
        for (;; pos--)
        {
            if ( pos <= buf )
            {
                buf_t* new_curr = curr->next;

                if ( new_curr == NULL )
                {
                    LINEOUT;
                    writev( STDOUT_FILENO, vec, ivec );
                    return EXIT_SUCCESS;
                }

                curr->len = end - buf;
                curr->next = loh;
                loh = curr;
                
                curr = new_curr;
                break;
            }
            if ( *(pos-1) == '\n' )
            {
                LINEOUT;
                end = pos;
            }
        }
    }
    assert( NULL == "unreachable" );
    return EXIT_FAILURE;
}

