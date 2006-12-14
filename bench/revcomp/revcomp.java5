/*
 * The Computer Language Shootout
 * http://shootout.alioth.debian.org/
 * contributed by Anthony Donnefort
 */

import java.io.*;
import java.util.ArrayList;
import java.util.List;

public class revcomp {
	private static final byte[] comp = new byte[128];
	private static final int LINE_LENGTH = 60;
	private static final byte CR = '\n';
	static {
		for (int i = 0; i < comp.length; i++) comp[i] = (byte) i;
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

	private static int maxInputLineLength = 0;

	// Will add CR then print the input data
	private static void formatAndPrint(List<byte[]> lineBuffer) {
		byte[] data = null;
		int remainOnLine = 0;
		int totalSize = 0;
		int linePointer = 0;
		byte[] printBuffer = new byte[((maxInputLineLength + 1) * lineBuffer.size())];

		for (int i = lineBuffer.size() - 1; i >= 0 ; i--) {
			data = lineBuffer.get(i);
			if (data.length <= (remainOnLine = LINE_LENGTH - linePointer)) {
				System.arraycopy(data, 0, printBuffer, totalSize, data.length);
				linePointer += data.length;
				totalSize += data.length;
			} else {
				linePointer = data.length - remainOnLine;
				System.arraycopy(data, 0, printBuffer, totalSize, remainOnLine);
				printBuffer[totalSize + remainOnLine] = CR;
				System.arraycopy(data, remainOnLine, printBuffer, totalSize + remainOnLine + 1, linePointer);
				totalSize += data.length + 1;
			}
		}
		if (totalSize > 0) printBuffer[totalSize++] = CR;
		System.out.write(printBuffer, 0, totalSize);
		lineBuffer.clear();
	}
	
	public static void main(String[] args) throws IOException {
		byte[] revcompLine = null;
		List<byte[]> revcompBuffer = new ArrayList<byte[]>();

		BufferedReader in = new BufferedReader(new InputStreamReader(System.in));
		for (String line; (line = in.readLine()) != null;) {
			if (line.startsWith(">")) {
				formatAndPrint(revcompBuffer);
				System.out.println(line);
			} else {
				// Keep track of the maximum input line length. We will need that later to allocate a buffer that will not need to be resized.
				if (line.length() > maxInputLineLength) maxInputLineLength = line.length();
				revcompLine = new byte[line.length()];
				int j = line.length() - 1;
				// The line is reversed and complements are calculated here. 
				for (int i = 0; i < line.length() ; i++) revcompLine[i] = comp[line.charAt(j--)];
				revcompBuffer.add(revcompLine);
			}
		}
		formatAndPrint(revcompBuffer);
	}
}
