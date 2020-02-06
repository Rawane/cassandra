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
    public static int SMALLINT=19;
    public static int TINYINT=20;
    public static int DURATION=21;
    public static int LIST=32;
    public static int MAP=33;
    public static int SET=34;
    public static int UDT=48;
    public static int TUPLE=49;
  
	  
	public static DataType getDataType(int type) {
		DataType dataType = null;
		switch (type) {
		case 1:
			dataType=DataType.ascii();
			break;
		case 2:
			dataType=DataType.bigint();
			break;
		case 3:
			dataType=DataType.blob();
			break;
		case 4:
			dataType=DataType.cboolean();
			break;
		case 5:
			dataType=DataType.counter();
			break;
		case 6:
			dataType=DataType.decimal();
			break;
		case 7:
			dataType=DataType.cdouble();
			break;
		case 8:
			dataType=DataType.cfloat();
			break;
		case 9:
			dataType=DataType.cint();
			break;
		case 10:
			dataType=DataType.text();
			break;
		case 11:
			dataType=DataType.timestamp();
			break;
		case 12:
			dataType=DataType.uuid();
			break;
		case 13:
			dataType=DataType.varint();
			break;
		case 14:
			dataType=DataType.timeuuid();
			break;
		case 15:
			dataType=DataType.inet();
			break;
		case 16:
			dataType=DataType.date();
			break;
		case 17:
			dataType=DataType.time();
			break;
		case 18:
			dataType=DataType.smallint();
			break;
		case 19:
			dataType=DataType.tinyint();
			break;

		default:
			break;
		}

		return dataType;
	}
}
