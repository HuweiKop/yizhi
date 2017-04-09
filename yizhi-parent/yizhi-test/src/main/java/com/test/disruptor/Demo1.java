package com.test.disruptor;

import com.lmax.disruptor.*;

import java.util.concurrent.*;

/**
 * Created by huwei on 2017/3/26.
 */
public class Demo1 {
    public static void main(String[] args) throws ExecutionException, InterruptedException {

        int BUFFER_SIZE=1024;
        int THREAD_NUMBERS=4;

        RingBuffer<TradeTransaction> ringBuffer = RingBuffer.createSingleProducer(new EventFactory<TradeTransaction>() {
            @Override
            public TradeTransaction newInstance() {
                return new TradeTransaction();
            }
        },BUFFER_SIZE,new YieldingWaitStrategy());

        ExecutorService executorService = Executors.newFixedThreadPool(THREAD_NUMBERS);

        SequenceBarrier sequenceBarrier = ringBuffer.newBarrier();

        BatchEventProcessor<TradeTransaction> processor = new BatchEventProcessor<>(ringBuffer,sequenceBarrier,new TradeTransactionInDBHandler());
        ringBuffer.addGatingSequences(processor.getSequence());
        executorService.submit(processor);

        BatchEventProcessor<TradeTransaction> processor1 = new BatchEventProcessor<>(ringBuffer,sequenceBarrier,new TradeTransactionInFileHandler());
        ringBuffer.addGatingSequences(processor1.getSequence());
        executorService.submit(processor1);

        Future<?> future = executorService.submit(new Callable<Void>() {

            @Override
            public Void call() throws Exception {
                long seq;
                for(int i=0;i<10;i++){
                    seq = ringBuffer.next();
                    ringBuffer.get(seq).setPrice((Math.random()*9999));
                    ringBuffer.publish(seq);
                }
                return null;
            }
        });
        future.get();
        Thread.sleep(1000);
        processor.halt();
        processor1.halt();
        executorService.shutdown();
    }
}
