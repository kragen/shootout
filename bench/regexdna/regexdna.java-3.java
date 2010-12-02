/* The Computer Language Benchmarks Game
 * http://shootout.alioth.debian.org/
 *
 * contributed by Enotus 2010-11-26
 *
 */

import java.io.*;
import java.util.*;
import java.util.concurrent.atomic.AtomicInteger;

public final class regexdna {

   static final class ByteString{
      final byte[] data;
      ByteString(int size){data=new byte[size];}
      ByteString(String s){data=s.getBytes();}
      ByteString(byte[] od,int op,int ol){data=new byte[ol];System.arraycopy(od, op, data, 0, ol);}
      int length(){return data.length;}
      public String toString(){return new String(data);}
      public int hashCode(){return Arrays.hashCode(data);}
      public boolean equals(Object obj){
         if(obj!=null && getClass()==obj.getClass() && Arrays.equals(data, ((ByteString) obj).data)) return true;
         else return false;
      }
   }
   static final class ByteBuilder{
      byte[] data;int size=0;
      ByteBuilder(int size){data=new byte[size];}
      int length(){return size;}
      void append(byte[] od,int op,int ol){
         if(data.length<(size+=ol)) data=Arrays.copyOf(data,size*2);
         System.arraycopy(od,op,data,size-ol,ol);
      }
      ByteString toByteString(){return new ByteString(data,0,size);}
   }

   static final class Matcher{
      static final int transSize=128;
      static final class State{
         final State[] trans=new State[transSize];boolean isFinal;int start;
         void copyFrom(State o){System.arraycopy(o.trans, 0, trans, 0, transSize);isFinal=o.isFinal;}
      }

      final byte[] inData;final int inSize;
      final State rootState=new State();final State[] root=rootState.trans;
      final State[] active;int act=0;

      private List<Character> getCharList(char c){
         List<Character> cc=new ArrayList<Character>();
         if(c=='.'){
            for(int i=0;i<transSize;i++) if(i!='\n') cc.add((char)i);
         }else if(Character.isLetter(c)){
            cc.add(Character.toLowerCase(c));
            cc.add(Character.toUpperCase(c));
         }else{
            cc.add(c);
         }
         return cc;
      }
      
      int addBar(String pattern,int index,List<State> ss){
         for(State s:ss)s.isFinal=true;
         ss.clear();ss.add(rootState);
         return index+1;
      }
      int addPar(String pattern,int index,List<State> ss){
         State ns=new State();
         List<State> nss=new ArrayList<State>();nss.add(ns);
         index++;
         char pc;
         while((pc=pattern.charAt(index++))!=']'){
            for(char c:getCharList(pc))
               for(State s:ss)
                  if(s.trans[c]!=null)nss.add(s.trans[c]);
                  else s.trans[c]=ns;
         }
         ss.clear();ss.addAll(nss);
         return index;
      }
      int addPointStar(String pattern,int index,List<State> ss){
         State ns=new State();
         ss.add(ns);
         for(char c:getCharList(pattern.charAt(index)))
            for(State s:ss){
               if(s.trans[c]!=null)ns.copyFrom(s.trans[c]);
               s.trans[c]=ns;
            }
         return index+2;
      }
      int addCharConcat(String pattern,int index,List<State> ss){
         State ns=new State();
         for(char c:getCharList(pattern.charAt(index)))
            for(State s:ss){
               if(s.trans[c]!=null)ns.copyFrom(s.trans[c]);
               s.trans[c]=ns;
            }
         ss.clear();ss.add(ns);
         return index+1;
      }
      Matcher(String pattern,ByteString ins){
         List<State> ss=new ArrayList<State>();
         ss.add(rootState);
         
         for(int i=0;i<pattern.length();){
            if(pattern.charAt(i)=='|'){
               i=addBar(pattern,i,ss);
            }else if(pattern.charAt(i)=='['){
               i=addPar(pattern,i,ss);
            }else if(pattern.charAt(i)=='.' && i+1<pattern.length() && pattern.charAt(i+1)=='*'){
               i=addPointStar(pattern,i,ss);
            }else{
               i=addCharConcat(pattern,i,ss);
            }
         }
         addBar(pattern,0,ss);

         active=new State[pattern.length()];
         inData=ins.data;inSize=inData.length;
      }

      int start=-1;
      int startFind(int index){
         while(index<inSize){
            int c=inData[index++];

            int nct=0;
            for(int ct=0;ct<act;ct++){
               State s=active[ct];State ns=s.trans[c];
               if(ns!=null)   if(ns.isFinal){act=0;start=s.start;return index;}
                           else{ns.start=s.start;active[nct++]=ns;}
            }
            act=nct;

            State ns=root[c];
            if(ns!=null)   if(ns.isFinal){act=0;start=index-1;return index;}
                        else{ns.start=index-1;active[act++]=ns;}
         }
         return -1;
      }
      
      int find(int index){
         while(index<inSize){
            int c0=inData[index++];

            int nct=0;
            for(int ct=0;ct<act;ct++){
               State ns=active[ct].trans[c0];
               if(ns!=null)   if(ns.isFinal){act=0; return index;}
                           else active[nct++]=ns;
            }
            act=nct;

            State ns=root[c0];
            if(ns!=null)   if(ns.isFinal){act=0; return index;}
                        else active[act++]=ns;
         }
         return -1;
      }
   }


   static final String[] pat1={"agggtaaa|tttaccct", "[cgt]gggtaaa|tttaccc[acg]",
      "a[act]ggtaaa|tttacc[agt]t", "ag[act]gtaaa|tttac[agt]ct",
      "agg[act]taaa|ttta[agt]cct", "aggg[acg]aaa|ttt[cgt]ccct",
      "agggt[cgt]aa|tt[acg]accct", "agggta[cgt]a|t[acg]taccct",
      "agggtaa[cgt]|[acg]ttaccct"};
   static final Map<ByteString,ByteString> pat2 = new HashMap<ByteString,ByteString>();
      static{
      pat2.put(new ByteString("W"), new ByteString("(a|t)"));
      pat2.put(new ByteString("Y"), new ByteString("(c|t)"));
      pat2.put(new ByteString("K"), new ByteString("(g|t)"));
      pat2.put(new ByteString("M"), new ByteString("(a|c)"));
      pat2.put(new ByteString("S"), new ByteString("(c|g)"));
      pat2.put(new ByteString("R"), new ByteString("(a|g)"));
      pat2.put(new ByteString("B"), new ByteString("(c|g|t)"));
      pat2.put(new ByteString("D"), new ByteString("(a|g|t)"));
      pat2.put(new ByteString("V"), new ByteString("(a|c|g)"));
      pat2.put(new ByteString("H"), new ByteString("(a|c|t)"));
      pat2.put(new ByteString("N"), new ByteString("(a|c|g|t)"));
   }
   static final AtomicInteger pat1Ct=new AtomicInteger();
   
   public static void main(String[] args) throws Exception {
      final ByteString s1;int s1Size;{
         s1Size=System.in.available();
         s1=new ByteString(s1Size);
         System.in.read(s1.data);
      }

      final ByteString s2;int s2Size;{
         ByteBuilder bb=new ByteBuilder(s1Size);
         Matcher m=new Matcher(">.*\n|\n", s1);
         int inPos=0,index=0;
         while((index=m.startFind(index))>=0){
            bb.append(s1.data, inPos, m.start-inPos);
            inPos=index;
         }
         bb.append(s1.data, inPos, s1.length()-inPos);
         s2=bb.toByteString();
         s2Size=s2.length();
      }

      final int[] pat1res=new int[pat1.length];{
         Thread[] pool=new Thread[pat1.length];
         for (int i=0;i<pool.length;i++)
            pool[i]=new Thread(){
               public void run() {
                   int r; while((r=pat1Ct.getAndIncrement())<pat1res.length){
                     Matcher m=new Matcher(pat1[r],s2);
                     int count=0,index=0;while((index=m.find(index))>=0) count++;
                     pat1res[r]=count;
                   }
               }
            };
         for (Thread t:pool) t.start();
         for (Thread t:pool) t.join();
      }

      int s3Size;{
         ByteBuilder bb=new ByteBuilder(s1Size*3/2);
         Matcher m=new Matcher("[WYKMSRBDVHN]", s2);
         int inPos=0,index=0;
         while((index=m.startFind(index))>=0){
            bb.append(s2.data, inPos, m.start-inPos);
            ByteString rep=pat2.get(new ByteString(s2.data,m.start,index-m.start));
            bb.append(rep.data, 0, rep.length());
            inPos=index;
         }
         bb.append(s2.data, inPos, s2.length()-inPos);
         s3Size=bb.length();
      }

      for(int i=0;i<pat1.length;i++)System.out.println(pat1[i]+" "+pat1res[i]);
      System.out.println();
      System.out.println(s1Size);
      System.out.println(s2Size);
      System.out.println(s3Size);
   }
}
