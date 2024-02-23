module Main (main) where

import Control.Exception (evaluate)
import Control.Parallel.Strategies (runEval)
import Data.Time.Clock
import Lib
import System.Environment
import Text.Printf

printTimeSince :: UTCTime -> IO ()
printTimeSince t0 = do
    t1 <- getCurrentTime
    printf "time: %.2fs\n" (realToFrac (diffUTCTime t1 t0) :: Double)

main :: IO ()
main = do
    [n] <- getArgs
    let evalF = [retAtLaunch, retAtSeqFinish, retAtParSeqFinish, retAtAllParFinish] !! (read n - 1)
    t0 <- getCurrentTime
    r <- evaluate (runEval (evalF fib 36 35))
    printTimeSince t0
    print r
    printTimeSince t0
