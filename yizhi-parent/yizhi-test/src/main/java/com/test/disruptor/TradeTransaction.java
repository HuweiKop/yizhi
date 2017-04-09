package com.test.disruptor;

/**
 * Created by huwei on 2017/3/26.
 */
public class TradeTransaction {
    private int id;
    private double price;

    public TradeTransaction() {
        System.out.println("create trade transaction.....");
    }

    public TradeTransaction(int id, int price) {
        this.id = id;
        this.price = price;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }
}
