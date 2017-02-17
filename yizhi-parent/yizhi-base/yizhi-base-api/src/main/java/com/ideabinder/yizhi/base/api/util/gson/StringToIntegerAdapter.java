package com.ideabinder.yizhi.base.api.util.gson;

import com.google.gson.TypeAdapter;
import com.google.gson.stream.JsonReader;
import com.google.gson.stream.JsonToken;
import com.google.gson.stream.JsonWriter;

import java.io.IOException;

/**
 * Created by Wei Hu (J) on 2016/12/30.
 */
public class StringToIntegerAdapter extends TypeAdapter<Number> {

    @Override
    public void write(JsonWriter out, Number value) throws IOException {
        out.value(value);
    }

    @Override
    public Number read(JsonReader reader) throws IOException {
        // TODO Auto-generated method stub
        if (reader.peek() == JsonToken.NULL) {
            reader.nextNull();
            return null;
        }
        try {
            return reader.nextInt();
        } catch (NumberFormatException e) {
            reader.nextString();
            return null;
        }
    }
}
