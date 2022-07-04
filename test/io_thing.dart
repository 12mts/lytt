
import 'dart:io';

Future<String> getFileAsString(String fileName) {
  return File("C:\\Users\\marti\\Documents\\lytt\\testTing\\$fileName").readAsString();
}