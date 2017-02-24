package com.huwei.mytomcat;

import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.net.ServerSocket;
import java.net.Socket;

/**
 * Created by Wei Hu (J) on 2017/2/22.
 */
public class Server {
    private static int count= 0;

    public static void main(String[] args){
        ServerSocket ss = null;
        Socket socket = null;

        try {
            ss = new ServerSocket(9000);
            System.out.println("服务器初始化，等待客户端连接中.....");
            while (true){
                socket = ss.accept();
                count++;
                System.out.println("count:"+count);

                InputStream is = socket.getInputStream();
                Request request = new Request(is);

                OutputStream os = socket.getOutputStream();
                Response response = new Response(os);

                String uri = request.getUri();
                if(isStatic(uri)){
                    response.writeFile(uri.substring(1));
                }
                socket.close();
            }
        } catch (IOException e) {
            e.printStackTrace();
        }finally {
            try {
                ss.close();
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
    }

    public static boolean isStatic(String uri){
        String [] suffix = {".html",".png"};
        for(int i=0;i<suffix.length;i++){
            if(uri.endsWith(suffix[i]))
                return true;
        }
        return false;
    }
}
