// $Id: strcat.csharp,v 1.3 2005-02-22 19:05:07 igouy-guest Exp $
// http://shootout.alioth.debian.org/
//
// code contributed by Erik Saltwell  
// Some clean-ups by Brent Fulgham

using System;

class strcat {

    public static void Main(String[] args)
    {
        int N = int.Parse(args[0]);
        if(N < 1) N = 1;

        System.Text.StringBuilder sb = new System.Text.StringBuilder(32);

        for (int i = 0; i < N; i++) {
            sb.Append("hello\n");
        }

        Console.WriteLine(sb.Length);
    }
}