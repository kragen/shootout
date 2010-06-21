/* The Computer Language Benchmarks Game
   http://shootout.alioth.debian.org/
   original contributed by Isaac Gouy
   made to use single array and parallelized by Stephen Marsh
   converted to Scala 2.8 by Rex Kerr
*/

import java.io.BufferedOutputStream

object mandelbrot {
  var size: Int = 0
  var bytesPerRow: Int = 0
  var bitmap: Array[Byte] = _
  var donerows: Array[Boolean] = _
  var nextRow = 0
  val limitSquared = 4.0
  val max = 50

  def getNextRow: Int = synchronized {
    notify() // wakes up main thread
    if (nextRow == size) return -1
    nextRow += 1
    return nextRow - 1
  }

  def main(args: Array[String]) {
    size = args(0).toInt
    bytesPerRow = (size+7)/8 // ceiling of (size / 8)
    bitmap = new Array(bytesPerRow*size)
    donerows = new Array(size)

    for (i <- 0 until Runtime.getRuntime().availableProcessors())
      new Thread(new CalcThread()).start()

    // main thread prints rows as they finish
    println("P4\n" + size + " " + size)
    val w = new BufferedOutputStream(System.out)
    var y = 0
    while (y < size) {
      while (!donerows(y)) synchronized{wait()}
      w.write(bitmap, y * bytesPerRow, bytesPerRow)
      y += 1
    }
    w.close
  }

  class CalcThread extends Runnable {
    def run () {
      while (true) {
	var y = getNextRow
	if (y == -1) return

	var bits = 0
	var bitnum = 0
	var x = 0
	var aindex = y * bytesPerRow

	while (x < size) {

        val cr = 2.0 * x / size - 1.5
        val ci = 2.0 * y / size - 1.0

        var zr, tr, zi, ti = 0.0

        var j = max
            do {
              zi = 2.0 * zr * zi + ci
              zr = tr - ti + cr
              ti = zi*zi
              tr = zr*zr

              j = j - 1
            } while (!(tr + ti > limitSquared) && j > 0)

         bits = bits << 1
         if (!(tr + ti > limitSquared)) bits += 1
         bitnum += 1

         if (x == size - 1) {
           bits = bits << (8 - bitnum)
           bitnum = 8
         }

         if (bitnum == 8) {
           bitmap(aindex) = bits.toByte
	   aindex += 1
           bits = 0
           bitnum = 0
         }

         x += 1
	}
	donerows(y) = true
      }
    }
  }
}
