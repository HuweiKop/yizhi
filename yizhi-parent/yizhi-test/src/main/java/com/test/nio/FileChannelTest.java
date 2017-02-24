package com.test.nio;

import java.io.IOException;
import java.io.RandomAccessFile;
import java.nio.ByteBuffer;
import java.nio.channels.FileChannel;

/**
 * Created by Wei Hu (J) on 2017/2/21.
 */
public class FileChannelTest {
    public static void main(String[] args) throws IOException {
        channelToChannel();
    }

    private static void channelBuffer() throws IOException {

        RandomAccessFile aFile = new RandomAccessFile("E:\\test.txt","rw");
        FileChannel inChannel = aFile.getChannel();

        ByteBuffer buf = ByteBuffer.allocate(48);

        int bytesRead = inChannel.read(buf);
        while (bytesRead!=-1){
            System.out.println("Read "+bytesRead);
            buf.flip();

            while (buf.hasRemaining()){
                System.out.print((char)buf.get());
            }
            buf.rewind();
            while (buf.hasRemaining()){
                System.out.print((char)buf.get());
            }

            buf.clear();
            bytesRead=inChannel.read(buf);
        }
        aFile.close();
    }

    private static void channelToChannel() throws IOException {
        RandomAccessFile fromFile = new RandomAccessFile("E:\\test.txt","rw");
        FileChannel fromChannel = fromFile.getChannel();

        RandomAccessFile toFile = new RandomAccessFile("E:\\test1.txt","rw");
        FileChannel toChannel = toFile.getChannel();

       fromChannel.transferTo(0,fromChannel.size(),toChannel);
    }
}
