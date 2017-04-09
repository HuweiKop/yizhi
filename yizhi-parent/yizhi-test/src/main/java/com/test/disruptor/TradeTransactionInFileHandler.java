package com.test.disruptor;


import com.lmax.disruptor.EventHandler;
import com.lmax.disruptor.WorkHandler;

/**
 * Created by huwei on 2017/3/26.
 */
public class TradeTransactionInFileHandler implements EventHandler<TradeTransaction>,WorkHandler<TradeTransaction> {
    @Override
    public void onEvent(TradeTransaction tradeTransaction, long l, boolean b) throws Exception {
        this.onEvent(tradeTransaction);
    }

    @Override
    public void onEvent(TradeTransaction tradeTransaction) throws Exception {
        System.out.println("TradeTransactionInFileHandler");
    }
}
