package com.huwei.mytomcat;

import javax.imageio.stream.FileImageInputStream;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.OutputStream;

/**
 * Created by Wei Hu (J) on 2017/2/22.
 */
public class Response {

    private OutputStream os = null;

    public Response(OutputStream os){
        this.os = os;
    }

    public void writeHtmlFile(String path) throws IOException {
        String htmlContentString = FileUtils.getFileContent(path);
        writeContent(htmlContentString);
    }

    public void writeContent(String content) throws IOException {
        os.write(content.getBytes());
        os.flush();
        os.close();
    }

    public void writeFile(String path) throws IOException {
        FileInputStream fis = new FileInputStream(path);
        byte[] buf = new byte[1024];
        int len = 0;
        while ((len = fis.read(buf))!=-1){
            os.write(buf,0,len);
        }
        fis.close();
        os.flush();
        os.close();
    }
}
