package com.huwei.mytomcat;

import java.io.IOException;
import java.io.InputStream;

/**
 * Created by Wei Hu (J) on 2017/2/22.
 */
public class Request {

    private String uri;

    public Request(InputStream is) throws IOException {
        byte[] buf = new byte[1024];
        int len = is.read(buf);
        if(len>0){
            String msg = new String(buf,0,len);
            uri = msg.substring(msg.indexOf("/"),msg.indexOf(" HTTP/"));
        }
        else{

        }
    }

    public String getUri() {
        return uri;
    }

    public void setUri(String uri) {
        this.uri = uri;
    }
}
