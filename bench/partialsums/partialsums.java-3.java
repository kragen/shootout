/**
 * The Computer Language Benchmarks Game
 * http://shootout.alioth.debian.org/
 * contributed by Isaac Gouy 
 * modified by Stefan Krause
 */

import java.lang.Math;

class partialsums {
   static final double twothirds = 2.0/3.0;
   
   public static class FasterTrig {
		private static final double PI_DOUBLE = Math.PI * 2.0;
		private static final double PI_FOURTH = Math.PI / 4.0;
		private static final double PI_HALF = Math.PI / 2.0;
		private static final double PI = Math.PI;
		private static final double SIN_CORRECTION = 2.44745300000000500000e-16;
		private static final double COS_CORRECTION = 2.45045300000000500000e-16;
		
		private static double fastSin(double x)
		{
			if (x>PI_FOURTH || x <-PI_FOURTH) throw new IllegalArgumentException("invalid angle "+x);
			return Math.sin(x);
		}
		
		private static double fastCos(double x)
		{
			if (x>PI_FOURTH || x <-PI_FOURTH) throw new IllegalArgumentException("invalid angle "+x);
			return Math.cos(x);
		}
				
		public static double sin(double x)
		{
			// The correction factor works fine for this case. If you prefer performance to
			// accuracy you'd just say x = (x % PI_DOUBLE) instead of the two lines below
			double f = x / PI_DOUBLE;
			x = (x % PI_DOUBLE) - f * SIN_CORRECTION;
			
			if (x<0) x += PI_DOUBLE;
			if (x > PI) x -= PI_DOUBLE;

			if (x>=0)
			{
				if (x > PI_HALF) x = PI - x;
				if (x<=PI_FOURTH) return fastSin(x);
				else return fastCos(x-PI_HALF);
			}
			else
			{
				if (x < -PI_HALF) x = -PI - x;
				if (x>=-PI_FOURTH) return fastSin(x);
				else return -fastCos(x+PI_HALF);
			}
		}		
		
		
		public static double cos(double x)
		{
			x += PI_HALF;
			double f = x / PI_DOUBLE;
			x = (x % PI_DOUBLE) - f * COS_CORRECTION;
			
			if (x<0) x += PI_DOUBLE;
			if (x > PI) x -= PI_DOUBLE;

			if (x>=0)
			{
				if (x > PI_HALF) x = PI - x;
				if (x<=PI_FOURTH) return fastSin(x);
				else return fastCos(x-PI_HALF);
			}
			else
			{
				if (x < -PI_HALF) x = -PI - x;
				if (x>=-PI_FOURTH) return fastSin(x);
				else return -fastCos(x+PI_HALF);
			}			
		}
   }
   
   public static void main(String[] args){
      int n = Integer.parseInt(args[0]);

      double a1 = 0.0, a2 = 0.0, a3 = 0.0, a4 = 0.0, a5 = 0.0;
      double a6 = 0.0, a7 = 0.0, a8 = 0.0, a9 = 0.0, alt = -1.0;

      for (int k=1; k<=n; k++){
    	 double dk = k;
         double k2 = dk*dk;
         double k3 = k2*dk;
         double sk = FasterTrig.sin(dk), ck = FasterTrig.cos(dk);
         alt = -alt;

         a1 += Math.pow(twothirds,dk-1);
         a2 += 1.0/Math.sqrt(dk);
         a3 += 1.0/(k2+dk);
         a4 += 1.0/(k3 * sk*sk);
         a5 += 1.0/(k3 * ck*ck);
         a6 += 1.0/dk;
         a7 += 1.0/k2;
         a8 += alt/dk;
         a9 += alt/(2.0*dk -1.0);
      }
      System.out.printf("%.9f\t(2/3)^k\n", a1);
      System.out.printf("%.9f\tk^-0.5\n", a2);
      System.out.printf("%.9f\t1/k(k+1)\n", a3);
      System.out.printf("%.9f\tFlint Hills\n", a4);
      System.out.printf("%.9f\tCookson Hills\n", a5);
      System.out.printf("%.9f\tHarmonic\n", a6);
      System.out.printf("%.9f\tRiemann Zeta\n", a7);
      System.out.printf("%.9f\tAlternating Harmonic\n", a8);
      System.out.printf("%.9f\tGregory\n", a9);	  
   }
}
