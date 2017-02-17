package com.ideabinder.yizhi.base.api.model.db.manage;

import com.ideabinder.yizhi.base.api.model.db.BaseDbEntity;

/**
 * Created by Wei Hu (J) on 2017/2/13.
 */
public class UserDb extends BaseDbEntity {
    private int userId;
    private String userName;
    private String password;

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }
}
