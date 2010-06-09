/*
 * The Computer Language Benchmarks Game
 * http://shootout.alioth.debian.org/
 * contributed Sriramkumar Balasubramanian
 */

package reversecomplement;

import java.util.*;
import java.io.*;

public class Main {

    public static void main(String[] args)  {

   byte[] dna=new byte[128];
   for(int i=0;i<128;i++)
       dna[i]=0;
   dna['a']=dna['A']='T';
   dna['c']=dna['C']='G';
   dna['g']=dna['G']='C';
   dna['t']=dna['T']='A';
   dna['u']=dna['U']='A';
   dna['m']=dna['M']='K';
   dna['r']=dna['R']='Y';
   dna['w']=dna['W']='W';
   dna['s']=dna['S']='S';
   dna['y']=dna['Y']='R';
   dna['k']=dna['K']='M';
   dna['v']=dna['V']='B';
   dna['h']=dna['H']='D';
   dna['d']=dna['D']='H';
   dna['b']=dna['B']='V';
   dna['n']=dna['N']='N';
   
     
   String line="",revLine="";
   
   Scanner console=new Scanner(System.in);
   try{
     
     String readLine="";
     StringTokenizer str;
   

     while((readLine=console.nextLine()).equals("")==false)
     {
         str=new StringTokenizer(readLine);
         if(str.countTokens()>1)
         {
            for(int i=0;i<revLine.length()/60;i++)
             System.out.println(revLine.substring(i*60,i*60+60));
            if(revLine.length()%60!=0)
            System.out.println(revLine.substring(revLine.length()/60*60,revLine.length()));
        revLine="";
        System.out.println(readLine);
         }

         else
         {
         String temp=str.nextToken();
         line="";
         for(int i=0;i<temp.length();i++)
             line=""+(char)dna[temp.charAt(i)]+line;
         revLine=line+revLine;
         }

     }
     for(int i=0;i<revLine.length()/60;i++)
             System.out.println(revLine.substring(i*60,i*60+60));
            System.out.println(revLine.substring(revLine.length()/60*60,revLine.length()));
   }
   catch(Exception e)
   {
       e.printStackTrace();
       System.out.println(e.getMessage());
   }

    }

}
