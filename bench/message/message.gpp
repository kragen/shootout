/* The Computer Language Shootout
 * http://shootout.alioth.debian.org/
 * Contributed by Branimir Maksimovic
 */

#include <pthread.h>
#include <errno.h>
#include <cstdlib>
#include <iostream>
#include <ostream>
#include <deque>
using namespace std;

#define STACK_SIZE 65536

extern "C"
{
  static void* thread_run(void*);
}

class Mutex{
public:
  Mutex()
  {
    pthread_mutex_init(&m,0);
  }
  void lock()
  {
    pthread_mutex_lock(&m);
  }
  void unlock()
  {
    pthread_mutex_unlock(&m);
  }
  ~Mutex()
  {
    pthread_mutex_destroy(&m);
  }
private:
  Mutex(const Mutex&);
  Mutex& operator=(const Mutex&);
  pthread_mutex_t m;
  friend class Cond;
};

class Cond{
public:
  Cond()
  {
    pthread_cond_init(&c,0);
  }
  void wait(Mutex& m)
  {
    pthread_cond_wait(&c,&m.m);
  }
  void signal()
  {
    pthread_cond_signal(&c);
  }

  ~Cond()
  {
    pthread_cond_destroy(&c);
  }
private:
  Cond(const Cond&);
  Cond& operator=(const Cond&);
  pthread_cond_t c;
};

struct Sum{
int sum;
int increments;
Mutex m;
Cond c;
}gs;

class Thread{
public:
  Thread(Thread* t=0)
  :next_(t),message(0),stop_(false)
  {
  }

  Thread* next(){ return next_; }

  void start()
  {
    pthread_attr_t attrs;
    pthread_attr_init(&attrs);
    pthread_attr_setstacksize(&attrs,STACK_SIZE);
    while(int err = pthread_create(&tid,&attrs,thread_run,this))
    {
      if(err == EAGAIN)
      {
        cout<<"pthread create EAGAIN...\n";
        sleep(1);
      }
      else exit(EXIT_FAILURE);
    }
  }
  void join()
  {
    pthread_join(tid,0);
  }
  void stop()
  {
    mutex.lock();
    stop_=true;
    monitor.signal();
    mutex.unlock();
  }

  void push(int msg)
  {
    mutex.lock();
    message.push_front(msg);
    monitor.signal();
    mutex.unlock();
  }

  int run()
  {
    while(true)
    {
      mutex.lock();
      while(message.empty() && !stop_)monitor.wait(mutex);
      if(stop_)
      {
        mutex.unlock();
        break;
      }  
      if(next_)
      {
        next_->mutex.lock();
        next_->message.push_front(message.back()+1);
        next_->monitor.signal();
        next_->mutex.unlock();
      }
      else
      {
        gs.m.lock();
        gs.sum+=message.back()+1;
        gs.increments++;
        gs.c.signal();
        gs.m.unlock();
      }
      message.pop_back();
      mutex.unlock();
    }
    return 0;
  }

private:
  Cond monitor;
  Mutex mutex;
  Thread* next_;
  deque<int> message;
  pthread_t tid;
  bool stop_;
};

extern "C"
{
  static void* thread_run(void* t)
  {
    return (void*)((Thread*)t)->run();
  }
}

int main(int argc, char* argv[])
{
  int N=1;
  gs.sum=0;
  gs.increments=0;
  const int NTHREADS = 500;
  if(argc>1)N=atoi(argv[1]);

  Thread *first=0,*tmp=new Thread();
  tmp->start();
  for(int i=1;i<NTHREADS;++i)
  {
    first = new Thread(tmp);
    tmp = first;
    first->start();
  }

  for(int i=0;i<N;++i)
  {
    first->push(0);
  }

  gs.m.lock();
  while(gs.increments<N)gs.c.wait(gs.m);
  gs.m.unlock();

  tmp = first;

  while(tmp)
  {
    tmp->stop();
    tmp=tmp->next();
  }

  Thread* tmp1 = first;
  while(tmp1)
  {
    tmp1->join();
    tmp = tmp1;
    tmp1=tmp1->next();
    delete tmp;
  }
  cout<<gs.sum<<'\n';
}
