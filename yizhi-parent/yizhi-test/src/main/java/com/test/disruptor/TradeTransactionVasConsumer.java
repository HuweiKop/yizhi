package com.test.disruptor;


import com.lmax.disruptor.EventHandler;

/**
 * Created by huwei on 2017/3/26.
 */
public class TradeTransactionVasConsumer implements EventHandler<TradeTransaction> {
    @Override
    public void onEvent(TradeTransaction tradeTransaction, long l, boolean b) throws Exception {
        System.out.println("TradeTransactionVasConsumer");
    }
}
