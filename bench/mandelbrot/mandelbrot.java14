/* The Great Computer Language Shootout
   http://shootout.alioth.debian.org/

   contributed by Lester Vecsey */


class mandelbrot {

	public static void main(String[] args) {

		double Cr, Ci, Tr, Ti, Zr=0, Zi=0, limit_sq = 4.0;
		int max, res, i=0, x=0, y=0, pos=0, acc=1, iter = 50;

		res = (args.length >= 1) ? Integer.parseInt(args[0], 10) : 200;

		byte pbm_data[] = new byte[ ( max = (res * res) >>> 3) ];

		String pbm_header = new String("P4" + ((char) 012) + res + " " + res + ((char) 012));

		System.out.write(pbm_header.getBytes(), 0, pbm_header.length());

		for ( ; pos < max; x%=res, Zr=Zi=i=0) {
						
			Cr = (2*((double)x++)/res - 1.5); Ci=(2*((double)y)/res - 1);

			for(acc<<=1; (acc&1)==0 && i++ < iter; acc |= Zr*Zr+Zi*Zi > limit_sq ? 1 : 0) {

				Tr = Zr*Zr - Zi*Zi + Cr;
				Ti = 2*Zr*Zi + Ci;
				Zr = Tr; Zi = Ti;

				}
			
			if (x==res) { y++; if (acc<256) acc <<= (8-res%8); }

			if (acc>255) { pbm_data [ pos++ ] = (byte) (acc^=255); acc = 1; }
			
			}

		System.out.write( pbm_data, 0, pos);

		}

	}
