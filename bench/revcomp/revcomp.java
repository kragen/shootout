/*
 * The Computer Language Shootout
 * http://shootout.alioth.debian.org/
 * contributed by Anthony Donnefort
 */

import java.io.*;

public class revcomp {
	static final char[] comp = new char[128];
	static {
		for (int i = 0; i < comp.length; i++) comp[i] = (char) i;
		comp['t'] = comp['T'] = 'A';
		comp['a'] = comp['A'] = 'T';
		comp['g'] = comp['G'] = 'C';
		comp['c'] = comp['C'] = 'G';
		comp['v'] = comp['V'] = 'B';
		comp['h'] = comp['H'] = 'D';
		comp['r'] = comp['R'] = 'Y';
		comp['m'] = comp['M'] = 'K';
		comp['y'] = comp['Y'] = 'R';
		comp['k'] = comp['K'] = 'M';
		comp['b'] = comp['B'] = 'V';
		comp['d'] = comp['D'] = 'H';
		comp['u'] = comp['U'] = 'A';
	}

	private static void reverseAndInsertCR(StringBuffer buf) {
		buf.reverse();
		for (int i = 60; i < buf.length(); i += 61) buf.insert(i, '\n');
		if (buf.length() != 0) buf.append('\n');
	}

	public static void main(String[] args) throws IOException {
		BufferedReader in = new BufferedReader(new InputStreamReader(System.in));
		StringBuffer buf = new StringBuffer();
		for (String line; (line = in.readLine()) != null;)
			if (line.startsWith(">")) {
				reverseAndInsertCR(buf);
				buf.append(line); buf.append('\n');
				System.out.append(buf);
				buf.delete(0, buf.length());
			} else for (int i = 0; i < line.length(); i++) buf.append(comp[line.charAt(i)]);
		reverseAndInsertCR(buf);
		System.out.append(buf);
	}
}