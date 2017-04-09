package com.test.disruptor;

import com.lmax.disruptor.dsl.Disruptor;

import java.util.concurrent.CountDownLatch;

/**
 * Created by huwei on 2017/3/26.
 */
public class TradeTransactionPublisher implements Runnable {

    Disruptor<TradeTransaction> disruptor;
    private CountDownLatch latch;
    private static int LOOP=1000000;//模拟一千万次交易的发生

    public TradeTransactionPublisher(Disruptor<TradeTransaction> disruptor, CountDownLatch latch){
        this.disruptor = disruptor;
        this.latch = latch;
    }

    @Override
    public void run() {
        TradeEventTranslator tradeEventTranslator = new TradeEventTranslator();
        for(int i=0;i<LOOP;i++){
            disruptor.publishEvent(tradeEventTranslator);
        }
        this.latch.countDown();
    }
}
