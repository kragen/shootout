(* The Computer Language Shootout
   http://shootout.alioth.debian.org
   contributed by Isaac Gouy (Oberon-2 novice)
*)


MODULE meteor;
IMPORT Shootout, Out;

CONST
   NW = 0; NE = 1; W = 2; E = 3; SW = 4; SE = 5;
   SIDES = 6;

   BOARD_COLS = 5;
   BOARD_ROWS = 10;
   BOARD_SIZE = BOARD_COLS * BOARD_ROWS;

   PIECES = 10;
   PIECE_SIZE = 5;
   PIECE_ROTATIONS = SIDES;
   PIECE_FLIPS = 2;
   PIECE_ORIENTATIONS = PIECE_ROTATIONS * PIECE_FLIPS;


TYPE
   Cell = POINTER TO CellDesc;
   CellDesc =
      RECORD
         marked : BOOLEAN; 
      END;

   PieceCell = POINTER TO PieceCellDesc;
   PieceCellDesc = 
      RECORD (CellDesc)
         next : ARRAY SIDES OF PieceCell; 
      END;

   PieceShape = ARRAY PIECE_SIZE OF PieceCell;
   PieceCache = ARRAY PIECE_ORIENTATIONS OF PieceShape;

   Piece = POINTER TO PieceDesc;
   PieceDesc = 
      RECORD 
         number : LONGINT;
         orientation : LONGINT;
         cache : PieceCache;
      END;

   BoardCell = POINTER TO BoardCellDesc;
   BoardCellDesc = 
      RECORD (CellDesc)
         next : ARRAY SIDES OF BoardCell; 
         number : LONGINT;
         piece: Piece;
      END;


   BoardPieceShape = ARRAY PIECE_SIZE OF BoardCell;
   BoardPiece = POINTER TO BoardPieceShape;
   BoardCache = ARRAY 
      PIECES, PIECE_ORIENTATIONS, PIECE_SIZE, BOARD_SIZE OF BoardPiece;

   Board =
      RECORD
         cells : ARRAY BOARD_SIZE OF BoardCell;
         cellsPieceWillFill : BoardPieceShape;
         cellCount : LONGINT; 
         cache : BoardCache;
      END;

   BoardPieces = ARRAY BOARD_SIZE OF LONGINT;


VAR
   countdown, n : LONGINT;
   board : Board;
   pieces : ARRAY PIECES OF Piece;
   unplaced : SET;
   first, last, current: BoardPieces;
   once : BOOLEAN;
   noFit : BoardPiece;


PROCEDURE (c: Cell) INIT* (); BEGIN c.marked := FALSE; END INIT;


PROCEDURE (c: Cell) Mark (); BEGIN c.marked := TRUE; END Mark;


PROCEDURE (c: Cell) Unmark (); BEGIN c.marked := FALSE; END Unmark;


PROCEDURE (c: BoardCell) INIT* (i: LONGINT);
BEGIN c.INIT^(); c.number := i; END INIT;


PROCEDURE (c: BoardCell) Empty (); BEGIN c.piece := NIL; END Empty;


PROCEDURE (c: BoardCell) IsEmpty () : BOOLEAN; 
BEGIN RETURN c.piece = NIL; END IsEmpty;


PROCEDURE (c: BoardCell) ContiguousEmptyCells () : LONGINT; 
VAR
   count, i : LONGINT;
   neighbour : BoardCell;
BEGIN 
   IF ~c.marked & c.IsEmpty() THEN
      c.Mark(); 
      count := 1;
      FOR i := 0 TO SIDES - 1 DO
         neighbour := c.next[i];
         IF (neighbour # NIL) & neighbour.IsEmpty() THEN
            INC(count, neighbour.ContiguousEmptyCells());
         END;
      END;
   ELSE
      count := 0;
   END;
   RETURN count; 
END ContiguousEmptyCells;


PROCEDURE (c: PieceCell) Flip (); 
VAR
   swap : PieceCell;
BEGIN
   swap := c.next[NE];
   c.next[NE] := c.next[NW];
   c.next[NW] := swap;

   swap := c.next[E];
   c.next[E] := c.next[W];
   c.next[W] := swap;

   swap := c.next[SE];
   c.next[SE] := c.next[SW];
   c.next[SW] := swap; 
END Flip;


PROCEDURE (c: PieceCell) Rotate (); 
VAR
   swap : PieceCell;
BEGIN 
   swap := c.next[E];
   c.next[E] := c.next[NE];
   c.next[NE] := c.next[NW];
   c.next[NW] := c.next[W];
   c.next[W] := c.next[SW];
   c.next[SW] := c.next[SE];
   c.next[SE] := swap; 
END Rotate;


PROCEDURE (p: Piece) Make0 (VAR a : PieceShape);
BEGIN
   a[0].next[E] := a[1];
   a[1].next[W] := a[0];
   a[1].next[E] := a[2];
   a[2].next[W] := a[1];
   a[2].next[E] := a[3];
   a[3].next[W] := a[2];
   a[3].next[SE] := a[4];
   a[4].next[NW] := a[3];
END Make0;


PROCEDURE (p: Piece) Make1 (VAR a : PieceShape);
BEGIN
   a[0].next[SE] := a[1];
   a[1].next[NW] := a[0];
   a[1].next[SW] := a[2];
   a[2].next[NE] := a[1];
   a[2].next[W] := a[3];
   a[3].next[E] := a[2];
   a[3].next[SW] := a[4];
   a[4].next[NE] := a[3];
END Make1;


PROCEDURE (p: Piece) Make2 (VAR a : PieceShape);
BEGIN
   a[0].next[W] := a[1];
   a[1].next[E] := a[0];
   a[1].next[SW] := a[2];
   a[2].next[NE] := a[1];
   a[2].next[SE] := a[3];
   a[3].next[NW] := a[2];
   a[3].next[SE] := a[4];
   a[4].next[NW] := a[3];
END Make2;


PROCEDURE (p: Piece) Make3 (VAR a : PieceShape);
BEGIN
   a[0].next[SW] := a[1];
   a[1].next[NE] := a[0];
   a[1].next[W] := a[2];
   a[2].next[E] := a[1];
   a[1].next[SW] := a[3];
   a[3].next[NE] := a[1];
   a[2].next[SE] := a[3];
   a[3].next[NW] := a[2];
   a[3].next[SE] := a[4];
   a[4].next[NW] := a[3];
END Make3;


PROCEDURE (p: Piece) Make4 (VAR a : PieceShape);
BEGIN
   a[0].next[SE] := a[1];
   a[1].next[NW] := a[0];
   a[1].next[SW] := a[2];
   a[2].next[NE] := a[1];
   a[1].next[E] := a[3];
   a[3].next[W] := a[1];
   a[3].next[SE] := a[4];
   a[4].next[NW] := a[3];
END Make4;


PROCEDURE (p: Piece) Make5 (VAR a : PieceShape);
BEGIN
   a[0].next[SW] := a[1];
   a[1].next[NE] := a[0];
   a[0].next[SE] := a[2];
   a[2].next[NW] := a[0];
   a[1].next[SE] := a[3];
   a[3].next[NW] := a[1];
   a[2].next[SW] := a[3];
   a[3].next[NE] := a[2];
   a[3].next[SW] := a[4];
   a[4].next[NE] := a[3];
END Make5;


PROCEDURE (p: Piece) Make6 (VAR a : PieceShape);
BEGIN
   a[0].next[SW] := a[1];
   a[1].next[NE] := a[0];
   a[2].next[SE] := a[1];
   a[1].next[NW] := a[2];
   a[1].next[SE] := a[3];
   a[3].next[NW] := a[1];
   a[3].next[SW] := a[4];
   a[4].next[NE] := a[3];
END Make6;


PROCEDURE (p: Piece) Make7 (VAR a : PieceShape);
BEGIN
   a[0].next[SE] := a[1];
   a[1].next[NW] := a[0];
   a[0].next[SW] := a[2];
   a[2].next[NE] := a[0];
   a[2].next[SW] := a[3];
   a[3].next[NE] := a[2];
   a[3].next[SE] := a[4];
   a[4].next[NW] := a[3];
END Make7;


PROCEDURE (p: Piece) Make8 (VAR a : PieceShape);
BEGIN
   a[0].next[E] := a[1];
   a[1].next[W] := a[0];
   a[1].next[E] := a[2];
   a[2].next[W] := a[1];
   a[2].next[NE] := a[3];
   a[3].next[SW] := a[2];
   a[3].next[E] := a[4];
   a[4].next[W] := a[3];
END Make8;


PROCEDURE (p: Piece) Make9 (VAR a : PieceShape);
BEGIN
   a[0].next[E] := a[1];
   a[1].next[W] := a[0];
   a[1].next[E] := a[2];
   a[2].next[W] := a[1];
   a[2].next[NE] := a[3];
   a[3].next[SW] := a[2];
   a[2].next[E] := a[4];
   a[4].next[W] := a[2];
   a[4].next[NW] := a[3];
   a[3].next[SE] := a[4];
END Make9;


PROCEDURE (p: Piece) INIT* (n: LONGINT);
VAR
   i, j, k : LONGINT;
BEGIN
   p.orientation := 0;
   p.number := n;

   FOR k := 0 TO PIECE_ORIENTATIONS - 1 DO
      FOR i := 0 TO PIECE_SIZE - 1 DO p.cache[k][i] := NEW(PieceCell); END; 

      CASE n OF
         0 : p.Make0( p.cache[k] );
      |  1 : p.Make1( p.cache[k] );
      |  2 : p.Make2( p.cache[k] );
      |  3 : p.Make3( p.cache[k] );
      |  4 : p.Make4( p.cache[k] );
      |  5 : p.Make5( p.cache[k] );
      |  6 : p.Make6( p.cache[k] );
      |  7 : p.Make7( p.cache[k] );
      |  8 : p.Make8( p.cache[k] );
      |  9 : p.Make9( p.cache[k] );
      END; 

      FOR i := 0 TO k - 1 DO
         IF (i MOD PIECE_ROTATIONS) = 0 THEN 
            FOR j := 0 TO PIECE_SIZE - 1 DO p.cache[k][j].Flip(); END;
         ELSE 
            FOR j := 0 TO PIECE_SIZE - 1 DO p.cache[k][j].Rotate(); END;
         END;
      END;
   END; 
END INIT;


PROCEDURE (p: Piece) Unmark ();
VAR i : LONGINT;
BEGIN 
   FOR i := 0 TO PIECE_SIZE - 1 DO p.cache[p.orientation][i].Unmark(); END; 
END Unmark;


PROCEDURE (p: Piece) NextOrientation () : Piece;
BEGIN 
   p.orientation := (p.orientation + 1) MOD PIECE_ORIENTATIONS;
   RETURN p;
END NextOrientation;


PROCEDURE (p: Piece) cells (i : LONGINT) : PieceCell; 
BEGIN RETURN p.cache[p.orientation][i]; END cells;


PROCEDURE (VAR b: Board) Initialize ();
VAR
   i, row, m : LONGINT;
   c : BoardCell;
   isFirst, isLast : BOOLEAN;
BEGIN
   b.cellCount := 0;
   FOR i := 0 TO BOARD_SIZE - 1 DO b.cells[i] := NEW(BoardCell,i); END;
   m := (BOARD_SIZE DIV BOARD_COLS) - 1;

   FOR i := 0 TO BOARD_SIZE - 1 DO
      row := i DIV BOARD_COLS;
      isFirst := i MOD BOARD_COLS = 0; 
      isLast := (i+1) MOD BOARD_COLS = 0;
      c := b.cells[i];

      IF ODD(row) THEN
         IF ~isLast THEN
            c.next[NE] := b.cells[i - (BOARD_COLS - 1)];
         END;
         c.next[NW] := b.cells[i - BOARD_COLS];

         IF row # m THEN 
            IF ~isLast THEN 
               c.next[SE] := b.cells[i + BOARD_COLS + 1];
            END;
            c.next[SW] := b.cells[i + BOARD_COLS];
         END; 
      ELSE
         IF row # 0 THEN
            IF ~isFirst THEN
               c.next[NW] := b.cells[i - (BOARD_COLS + 1)];
            END;
            c.next[NE] := b.cells[i - BOARD_COLS];
         END;

         IF row # m THEN
            IF ~isFirst THEN
               c.next[SW] := b.cells[i + (BOARD_COLS - 1)];
            END;
            c.next[SE] := b.cells[i + BOARD_COLS];
         END;  
      END;
      IF ~isFirst THEN c.next[W] := b.cells[i - 1]; END;
      IF ~isLast THEN c.next[E] := b.cells[i + 1]; END;
   END;  
END Initialize;


PROCEDURE (VAR b: Board) Unmark ();
VAR i : LONGINT;
BEGIN FOR i := 0 TO BOARD_SIZE - 1 DO b.cells[i].Unmark(); END; END Unmark;


PROCEDURE (VAR b: Board) FirstEmptyCellIndex () : LONGINT;
VAR i : LONGINT;
BEGIN 
   FOR i := 0 TO BOARD_SIZE - 1 DO 
      IF b.cells[i].IsEmpty() THEN RETURN i; END;
   END; 
   RETURN -1;
END FirstEmptyCellIndex;


PROCEDURE (VAR b: Board) Remove (p: Piece);
VAR i : LONGINT;
BEGIN 
   FOR i := 0 TO BOARD_SIZE - 1 DO 
      IF b.cells[i].piece = p THEN b.cells[i].piece := NIL; END;
   END; 
END Remove;


PROCEDURE (VAR b: Board) Find (p: PieceCell; c: BoardCell);
VAR i : LONGINT;
BEGIN 
   IF (p # NIL) & ~p.marked & (c # NIL) THEN
      b.cellsPieceWillFill[b.cellCount] := c;
      INC(b.cellCount);
      p.Mark();
      FOR i := 0 TO SIDES - 1 DO 
         b.Find(p.next[i],c.next[i]);
      END; 
   END;
END Find;


PROCEDURE (VAR b: Board) Add (
      pieceIndex: LONGINT; boardIndex: LONGINT; p: Piece) : BOOLEAN;
VAR 
   i : LONGINT;
   a : BoardPiece;
BEGIN 
   a := b.cache[p.number][p.orientation][pieceIndex][boardIndex];

   b.cellCount := 0;
   p.Unmark();

   IF a = NIL THEN
      b.Find(p.cells(pieceIndex), b.cells[boardIndex]);

      IF b.cellCount # PIECE_SIZE THEN
         b.cache[p.number][p.orientation][pieceIndex][boardIndex] := noFit;
         RETURN FALSE;
      END;

      NEW(a); 
      FOR i := 0 TO PIECE_SIZE - 1 DO a[i] := b.cellsPieceWillFill[i]; END;
      b.cache[p.number][p.orientation][pieceIndex][boardIndex] := a;
   ELSE
      IF a = noFit THEN RETURN FALSE; END;
   END;
   FOR i := 0 TO PIECE_SIZE - 1 DO 
      IF ~a[i].IsEmpty() THEN RETURN FALSE; END;
   END;

   FOR i := 0 TO PIECE_SIZE - 1 DO a[i].piece := p; END;
   RETURN TRUE;
END Add;


PROCEDURE Initialize ();
VAR 
   i : LONGINT;
BEGIN
   board.Initialize(); 
   FOR i := 0 TO LEN(pieces) - 1 DO pieces[i] := NEW(Piece,i); END;
   unplaced := {0..LEN(pieces)-1};
   once := TRUE;
   NEW(noFit);
END Initialize;


PROCEDURE UpdateFirstLast ();
VAR 
   i, n : LONGINT;
   lessFirst, moreFirst, lessLast, moreLast : BOOLEAN;

   PROCEDURE CopyTo(VAR a : BoardPieces);
   BEGIN FOR i := 0 TO BOARD_SIZE - 1 DO a[i] := current[i]; END; END CopyTo;
BEGIN 
   IF once THEN
      FOR i := 0 TO BOARD_SIZE - 1 DO
         n := board.cells[i].piece.number; first[i] := n; last[i] := n;
      END;
      once := FALSE;
   ELSE
      lessFirst := FALSE; moreFirst := FALSE;
      lessLast := FALSE; moreLast := FALSE;
      FOR i := 0 TO BOARD_SIZE - 1 DO
         n := board.cells[i].piece.number;

         IF ~moreFirst & ~lessFirst & (n < first[i]) THEN 
            lessFirst := TRUE; 
         ELSIF (n > first[i]) THEN
            moreFirst := TRUE;
         END;
         IF ~lessLast & ~moreLast & (n > last[i]) THEN 
            moreLast := TRUE;  
         ELSIF (n < last[i]) THEN
            lessLast := TRUE; 
         END;
         current[i] := n;
      END;
      IF lessFirst THEN CopyTo(first); END; 
      IF moreLast THEN CopyTo(last); END;  
   END;
END UpdateFirstLast;


PROCEDURE PrintSolutions ();
   PROCEDURE PrintBoard (a : BoardPieces);
   VAR
      indent : BOOLEAN;
      i, j : LONGINT;
   BEGIN
      indent := FALSE;
      i := 0;
      WHILE i < LEN(a) DO
         IF indent THEN Out.Char(' '); END;
         FOR j := 0 TO BOARD_COLS - 1 DO 
            Out.Char(CHR(a[i] + 48)); Out.Char(' '); 
            INC(i);
         END;
         Out.Ln;
         indent := ~indent;
      END; 
      Out.Ln;
   END PrintBoard;
BEGIN
   Out.Int(n,1); Out.String(" solutions found"); Out.Ln; Out.Ln;
   PrintBoard(first);
   PrintBoard(last);
END PrintSolutions;


PROCEDURE PuzzleSolved ();
BEGIN
   UpdateFirstLast();
   DEC(countdown);
END PuzzleSolved;


PROCEDURE ShouldPrune () : BOOLEAN;
VAR 
   i : LONGINT;
   forall : BOOLEAN;
BEGIN
   board.Unmark(); 
   FOR i := 0 TO BOARD_SIZE - 1 DO
      forall := (board.cells[i].ContiguousEmptyCells() MOD PIECE_SIZE) = 0;
      IF ~forall THEN RETURN ~forall; END;
   END;
   RETURN ~forall;
END ShouldPrune;


PROCEDURE FindSolutions ();
VAR
   emptyCellIndex, k, i, j : LONGINT;   
   piece : Piece;
BEGIN
   IF countdown > 0 THEN
      IF unplaced # {} THEN
         emptyCellIndex := board.FirstEmptyCellIndex();

         FOR k := 0 TO LEN(pieces) - 1 DO
            IF k IN unplaced THEN
               unplaced := unplaced - {k};

               FOR i := 0 TO PIECE_ORIENTATIONS - 1 DO
                  piece := pieces[k].NextOrientation();  
                  FOR j := 0 TO PIECE_SIZE - 1 DO
                     IF board.Add(j,emptyCellIndex,piece) THEN
                        IF ~ShouldPrune() THEN FindSolutions(); END;
                        board.Remove(piece); 
                     END;
                  END; 
               END; 
               unplaced := unplaced + {k};
            END;
         END;
      ELSE
         PuzzleSolved();
      END;
   END;
END FindSolutions;


BEGIN
   n := Shootout.Argi();
   countdown := n;
   Initialize();

   FindSolutions(); 
   PrintSolutions();  
END meteor.
