/* The Computer Language Shootout
   http://shootout.alioth.debian.org/
   contributed by Isaac Gouy
*/

// This is an un-optimised example implementation, it doesn't use caching 


import scala.collection.mutable._

object meteor {
   def main(args: Array[String]) = {
      val n = if (args.length > 0) Integer.parseInt(args(0)) else 0

      val solver = new Solver
      solver.enoughSolutions = n
      solver.findSolutions
      solver.printSolutions
   }
}




// Solver.scala 
// import scala.collection.mutable._

class Solver () {
   var enoughSolutions = 0

   protected var solutions = new ListBuffer[String]
   protected val board = new Board()

   protected val pieces = new ArrayBuffer[Piece] ++ 
      Array( new Piece(0), new Piece(1), new Piece(2), new Piece(3), new Piece(4), 
             new Piece(5), new Piece(6), new Piece(7), new Piece(8), new Piece(9) )


   def findSolutions(): Unit = {
      if (weHaveEnoughSolutions) return

      if (pieces.length > 0){
         val emptyCellIndex = board.firstEmptyCellIndex

         for (val k <- Iterator.range(0,pieces.length)){
            val p = pieces(k)
            pieces.remove(k)

            for (val i <- Iterator.range(0,Piece.nPermutations)){
               val piece = p.nextPermutation

               for (val j <- Iterator.range(0,Piece.size)){
                  if (board.add(j,emptyCellIndex,piece)) {

                     /* We have now put a piece on the board, so we have to
                        continue this process with the next piece by recursively
                        calling the solve() method. */

                     if (!shouldPrune) findSolutions

                     /* We're back from the recursion and we have to continue
                        searching at this level, so we remove the piece we
                        just added from the board. */

                     board.remove(piece)
                  }
                  // else the permutation doesn't fit on the board
               }
            }
            // we're done with this piece
            pieces.insert(k,p)
         }
      }
      else {
         puzzleSolved
      }
   }


   protected def weHaveEnoughSolutions() = 
      enoughSolutions > 0 && solutions.length >= enoughSolutions 

   protected def puzzleSolved() = solutions += board.asString

   protected def shouldPrune(): Boolean = {
      board.unmark
      //board.cells.forall(c => c.islandSize % Piece.size == 0) 

      for (val i <- Iterator.range(0,Board.size))
         if (board.cells(i).islandSize % Piece.size != 0) return true

      return false
   }


   def printSolutions() = {

      def printBoard(s: String) = {
         var indent = false
         var i = 0
         while (i < s.length){
            if (indent) Console.print(' ')
            for (val j <- Iterator.range(0,Board.cols)){
               Console.print(s.charAt(i)); Console.print(' ')
               i = i + 1
            }
            Console.print('\n')
            indent = !indent
         }
         Console.print('\n')
      }

      Console.print(solutions.length + " solutions found\n\n")
      solutions.toList .sort((a,b) => a < b) .foreach(s => printBoard(s))
   }

}




// Board.scala
// import scala.collection.mutable._

object Board {
   val cols = 5
   val rows = 10
   val size = rows * cols
}

class Board { 
   val cells = boardCells()

   def unmark() = for (val c <- cells) c.unmark

   def asString() = 
      new String( cells map( 
         c => if (c.piece == null) '-'.toByte 
              else (c.piece.number + 48).toByte ))

   def firstEmptyCellIndex(): Int = {
      for (val i <- Iterator.range(0,cells.length)){
         if (cells(i).isEmpty) return i
      }
      -1
   }


   def add(pieceIndex: Int, boardIndex: Int, p: Piece): Boolean = {
      val pCell = p.cells(pieceIndex)
      val bCell = cells(boardIndex)
      val occupiedCells = new ArrayBuffer[BoardCell]
      p.unmark
    
      accumulate(occupiedCells,pCell,bCell)

      if (occupiedCells.length != Piece.size) return false

      for (val i <- Iterator.range(0,occupiedCells.length))
         if (!occupiedCells(i).isEmpty) return false

      occupiedCells.foreach(c => c.piece = p)

      return true
   }

   def remove(piece: Piece) = for (val c <- cells; c.piece == piece) c.empty

   protected def accumulate(occupiedCells: ArrayBuffer[BoardCell], 
         p: PieceCell, b: BoardCell): Unit = {

      if (p != null && !p.marked && b != null){
         occupiedCells += b

         // Neighbouring cells can form loops, which would lead to an
	 // infinite recursion. Avoid this by marking the processed cells. 

         p.mark

         // repeat for each neighbour of the piece cell

         for (val i <- Iterator.range(0,Cell.sides))
            accumulate(occupiedCells, p.next(i), b.next(i))
      }
   }


   protected def boardCells() = {
      type Row = List[BoardCell]
      type Edges = List[Pair[BoardCell,BoardCell]]

      val cols = Board.cols

      def rowAsEdges(row: Row, indent: Boolean) = {
         val e = row.take(cols-1) zip( row.drop(1) )
         if (indent) 
            Pair(null, e.head._1) :: e 
         else 
            e ::: List( Pair(e.last._2, null) )      
      }

      def joinEdgesNS(prev: Edges, row: Edges, indent: Boolean) =
         (prev zip row).foreach(
            pair => pair match {
               case Pair(Pair(a1,a2),Pair(b1,b2)) => 
                  if (indent){
                     b2.next(Cell.NW) = a1
                     b2.next(Cell.NE) = a2
                     a1.next(Cell.SE) = b2
                     if (a2 != null) a2.next(Cell.SW) = b2
                  } else {
                     b1.next(Cell.NW) = a1
                     b1.next(Cell.NE) = a2
                     a2.next(Cell.SW) = b1
                     if (a1 != null) a1.next(Cell.SE) = b1
                  }               
            } ) 

      def joinEdgesWE(row: Edges) = 
         row.foreach( 
            pair => pair match {
               case Pair(a,b) => {
                  if (a != null) a.next(Cell.E) = b
                  if (b != null) b.next(Cell.W) = a 
               }
            } ) 

      def makeBoardFromCellRows(prev: Edges, rows: List[Row], indent: Boolean): Unit = 
         rows match {
            case Nil => {}
            case r :: rs => {
               val current = rowAsEdges(r,indent)
               if (prev != Nil) joinEdgesNS(prev,current,indent) 
               joinEdgesWE(current)
               makeBoardFromCellRows(current,rs,!indent) 
            }
         }

      // a temporary list of lists of BoardCell representing the board
      val rows = 
         for (val i<- List.range(0,Board.rows)) 
            yield 
               for (val j <- List.range(0,cols)) yield new BoardCell(i*cols + j)

      makeBoardFromCellRows(Nil,rows,false)

      List.flatten(rows).toArray
   }


/*
// Printing all the board cells and their neighbours
// helps check that they are connected properly

   def printBoardCellsAndNeighbours() = {
      Console.println("cell\tNW NE W  E  SW SE")
      for (val i <- Iterator.range(0,Board.size)){
         Console.print(i + "\t")
         for (val j <- Iterator.range(0,Cell.sides)){
            val c = cells(i).next(j)
            if (c == null) 
               Console.print("-- ") 
            else 
               Console.printf("{0,number,00} ")(c.number)
         }
         Console.println("")
      }
      Console.println("")
   }
*/

}




// Piece.scala

object Piece {
   val size = 5
   val nPermutations = 12
}

class Piece(_number: Int) {
   val number = _number
   val cells = for (val i <- Array.range(0,Piece.size)) yield new PieceCell()

   { 
      number match {
         case 0 => initializePiece0
         case 1 => initializePiece1
         case 2 => initializePiece2
         case 3 => initializePiece3
         case 4 => initializePiece4
         case 5 => initializePiece5
         case 6 => initializePiece6
         case 7 => initializePiece7
         case 8 => initializePiece8
         case 9 => initializePiece9     
      }
   }

   def flip() = for (val c <- cells) c.flip
   def rotate() = for (val c <- cells) c.rotate
   def unmark() = for (val c <- cells) c.unmark


   var permIndex: Int = _

   def nextPermutation() = {
      if (permIndex == Piece.nPermutations) permIndex = 0
      if (permIndex % 6 == 0) flip else rotate
      permIndex = permIndex + 1
      this
   }


   def initializePiece0() = {
      cells(0).next(Cell.E) = cells(1)
      cells(1).next(Cell.W) = cells(0)
      cells(1).next(Cell.E) = cells(2)
      cells(2).next(Cell.W) = cells(1)
      cells(2).next(Cell.E) = cells(3)
      cells(3).next(Cell.W) = cells(2)
      cells(3).next(Cell.SE) = cells(4)
      cells(4).next(Cell.NW) = cells(3)
   }

   def initializePiece1() = {
      cells(0).next(Cell.SE) = cells(1)
      cells(1).next(Cell.NW) = cells(0)
      cells(1).next(Cell.SW) = cells(2)
      cells(2).next(Cell.NE) = cells(1)
      cells(2).next(Cell.W) = cells(3)
      cells(3).next(Cell.E) = cells(2)
      cells(3).next(Cell.SW) = cells(4)
      cells(4).next(Cell.NE) = cells(3)
   }

   def initializePiece2() = {
      cells(0).next(Cell.W) = cells(1)
      cells(1).next(Cell.E) = cells(0)
      cells(1).next(Cell.SW) = cells(2)
      cells(2).next(Cell.NE) = cells(1)
      cells(2).next(Cell.SE) = cells(3)
      cells(3).next(Cell.NW) = cells(2)
      cells(3).next(Cell.SE) = cells(4)
      cells(4).next(Cell.NW) = cells(3)
   }

   def initializePiece3() = {
      cells(0).next(Cell.SW) = cells(1)
      cells(1).next(Cell.NE) = cells(0)
      cells(1).next(Cell.W) = cells(2)
      cells(2).next(Cell.E) = cells(1)
      cells(1).next(Cell.SW) = cells(3)
      cells(3).next(Cell.NE) = cells(1)
      cells(2).next(Cell.SE) = cells(3)
      cells(3).next(Cell.NW) = cells(2)
      cells(3).next(Cell.SE) = cells(4)
      cells(4).next(Cell.NW) = cells(3)
   }

   def initializePiece4() = {
      cells(0).next(Cell.SE) = cells(1)
      cells(1).next(Cell.NW) = cells(0)
      cells(1).next(Cell.SW) = cells(2)
      cells(2).next(Cell.NE) = cells(1)
      cells(1).next(Cell.E) = cells(3)
      cells(3).next(Cell.W) = cells(1)
      cells(3).next(Cell.SE) = cells(4)
      cells(4).next(Cell.NW) = cells(3)
   }

   def initializePiece5() = {
      cells(0).next(Cell.SW) = cells(1)
      cells(1).next(Cell.NE) = cells(0)
      cells(0).next(Cell.SE) = cells(2)
      cells(2).next(Cell.NW) = cells(0)
      cells(1).next(Cell.SE) = cells(3)
      cells(3).next(Cell.NW) = cells(1)
      cells(2).next(Cell.SW) = cells(3)
      cells(3).next(Cell.NE) = cells(2)
      cells(3).next(Cell.SW) = cells(4)
      cells(4).next(Cell.NE) = cells(3)
   }

   def initializePiece6() = {
      cells(0).next(Cell.SW) = cells(1)
      cells(1).next(Cell.NE) = cells(0)
      cells(2).next(Cell.SE) = cells(1)
      cells(1).next(Cell.NW) = cells(2)
      cells(1).next(Cell.SE) = cells(3)
      cells(3).next(Cell.NW) = cells(1)
      cells(3).next(Cell.SW) = cells(4)
      cells(4).next(Cell.NE) = cells(3)
   }

   def initializePiece7() = {
      cells(0).next(Cell.SE) = cells(1)
      cells(1).next(Cell.NW) = cells(0)
      cells(0).next(Cell.SW) = cells(2)
      cells(2).next(Cell.NE) = cells(0)
      cells(2).next(Cell.SW) = cells(3)
      cells(3).next(Cell.NE) = cells(2)
      cells(3).next(Cell.SE) = cells(4)
      cells(4).next(Cell.NW) = cells(3)
   }

   def initializePiece8() = {
      cells(0).next(Cell.E) = cells(1)
      cells(1).next(Cell.W) = cells(0)
      cells(1).next(Cell.E) = cells(2)
      cells(2).next(Cell.W) = cells(1)
      cells(2).next(Cell.NE) = cells(3)
      cells(3).next(Cell.SW) = cells(2)
      cells(3).next(Cell.E) = cells(4)
      cells(4).next(Cell.W) = cells(3)
   }

   def initializePiece9() = {
      cells(0).next(Cell.E) = cells(1)
      cells(1).next(Cell.W) = cells(0)
      cells(1).next(Cell.E) = cells(2)
      cells(2).next(Cell.W) = cells(1)
      cells(2).next(Cell.NE) = cells(3)
      cells(3).next(Cell.SW) = cells(2)
      cells(2).next(Cell.E) = cells(4)
      cells(4).next(Cell.W) = cells(2)
      cells(4).next(Cell.NW) = cells(3)
      cells(3).next(Cell.SE) = cells(4)
   }

}




// Cell.scala

object Cell {
   val NW = 0; val NE = 1
   val W  = 2; val E  = 3
   val SW = 4; val SE = 5   

   val sides = 6
}

abstract class Cell {
   type T
   val next = new Array[T](Cell.sides)
   var marked = false

   def mark() = marked = true
   def unmark() = marked = false
}




// BoardCell.scala

class BoardCell(_number: Int) extends Cell {
   type T = BoardCell
   val number = _number
   var piece: Piece = _

   def isEmpty() = piece == null
   def empty() = piece = null

   def islandSize(): Int = {
      if (!marked && isEmpty){
         mark
         var count = 1 

         for (val neighbour <- next)
            if (neighbour != null && neighbour.isEmpty) 
               count = count + neighbour.islandSize

         count } else { 0 }
   }
}




// PieceCell.scala

class PieceCell extends Cell {
   type T = PieceCell

   def flip = {
      var swap = next(Cell.NE)
      next(Cell.NE) = next(Cell.NW)
      next(Cell.NW) = swap

      swap = next(Cell.E)
      next(Cell.E) = next(Cell.W)
      next(Cell.W) = swap

      swap = next(Cell.SE)
      next(Cell.SE) = next(Cell.SW)
      next(Cell.SW) = swap
   }

   def rotate = {
      var swap = next(Cell.E)
      next(Cell.E) = next(Cell.NE)
      next(Cell.NE) = next(Cell.NW)
      next(Cell.NW) = next(Cell.W)
      next(Cell.W) = next(Cell.SW)
      next(Cell.SW) = next(Cell.SE)
      next(Cell.SE) = swap
   }
}




