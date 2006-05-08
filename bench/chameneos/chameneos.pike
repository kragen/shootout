/* The Computer Language Shootout
 * http://shootout.alioth.debian.org/
 * Contributed by David Hedbor
 */

enum Color { blue, red, yellow, faded };
enum bool { false, true };
class MeetingPlace(int n)
{
  private Color first, second;
  private bool firstCall = true;
  private bool mustWait = false; 
  private Thread.Condition monitor = Thread.Condition();
  private Thread.Mutex mlock = Thread.Mutex();

  Color OtherCreaturesColor(Color me)
  {
    Thread.MutexKey key = mlock->lock();
    Color other;

    while (mustWait) {
      monitor->wait(key);
    }
    //    write("Me = %d, n = %d\n", me, n);

    if (firstCall)
    {
      if (n-- > 0)
      {
        first = me;
        firstCall = false;

        while (!firstCall) {
          monitor->wait(key);
        }
        mustWait = false;
        other = second;
      } else {
        other = faded;
      }
    } else {
      second = me;
      other = first;
      firstCall = true;
      mustWait = true;
    }
    monitor->broadcast();
    return other;
  }
};

class Creature(MeetingPlace m, Color me)
{
  int creaturesMet;

  void Be() {
    while(me != faded) { MeetOtherCreature(); }
  }

  void MeetOtherCreature()
  {
    Color other = m->OtherCreaturesColor(me);
    if (other == faded) {
      me = other;
    } else {
      creaturesMet++;
      me = Complement(other);
    }
  }
  
  Color Complement(Color other)
  {
    if (me == other) return me;
    switch(me)
    {
    case blue:
      return other == red ? yellow : red;
    case red:
      return other == blue ? yellow : blue;
    case yellow:
      return other == blue ? red : blue;
    default: return me;
    }
  }
};

array(Color) colors = ({ blue, red, yellow, blue });
array(Creature) creatures = allocate(4);
array(Thread.Thread) threads = allocate(4);

int main(int argc, array(string) argv)
{
  if(argc < 2) return 0;
  int n = (int)argv[1];

  MeetingPlace m = MeetingPlace(n);

  for (int i=0; i < sizeof(colors); i++) {
    creatures[i] = Creature(m, colors[i]);
    threads[i] = Thread.Thread(creatures[i]->Be, 0);
  }

  threads->wait();

  int meetings = 0;
  for(int i=0; i < sizeof(creatures); i++) {
    meetings += creatures[i]->creaturesMet;
  }

  write("%d\n", meetings);
  return 0;
}
