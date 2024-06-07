import 'dart:io';

void main() {
  // Define the file paths
  String inputFile = 'input.txt';
  String outputFile = 'output.txt';

  // Read data from input file
  List<int> numbers = readNumbersFromFile(inputFile);

  // Calculate sum
  int sum = calculateSum(numbers);

  // Write result to output file
  writeSumToFile(outputFile, sum);

  print('Sum calculated and written to $outputFile');
}

List<int> readNumbersFromFile(String filePath) {
  List<int> numbers = [];
  try {
    File file = File(filePath);
    List<String> lines = file.readAsLinesSync();
    for (String line in lines) {
      int number = int.parse(line.trim());
      numbers.add(number);
    }
  } catch (e) {
    print('Error reading file: $e');
  }
  return numbers;
}

int calculateSum(List<int> numbers) {
  int sum = 0;
  for (int number in numbers) {
    sum += number;
  }
  return sum;
}

void writeSumToFile(String filePath, int sum) {
  try {
    File file = File(filePath);
    file.writeAsStringSync('$sum');
  } catch (e) {
    print('Error writing to file: $e');
  }
}
