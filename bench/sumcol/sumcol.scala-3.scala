/* The Computer Language Benchmarks Game
 * http://shootout.alioth.debian.org/
 * contributed by meiko rachimow
 */

import java.io.{BufferedReader, InputStreamReader}

object sumcol {

  def main(args: Array[String]) {
  
    val in = new BufferedReader(
      new InputStreamReader(java.lang.System.in))
    
    var sum = 0
    var line = in.readLine
    
    while (line != null) {
      sum = sum + line.toInt
      line = in.readLine
    }
    
    println(sum)
  }
}
