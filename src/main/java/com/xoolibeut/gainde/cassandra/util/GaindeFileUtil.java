package com.xoolibeut.gainde.cassandra.util;

import java.io.BufferedWriter;
import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;

import com.xoolibeut.gainde.cassandra.GaindeConstante;

public class GaindeFileUtil {
	private static Path createFileIfNotexist(String folder) throws IOException {
		String baseRep = folder;
		if (folder == null || folder.isEmpty()) {
			baseRep = System.getProperty("user.home");
		}
		Path path = Paths.get(baseRep + File.separator + GaindeConstante.DEFAULT_FOLDER_CONNECTION
				+ File.separator + GaindeConstante.FILE_CONNECTION);
		if (!Files.exists(path.getParent())) {
			Files.createDirectories(path.getParent());
		}
		if (!Files.exists(path)) {
			Files.createFile(path);
		}
		return path;
	}

	public static BufferedWriter writeGainde(String folder, String content) throws IOException {
		BufferedWriter writer = Files.newBufferedWriter(createFileIfNotexist(folder));
		writer.write(content);
		return writer;
	}

	public static void writeGaindeAndClose(String folder, String content) throws IOException {
		BufferedWriter writer = null;
		try {
			writer = Files.newBufferedWriter(createFileIfNotexist(folder));
			writer.write(content);
		} finally {
			if (writer != null) {
				writer.close();
			}
		}
	}

	public static String readeGainde(String folder) throws IOException {
		return new String(Files.readAllBytes(createFileIfNotexist(folder)));
	}

}
