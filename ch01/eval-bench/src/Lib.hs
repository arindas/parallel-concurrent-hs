module Lib (
    fib,
    retAtLaunch,
    retAtSeqFinish,
    retAtParSeqFinish,
    retAtAllParFinish,
)
where

import Control.Parallel.Strategies (Eval, rpar, rseq)

-- fib :: Int -> Int
-- fib n = go n (0, 1)
--   where
--     go x (a, b)
--         | x == 0 = a
--         | otherwise = go (x - 1) (b, a + b)

-- fibList :: (Num t) => t -> t -> [t]
-- fibList a b = a : b : fibList (a + b) (a + b + b)
--
-- fibs :: [Integer]
-- fibs = fibList 0 1
--
-- fib :: Int -> Integer
-- fib n = fibs !! n

fib :: Integer -> Integer
fib 0 = 1
fib 1 = 1
fib n = fib (n - 1) + fib (n - 2)

retAtLaunch :: (t -> b) -> t -> t -> Eval (b, b)
retAtLaunch f x y = do
    a <- rpar (f x)
    b <- rpar (f y)
    return (a, b)

retAtSeqFinish :: (t -> b) -> t -> t -> Eval (b, b)
retAtSeqFinish f x y = do
    a <- rpar (f x)
    b <- rseq (f y)
    return (a, b)

retAtParSeqFinish :: (t -> b) -> t -> t -> Eval (b, b)
retAtParSeqFinish f x y = do
    a <- rpar (f x)
    b <- rseq (f y)
    _ <- rseq a
    return (a, b)

retAtAllParFinish :: (t -> b) -> t -> t -> Eval (b, b)
retAtAllParFinish f x y = do
    a <- rpar (f x)
    b <- rpar (f y)
    _ <- rseq a
    _ <- rseq b
    return (a, b)
