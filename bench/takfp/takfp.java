public class takfp {
    public static void main(String args[]) {
	int n = Integer.parseInt(args[0]);
	System.out.println( Tak(n*3.0d, n*2.0d, n*1.0d) );
    }

  public static double Tak (double x, double y, double z) {
    if (y >= x) return z;
    else return Tak(Tak(x-1,y,z), Tak(y-1,z,x), Tak(z-1,x,y)); 
  }
}