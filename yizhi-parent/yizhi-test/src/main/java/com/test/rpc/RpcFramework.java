package com.test.rpc;

import java.io.IOException;
import java.io.ObjectInputStream;
import java.io.ObjectOutputStream;
import java.lang.reflect.InvocationHandler;
import java.lang.reflect.Method;
import java.lang.reflect.Proxy;
import java.net.ServerSocket;
import java.net.Socket;

/**
 * Created by Wei Hu (J) on 2017/2/20.
 */
public class RpcFramework {

    public static void publish(final Object service, int port) throws IOException {
        if (service == null)
            throw new IllegalArgumentException("发布服务不能为空");
        if (port <= 0 || port > 65535) {
            throw new IllegalArgumentException("端口号不合法");
        }

        ServerSocket server = new ServerSocket(port);
        while (true) {
            try {
                final Socket socket = server.accept();
                new Thread(new Runnable() {
                    @Override
                    public void run() {
                        try {
                            try {
                                ObjectInputStream input = new ObjectInputStream(socket.getInputStream());
                                try {
                                    String methodName = input.readUTF();
                                    Class<?>[] parameterTypes = (Class<?>[]) input.readObject();
                                    Object[] arguments = (Object[]) input.readObject();
                                    ObjectOutputStream output = new ObjectOutputStream(socket.getOutputStream());
                                    try {
                                        Method method = service.getClass().getMethod(methodName, parameterTypes);
                                        Object result = method.invoke(service, arguments);
                                        output.writeObject(result);
                                    } catch (Throwable e) {
                                        e.printStackTrace();
                                    } finally {
                                        output.close();
                                    }
                                } catch (ClassNotFoundException e) {
                                    e.printStackTrace();
                                } finally {
                                    input.close();
                                }
                            } catch (IOException e) {
                                e.printStackTrace();
                            } finally {
                                try {
                                    socket.close();
                                } catch (IOException e) {
                                    e.printStackTrace();
                                }
                            }
                        } catch (Exception ex) {
                            ex.printStackTrace();
                        }
                    }
                }).start();
            } catch (Exception ex) {
                ex.printStackTrace();
            }
        }
    }

    @SuppressWarnings("unchecked")
    public static <T> T call(final Class<T> interfaceClass, String host, int port) throws Exception {
        if (interfaceClass == null)
            throw new IllegalArgumentException("调用服务为空");
        if (host == null || host.length() == 0)
            throw new IllegalArgumentException("主机不能为空");
        if (port <= 0 || port > 65535)
            throw new IllegalArgumentException("端口不合法");
        return (T) Proxy.newProxyInstance(interfaceClass.getClassLoader(), new Class[]{interfaceClass}, new CallHandler(host, port));
    }

    static class CallHandler implements InvocationHandler {
        private String host;
        private int port;

        public CallHandler(String host, int port) {
            this.port = port;
            this.host = host;
        }

        public Object invoke(Object proxy, Method method, Object[] args) throws Throwable {
            Socket socket = new Socket(host, port);
            try {
                ObjectOutputStream output = new ObjectOutputStream(socket.getOutputStream());
                try {
                    output.writeUTF(method.getName());
                    output.writeObject(method.getParameterTypes());
                    output.writeObject(args);
                    ObjectInputStream input = new ObjectInputStream(socket.getInputStream());
                    try {
                        Object result = input.readObject();
                        if (result instanceof Throwable) {
                            throw (Throwable) result;
                        }
                        return result;
                    } finally {
                        input.close();
                    }
                } finally {
                    output.close();
                }
            } finally {
                socket.close();
            }
        }
    }
}
