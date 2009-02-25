/*
* The Computer Language Benchmarks Game
* http://shootout.alioth.debian.org/

* contributed by Premysl Hruby
*/


#include <stdio.h>
#include <stdlib.h>
#include <iostream>
#include <pthread.h>
#include <sched.h>

typedef unsigned int uint;

const uint NUM_THREADS   = 503;
const uint STACK_SIZE   = 16*1024;

int token = -1;

class RingThread;
RingThread* rt_arr[NUM_THREADS] = {0};

class RingThread
{
private:
   pthread_mutex_t   m_mutex;
   uint   node_id;
   uint   next_id;

public:

   RingThread( int id )
   {
      //mutex type is PTHREAD_MUTEX_NORMAL
      // we want self lock behaviour
      pthread_mutex_init( &m_mutex, 0 );

      node_id = id;
      next_id = id +1;

      if (next_id == NUM_THREADS)
         next_id = 0;
   }

   inline void AcquireLock()
   {
      // type is PTHREAD_MUTEX_NORMAL, therefore, try to lock to a locked 
      // mutex will result deadlock. However, other thread will unlock for this
      // mutex
      pthread_mutex_lock( &m_mutex );
   }
   inline void ReleaseLock()
   {
      pthread_mutex_unlock( &m_mutex );
   }

   static void* Run( void* param )
   {
      RingThread* prt = (RingThread*)param;

      while (true)
      {
         // is my turn???
         prt->AcquireLock();

         if (token != 0)
            token--;
         else // this turn is the end of token passing
         {
            std::cout << (prt->node_id +1) << std::endl;
            exit( 0 ); // a fast way to terminate :D
         }

         rt_arr[ prt->next_id ]->ReleaseLock(); // release lock for next thread
         sched_yield(); // my turn is finished. Yield cpu for next thread
      }
   }
};

int main(int argc, char** argv)
{
   token = (argc == 2) ? atoi( argv[1] ) : 1000;
   //std::cout << token;

   // must set stack size for each thread. Otherwise, can't spawn 503 threads :)
   pthread_attr_t stack_att;
   pthread_attr_init( &stack_att );
   pthread_attr_setstacksize( &stack_att, STACK_SIZE );
   pthread_t ht;

   for (uint i = 0; i < NUM_THREADS; i++)
   {
      RingThread* r =  new RingThread( i );

      rt_arr[i] = r;
      r->AcquireLock();

      pthread_create( &ht, &stack_att, &RingThread::Run, (void*)r );
   }

   // let's roll
   rt_arr[0]->ReleaseLock();

   // wait for result
   pthread_join( ht, 0 );

   return 0;
}

