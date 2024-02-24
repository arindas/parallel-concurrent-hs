# eval-bench

This application demonstrates the [`Eval`](https://hackage.haskell.org/package/parallel-3.2.2.0/docs/Control-Parallel-Strategies.html#t:Eval) monad from `Control.Parallel.Strategies`.

It benchmarks multiple invocations in parallel or in sequence using [`runEval`](https://hackage.haskell.org/package/parallel-3.2.2.0/docs/Control-Parallel-Strategies.html#v:runEval).

## Usage

This listing has a single executable. You may run it with `stack run`. It accepts a single integer parameter to decide how to invoke the functions:

- 1 -> do both invocations in parallel and return with waiting for result
- 2 -> invoke one in parallel and one in sequence
- 3 -> invoke one in parallel and one in sequence but sequentially read the result of the parallel invocation
- 4 -> invoke both in parallel and sequentially wait for their result for both of the invocations

```shell
$ stack run 1
# time: 0.00s
# (24157817,14930352)
# time: 0.93s
```
