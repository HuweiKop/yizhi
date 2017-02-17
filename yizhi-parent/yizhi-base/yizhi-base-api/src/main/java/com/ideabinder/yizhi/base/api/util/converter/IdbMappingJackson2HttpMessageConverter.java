package com.ideabinder.yizhi.base.api.util.converter;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.ideabinder.yizhi.base.api.model.ErrorCode;
import com.ideabinder.yizhi.base.api.model.response.BaseResponseModel;
import com.ideabinder.yizhi.base.api.util.gson.BooleanAsIntAdapter;
import com.ideabinder.yizhi.base.api.util.gson.EmptyStringToIntegerAdapterFactory;
import org.springframework.http.HttpInputMessage;
import org.springframework.http.HttpOutputMessage;
import org.springframework.http.converter.HttpMessageNotReadableException;
import org.springframework.http.converter.HttpMessageNotWritableException;
import org.springframework.http.converter.json.MappingJackson2HttpMessageConverter;

import java.io.IOException;
import java.io.InputStream;

/**
 * Created by Wei Hu (J) on 2017/1/6.
 */
public class IdbMappingJackson2HttpMessageConverter extends MappingJackson2HttpMessageConverter {

//    private Logger logger = Logger.getLogger(IdbMappingJackson2HttpMessageConverter.class);
//
    private Gson gson= new GsonBuilder().registerTypeAdapterFactory(new EmptyStringToIntegerAdapterFactory())
            .registerTypeAdapter(Boolean.class,new BooleanAsIntAdapter())
            .registerTypeAdapter(boolean.class,new BooleanAsIntAdapter()).create();

    @Override
    protected Object readInternal(Class<?> clazz, HttpInputMessage inputMessage)
            throws IOException, HttpMessageNotReadableException {
        String json = inputStream2String(inputMessage.getBody());
        Object result = gson.fromJson(json,clazz);
        return result;
    }

    @Override
    protected void writeInternal(Object object, HttpOutputMessage outputMessage)
            throws IOException, HttpMessageNotWritableException {
        String result = null;
        if (object == null) {
            result = gson.toJson(new BaseResponseModel(ErrorCode.UnkonwnError, "返回值为空"));
        } else {
            result = gson.toJson(object);
        }
        outputMessage.getBody().write(result.getBytes());
    }

    public String inputStream2String(InputStream in) throws IOException {
        StringBuffer out = new StringBuffer();
        byte[] b = new byte[4096];
        for (int n; (n = in.read(b)) != -1;) {
            out.append(new String(b, 0, n));
        }
        return out.toString();
    }
}
