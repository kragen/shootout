-- The Computer Language Benchmarks Game
-- http://shootout.alioth.debian.org/
-- Contributed by Jed Brown with improvements by Spencer Janssen and Don Stewart
-- Modified by Alex Mason

import Control.Monad
import Control.Concurrent
import System.Environment

ring = 503

new l i = do
  r <- newEmptyMVar
  forkIO (thread i l r)
  return r

thread :: Int -> MVar Int -> MVar Int -> IO ()
thread i l r = go
  where go = do
          m <- takeMVar l
          when (m == 1) (print i)
          putMVar r $! m - 1
          when (m > 0) go

main = do
  a <- newMVar . read . head =<< getArgs
  z <- foldM new a [2..ring]
  ret <- newEmptyMVar
  forkIO (thread 1 z a >>= putMVar ret)
  takeMVar ret