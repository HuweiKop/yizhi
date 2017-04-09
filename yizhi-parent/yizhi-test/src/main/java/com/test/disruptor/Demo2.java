package com.test.disruptor;

import com.lmax.disruptor.*;

import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;

/**
 * Created by huwei on 2017/3/26.
 */
public class Demo2 {
    public static void main(String[] args) throws InterruptedException {
        int bufferSize = 16;
        int threadNumbers = 4;
        RingBuffer<TradeTransaction> ringBuffer = RingBuffer.createSingleProducer(()->new TradeTransaction(),bufferSize,new YieldingWaitStrategy());

        ExecutorService executorService = Executors.newFixedThreadPool(4);

        SequenceBarrier sequenceBarrier = ringBuffer.newBarrier();
        WorkHandler<TradeTransaction> handler = new TradeTransactionInDBHandler();
        WorkHandler<TradeTransaction> handler1 = new TradeTransactionInFileHandler();
        WorkerPool<TradeTransaction> workerPool = new WorkerPool<TradeTransaction>(ringBuffer,sequenceBarrier,new IgnoreExceptionHandler(),handler);
        WorkerPool<TradeTransaction> workerPool1 = new WorkerPool<TradeTransaction>(ringBuffer,sequenceBarrier,new IgnoreExceptionHandler(),handler1);
        workerPool.start(executorService);
        workerPool1.start(executorService);

        new Thread(()->{
            for(int i=0;i<8;i++){
                long seq = ringBuffer.next();
                TradeTransaction trade = ringBuffer.get(seq);
                trade.setPrice(Math.random()*9999);
                ringBuffer.publish(seq);
            }
        }).start();
        Thread.sleep(1000);
        workerPool.halt();
        executorService.shutdown();
    }
}
