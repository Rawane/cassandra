package com.xoolibeut.gainde.cassandra.util;

import java.math.BigDecimal;
import java.math.BigInteger;
import java.nio.ByteBuffer;
import java.sql.Timestamp;
import java.time.Instant;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.TimeZone;
import java.util.UUID;

import com.datastax.driver.core.DataType;
import com.datastax.driver.core.LocalDate;
import com.fasterxml.jackson.databind.JsonNode;

public class GaindeUtil {
	public static int ASCII = 1;
	public static int BIGINT = 2;
	public static int BLOB = 3;
	public static int BOOLEAN = 4;
	public static int COUNTER = 5;
	public static int DECIMAL = 6;
	public static int DOUBLE = 7;
	public static int FLOAT = 8;
	public static int INT = 9;
	public static int TEXT = 10;
	public static int TIMESTAMP = 11;
	// public static int UUID = 12;
	public static int VARCHAR = 13;
	public static int VARINT = 14;
	public static int TIMEUUID = 15;
	public static int INET = 16;
	public static int DATE = 17;
	public static int TIME = 18;
	public static int SMALLINT = 19;
	public static int TINYINT = 20;
	public static int DURATION = 21;
	public static int LIST = 32;
	public static int MAP = 33;
	public static int SET = 34;
	public static int UDT = 48;
	public static int TUPLE = 49;

	public static Object getData(JsonNode jsonNode) {
		String type = jsonNode.get("type").asText();
		if(jsonNode.get("data").asText(null)==null) {
			return null;
		}
		String data=jsonNode.get("data").asText(null);
		
		switch (type) {
		case "TEXT":
			return data;
		case "VARCHAR":
			return data;
		case "INT":
			return Integer.parseInt(data);
		case "DOUBLE":
			return Double.parseDouble(data);
		case "DATE": {
			java.time.LocalDate jtld = java.time.LocalDate.parse(data, DateTimeFormatter.ofPattern("dd/MM/yyyy"));
			return LocalDate.fromYearMonthDay(jtld.getYear(), jtld.getMonthValue(), jtld.getDayOfMonth());
		}
		case "TIMESTAMP":
			return Timestamp.valueOf(data);
		case "DECIMAL":
			return new BigDecimal(data);
		case "BOOLEAN":
			return jsonNode.get("data").asBoolean();
		case "FLOAT":
			return Float.valueOf(data);
		case "TIME":
			LocalDateTime date = LocalDateTime.ofInstant(Instant.ofEpochMilli(jsonNode.get("data").asLong()),
					TimeZone.getDefault().toZoneId());
			return Timestamp.valueOf(date);
		case "COUNTER":
			return Long.parseLong(data);
		case "BIGINT":
			return Long.parseLong(data);
		case "VARINT":
			return new BigInteger(data);
		case "UUID":
			return UUID.fromString(data);
		case "TIMEUUID":
			return UUID.fromString(data);
		case "TINYINT":
			return (byte) Integer.parseInt(data);
		case "SMALLINT":
			return (short) Integer.parseInt(data);
		case "SET": {
			String setString = data;
			Set<String> set = new HashSet<>();
			if (setString != null && setString.length() > 2) {
				String[] arrayData = setString.substring(1, setString.length() - 1).split(",");
				for (String key : arrayData) {
					set.add(key);
				}

			}
			return set;
		}
		case "LIST": {
			String setString = data;
			List<String> list = new ArrayList<>();
			if (setString != null && setString.length() > 2) {
				String[] arrayData = setString.substring(1, setString.length() - 1).split(",");
				for (String key : arrayData) {
					list.add(key);
				}

			}
			return list;
		}
		case "BLOB": {
			ByteBuffer buffer = ByteBuffer.wrap(data.getBytes());
			return buffer;
		}
		case "MAP": {
			String setString = data;
			Map<String, String> map = new HashMap<>();
			if (setString != null && setString.length() > 2) {
				String[] arrayData = setString.substring(1, setString.length() - 1).split(",");
				for (String element : arrayData) {
					String[] arrayElement = element.split(":");
					if (arrayElement.length == 2) {
						map.put(arrayElement[0], arrayElement[1]);
					}
				}

			}
			return map;
		}
		default:
			break;
		}

		return data;
	}

	public static DataType getDataType(int type, Integer typeOplist, Integer typeopMap) {
		DataType dataType = null;
		switch (type) {
		case 1:
			dataType = DataType.ascii();
			break;
		case 2:
			dataType = DataType.bigint();
			break;
		case 3:
			dataType = DataType.blob();
			break;
		case 4:
			dataType = DataType.cboolean();
			break;
		case 5:
			dataType = DataType.counter();
			break;
		case 6:
			dataType = DataType.decimal();
			break;
		case 7:
			dataType = DataType.cdouble();
			break;
		case 8:
			dataType = DataType.cfloat();
			break;
		case 9:
			dataType = DataType.cint();
			break;
		case 10:
			dataType = DataType.text();
			break;
		case 11:
			dataType = DataType.timestamp();
			break;
		case 13:
			dataType = DataType.varchar();
			break;
		case 12:
			dataType = DataType.uuid();
			break;
		case 14:
			dataType = DataType.varint();
			break;
		case 15:
			dataType = DataType.timeuuid();
			break;
		case 16:
			dataType = DataType.inet();
			break;
		case 17:
			dataType = DataType.date();
			break;
		case 18:
			dataType = DataType.time();
			break;
		case 19:
			dataType = DataType.smallint();
			break;
		case 20:
			dataType = DataType.tinyint();
			break;
		case 21:
			dataType = DataType.duration();
			break;
		case 22:
			dataType = DataType.list(getDataType(typeOplist, null, null));
			break;
		case 23:
			dataType = DataType.map(getDataType(typeOplist, null, null), getDataType(typeopMap, null, null));
			break;
		case 24:
			dataType = DataType.set(getDataType(typeOplist, null, null));
			break;
		case 32:
			dataType = DataType.list(getDataType(typeOplist, null, null));
			break;
		case 33:
			dataType = DataType.set(getDataType(typeOplist, null, null));
			break;
		case 34:
			dataType = DataType.map(getDataType(typeOplist, null, null), getDataType(typeopMap, null, null));
			break;
		default:
			break;
		}

		return dataType;
	}

	public static DataType getDataType(int type) {
		return getDataType(type, null, null);
	}
}
