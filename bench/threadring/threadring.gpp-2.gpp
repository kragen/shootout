/*
 * The Computer Language Benchmarks Game
 * http://shootout.alioth.debian.org/
 * Contributed by Premysl Hruby
 * convert to C++ by The Anh Tran
 */

#include <pthread.h>
#include <sched.h>
#include <cstdio>
#include <cstdlib>

typedef unsigned int uint;

const uint NUM_THREADS   = 503;
const uint STACK_SIZE   = 16*1024;


int   token;

pthread_mutex_t      mutex   [NUM_THREADS];
pthread_t         threadid[NUM_THREADS];
char            stacks   [NUM_THREADS][STACK_SIZE];


static
void* thread_func( void *num )
{
   size_t thisnode      = reinterpret_cast<size_t>(num);
   int nextnode      = ( thisnode + 1 ) % NUM_THREADS;

   pthread_mutex_t   *mutex_this_node = mutex + thisnode;
   pthread_mutex_t   *mutex_next_node = mutex + nextnode;

   while (true) 
   {
      pthread_mutex_lock( mutex_this_node );

      if ( token > 0 ) 
      {
         token--;
         pthread_mutex_unlock( mutex_next_node );
      }
      else 
      {
          printf( "%d\n", static_cast<int>(thisnode +1) );
          exit(0);
      }
   }

   return 0;
}


int main(int argc, char** args)
{
   if (argc >= 2)
      token = atoi(args[1]);
   else
      token = 1000; // test case

   pthread_attr_t stack_attr;
   pthread_attr_init(&stack_attr);

   for (uint i = 0; i < NUM_THREADS; i++) 
   {
      // init mutex objects
      pthread_mutex_init( &(mutex[i]), 0);
      pthread_mutex_lock( &(mutex[i]) );

      // manual set stack space & stack size for each thread
      // to reduce memory usage
      pthread_attr_setstack( &stack_attr, &(stacks[i]), STACK_SIZE );

      // create thread using specified stackspace
      pthread_create( &(threadid[i]), &stack_attr, &thread_func, reinterpret_cast<void*>(i) );
   }

   // start game
   pthread_mutex_unlock( &(mutex[0]) );

   // wait for result
   pthread_join( threadid[0], 0 );

   return 1;
}

