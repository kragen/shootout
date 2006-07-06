import Data.Array.Unboxed
import Data.List
import System.Environment (getArgs)

main :: IO ()
main = getArgs >>= return . read . head >>= msquare

msquare :: Int -> IO ()
msquare n = let mn = (n*(n*n+1)) `quot` 2
                grd = listArray ((1,1),(n,n)) (repeat 0)
                unus = [1 .. n*n]
                ff  = findFewestMoves n mn grd unus
                ini = Square grd unus ff (2*n*n)
                allSquares = bestFirst (successorNodes n mn) [ini]
            in  putStrLn $ showGrid n . grid $ head allSquares

data Square = Square { grid :: UArray (Int,Int) Int
                     , unused :: [Int]
                     , ffm :: ([Int], Int, Int, Int)
                     , priority :: !Int
                     } deriving Eq

instance Ord Square where
    compare (Square g1 _ _ p1) (Square g2 _ _ p2)
        = case compare p1 p2 of
            EQ -> compare g1 g2
            ot -> ot

showMat :: [[Int]] -> ShowS
showMat lns = foldr1 ((.) . (. showChar '\n')) $ showLns
              where
                showLns = 
			map (foldr1 ((.) . (. showChar ' ')) . map shows) lns

showGrid :: Int -> UArray (Int,Int) Int -> String
showGrid n g = showMat [[g ! (r,c) | c <- [1 .. n]] | r <- [1 .. n]] ""

bestFirst :: (Square -> [Square]) -> [Square] -> [Square]
bestFirst _ [] = []
bestFirst successors (front:queue)
    | priority front == 0 = front : bestFirst successors queue
    | otherwise = bestFirst successors $ foldr insert queue (successors front)

successorNodes n mn sq
    = map (place sq n mn (r,c)) possibilities
      where
        (possibilities,_,r,c) = ffm sq

place :: Square -> Int -> Int -> (Int,Int) -> Int -> Square
place (Square grd unus _ _) n mn (r,c) k
    = Square grd' uns moveChoices p
      where
        grd' = grd//[((r,c),k)]
        moveChoices@(_,len,_,_) = findFewestMoves n mn grd' uns
        uns = delete k unus
        p = length uns + len

findFewestMoves :: Int -> Int -> UArray (Int,Int) Int -> [Int] -> ([Int],Int,Int,Int)
findFewestMoves n mn grid unus
    | null unus = ([],0,0,0)
    | otherwise = (movelist, length movelist, mr, mc)
      where
        openSquares = [(r,c) | r <- [1 .. n], c <- [1 .. n], grid ! (r,c) == 0]
        pm = possibleMoves n mn grid unus
        openMap = map (\(x,y) -> (pm x y,x,y)) openSquares
        mycompare (a,_,_) (b,_,_) = compare (length a) (length b)
        (movelist,mr,mc) = minimumBy mycompare openMap

possibleMoves :: Int -> Int -> UArray (Int,Int) Int -> [Int] -> Int -> Int -> [Int]
possibleMoves n mn grid unus r c
    | grid ! (r,c) /= 0 = []
    | otherwise = takeWhile (<= ma) $ dropWhile (< mi) unus
      where
        cellGroups
            | r == c && r + c == n + 1 = [d1, d2, theRow, theCol]
            | r == c = [d1, theRow, theCol]
            | r + c == n + 1 = [d2, theRow, theCol]
            | otherwise = [theRow, theCol]
        d1 = diag1 grid n
        d2 = diag2 grid n
        theRow = gridRow grid n r
        theCol = gridCol grid n c
        lows = scanl (+) 0 unus
        higs = scanl (+) 0 $ reverse unus
        rge :: [Int] -> (Int,Int)
        rge cg = let k = count0s cg - 1
                     lft = mn - sum cg
                 in (lft - (higs!!k),lft - (lows!!k))
        (mi,ma) = foldr1 mima $ map rge cellGroups
        mima (a,b) (c,d) = (max a c, min b d)

gridRow, gridCol :: UArray (Int,Int) Int -> Int -> Int -> [Int]
diag1, diag2 :: UArray (Int,Int) Int -> Int -> [Int]
gridRow grid n r = [grid ! (r,i) | i <- [1 .. n]]
gridCol grid n c = [grid ! (i,c) | i <- [1 .. n]]
diag1 grid n     = [grid ! (i,i) | i <- [1 .. n]]
diag2 grid n     = [grid ! (i,n+1-i) | i <- [1 .. n]]
count0s :: [Int] -> Int
count0s = length . filter (== 0)

