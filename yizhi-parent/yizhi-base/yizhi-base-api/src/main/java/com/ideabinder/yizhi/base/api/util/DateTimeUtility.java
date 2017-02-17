package com.ideabinder.yizhi.base.api.util;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;

public class DateTimeUtility {

	public static Date calculateTime(Date date, int type, int count) {
		Calendar cal = Calendar.getInstance();
		cal.setTime(date);
		cal.add(type, count);
		return cal.getTime();
	}

	public static long convertToLong(Date date) {
		if (date == null)
			return 0;
		return date.getTime();
	}

	public static Date convertToDate(long date) {
		return new Date(date);
	}

	public static String convertToString(Date date) {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		return sdf.format(date);
	}

//	public static long convertToTimeLong(Date date) {
//		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmssSSS");
//		return Long.parseLong(sdf.format(date));
//	}

	public static long newTimeLong() {
		return convertToLong(new Date());
		// return convertToTimeLong(new Date());
	}

	public static long newDate() {
		return convertToLong(new Date());
	}

	public static void main(String[] args) {
		 SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");                
		 try {
			Date date = sdf.parse("1970-01-01 7:00:00");
			System.out.println(convertToLong(date));
			System.out.println(convertToDate(1479094142383L));
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}  
	}
}
