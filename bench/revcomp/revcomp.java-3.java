/**
 * The Computer Language Benchmarks Game
 * http://shootout.alioth.debian.org/
 * based on c++ g++ solution by Paul Kitchin
 * contributed by Klaus Friedel
 */

import java.io.*;

public class revcomp {
  static final int line_length = 60;
  static final byte[] complement_map = {
      '\0', 'T', 'V', 'G', 'H', '\0', '\0', 'C', 'D', '\0', '\0', 'M', '\0',
      'K', 'N', '\0', '\0', '\0', 'Y', 'S', 'A', 'A', 'B', 'W', '\0', 'R'
      };

  static byte complement(byte character) {
    return complement_map[character & 0x1f];
  }

  static class Chunk {
    Chunk previous;
    Chunk next;
    int length;
    byte[] data = new byte[65526];

    Chunk() {
    }


    Chunk(Chunk previous) {
      this.previous = previous;
      previous.next = this;
    }
  }

  static void write_reverse_complement(OutputStream out, Chunk begin, Chunk end) 
      throws IOException {

    Chunk start = begin;

    int begin_idx = 0;
    int end_idx = end.length - 1;
    while (begin != end || begin_idx < end_idx) {
      byte temp = complement(begin.data[begin_idx]);
      begin.data[begin_idx++] = complement(end.data[end_idx]);
      end.data[end_idx--] = temp;
      if (begin.data[begin_idx] == '\n') {
        ++begin_idx;
      }
      if (begin_idx == begin.length) {
        begin = begin.next;
        begin_idx = 0;
        if (begin.data[begin_idx] == '\n') {
          ++begin_idx;
        }
      }
      if (end_idx == -1) {
        end = end.previous;
        end_idx = end.length - 1;
        if (end.data[end_idx] == '\n') {
          --end_idx;
        }
      } else if (end.data[end_idx] == '\n') {
        --end_idx;
      }

    }
    while (start != null) {
      out.write(start.data, 0, start.length);
      start = start.next;
    }
    out.write('\n');
  }

  static class LineInput {
    InputStream in;
    boolean eof;
    byte[] buffer = new byte[8192];
    int idx = 0;
    int count = 0;

    LineInput(InputStream in) {
      this.in = in;
    }

    void fill() throws IOException {
      if(eof) return;
      if (count > 0) {
        // compact
        System.arraycopy(buffer, idx, buffer, 0, count);
      }
      idx = 0;
      int c = in.read(buffer, count, buffer.length - count);
      if (c == -1){
        eof = true;
      }else{
        count += c;
      }
    }

    public int getline(byte[] data, int offset, int len) throws IOException {
      for (; ;) {
        for (int i = 0; i < count; i++) {
          if (buffer[i + idx] == '\n' || i >= len) {
            System.arraycopy(buffer, idx, data, offset, i);
            int gcount = i+1;
            idx += gcount;
            count -= gcount;
            return gcount;
          }
        }
        if(eof){
          System.arraycopy(buffer, idx, data, offset, count);
          int gcount = count;
          count = 0;
          return gcount;
        }else{
          fill();
        }
      }
    }

    int peek() throws IOException {
      if (count < 1) fill();
      return buffer[idx];
    }

    boolean eof() {
      return eof && count == 0;
    }
  }

  public static void main(String[] args) throws Exception {
    LineInput cin = new LineInput(System.in);

    while (!cin.eof()) {
      byte [] header = new byte[100];
      int c = cin.getline(header, 0, header.length);
      PrintStream out = System.out;
      out.write(header, 0, c - 1);
      out.write('\n');
      Chunk start = new Chunk();
      Chunk end = start;

      while (!cin.eof() && cin.peek() != '>') {
        for (int line = 0; line < 1074 && !cin.eof() && cin.peek() != '>'; ++line) {
          end.length += cin.getline(end.data, end.length, line_length + 1);
          end.data[end.length - 1] = '\n';
        }
        if (!cin.eof() && cin.peek() != '>') {
          end = new Chunk(end);
        }
      }
      --end.length;
      write_reverse_complement(out, start, end);
    }
  }
}
