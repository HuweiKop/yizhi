package com.test.disruptor;

import com.lmax.disruptor.EventTranslator;

/**
 * Created by huwei on 2017/3/26.
 */
public class TradeEventTranslator implements EventTranslator<TradeTransaction> {
    @Override
    public void translateTo(TradeTransaction tradeTransaction, long l) {
        System.out.println("TradeEventTranslator");
    }
}
