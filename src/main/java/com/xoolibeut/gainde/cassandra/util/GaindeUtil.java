package com.xoolibeut.gainde.cassandra.util;

import com.datastax.driver.core.DataType;

public class GaindeUtil {

	public static int ASCII=1;
    public static int BIGINT=2;
    public static int BLOB=3;
    public static int BOOLEAN=4;
    public static int COUNTER=5;
    public static int DECIMAL=6;
    public static int DOUBLE=7;
    public static int FLOAT=8;
    public static int INT=9;
    public static int TEXT=10;
    public static int TIMESTAMP=11;
    public static int UUID=12;	    
    public static int VARINT=14;
    public static int TIMEUUID=15;
    public static int INET=16;
    public static int DATE=17; 
    public static int TIME=18;
    public static int SMALLINT;
    public static int TINYINT=20;
	  
	public static DataType getDataType(int type) {
		DataType dataType = null;
		switch (type) {
		case 1:
			dataType=DataType.ascii();
			break;

		default:
			break;
		}

		return dataType;
	}
}
