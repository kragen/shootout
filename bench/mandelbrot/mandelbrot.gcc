/* The Great Computer Language Shootout
   http://shootout.alioth.debian.org/

   contributed by Greg Buchholz

   compile:  gcc -O2 -o mandelbrot mandelbrot.c
   run:      mandelbrot 200 > out.pbm
*/


#include<stdio.h>

int main (int argc, char **argv)
{
    int w, h, x, y, bit_num = 0;
    char byte_acc = 0;
    int i, iter = 50;
    double limit = 2.0;
    double Zr, Zi, Cr, Ci, Tr, Ti;
    
    w = atoi(argv[1]);
    h = w;

    printf("P4\n%d %d\n",w,h);

    for(y=0;y<h;y++) 
    {
        for(x=0;x<w;x++)
        {
            Zr = 0.0; Zi = 0.0;
            Cr = (2*(double)x/w - 1.5); Ci=(2*(double)y/h - 1);
        
            for (i=0;i<iter;i++)
            {
                Tr = Zr*Zr - Zi*Zi + Cr;
                Ti = 2*Zr*Zi + Ci;
                Zr = Tr; Zi = Ti;
                if (Zr*Zr+Zi*Zi > limit*limit)
                    break;
            }
        
            if(Zr*Zr+Zi*Zi > limit*limit) 
                byte_acc = (byte_acc << 1) | 0x00;
            else
                byte_acc = (byte_acc << 1) | 0x01;
                
            bit_num++; 

            if(bit_num == 8)
            {
                putc(byte_acc,stdout);
                byte_acc = 0;
                bit_num = 0;
            }
            else if(x == w-1)
            {
                byte_acc = byte_acc << (8-w%8);
                putc(byte_acc,stdout);
                byte_acc = 0;
                bit_num = 0;
            }

        }
    }	

    return(0);
}