package com.huwei.mytomcat;

import java.io.BufferedReader;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;

/**
 * Created by Wei Hu (J) on 2017/2/22.
 */
public class FileUtils {

    public static String getFileContent(String path){
        StringBuffer sb = new StringBuffer();
        FileReader fr = null;
        BufferedReader br = null;
        try{
            fr = new FileReader(path);
            br = new BufferedReader(fr);
            String line = null;
            while ((line=br.readLine())!=null){
                sb.append(line);
            }
        } catch (FileNotFoundException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        }finally {
            try {
                br.close();
                fr.close();
            } catch (IOException e) {
                e.printStackTrace();
            }
        }

        return sb.toString();
    }
}
