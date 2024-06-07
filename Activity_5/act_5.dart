import 'dart:io';

void main() {
  // Prompt the user to enter the file name
  stdout.write('Enter the file name: ');
  String? fileName = stdin.readLineSync();

  if (fileName != null) {
    // Remove leading and trailing whitespace and quotes
    fileName = fileName.trim().replaceAll("'", "");

    // Read the file contents and print them
    readFileContents(fileName);
  } else {
    print('Invalid file name.');
  }
}

void readFileContents(String fileName) {
  try {
    // Attempt to open the file
    File file = File(fileName);
    if (!file.existsSync()) {
      throw FileSystemException('File not found');
    }

    // Read file contents
    List<String> lines = file.readAsLinesSync();

    // Print file contents
    print('\nFile Contents:');
    for (String line in lines) {
      print(line);
    }
  } catch (e) {
    print('Error: $e, or extension is missing.');
  }
}
