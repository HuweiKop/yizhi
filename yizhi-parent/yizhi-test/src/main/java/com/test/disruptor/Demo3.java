package com.test.disruptor;

import com.lmax.disruptor.BusySpinWaitStrategy;
import com.lmax.disruptor.RingBuffer;
import com.lmax.disruptor.dsl.Disruptor;
import com.lmax.disruptor.dsl.EventHandlerGroup;
import com.lmax.disruptor.dsl.ProducerType;

import java.util.Date;
import java.util.concurrent.CountDownLatch;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;

/**
 * Created by huwei on 2017/3/26.
 */
public class Demo3 {
    public static void main(String[] args) throws InterruptedException {
        long startTime = new Date().getTime();
        int bufferSize = 1024*1024;
        int threaNumbers = 4;
        ExecutorService executorService = Executors.newFixedThreadPool(threaNumbers);
        Disruptor<TradeTransaction> disruptor = new Disruptor<TradeTransaction>(()->new TradeTransaction(),bufferSize,executorService, ProducerType.SINGLE,new BusySpinWaitStrategy());

        EventHandlerGroup<TradeTransaction> eventHandlerGroup = disruptor.handleEventsWith(new TradeTransactionVasConsumer(),new TradeTransactionInDBHandler());

        TradeTransactionJMSNotifyHandler jmsNotifyHandler = new TradeTransactionJMSNotifyHandler();
        eventHandlerGroup.then(jmsNotifyHandler);

        disruptor.start();
        CountDownLatch latch = new CountDownLatch(1);
        executorService.submit(new TradeTransactionPublisher(disruptor,latch));
        latch.await();
        disruptor.shutdown();
        executorService.shutdown();

        long endTime = new Date().getTime();
        System.out.println((endTime-startTime)/1000);
    }
}
