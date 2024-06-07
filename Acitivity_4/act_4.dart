import 'dart:convert';
import 'dart:io';

void main() async {
  try {
    // Fetch weather data asynchronously
    var weatherData = await fetchWeatherData();

    // Process the weather data
    var processedData = processWeatherData(weatherData);

    // Display relevant information to the user
    displayWeatherInfo(processedData);
  } catch (e) {
    print('Error: $e');
  }
}

Future<Map<String, dynamic>> fetchWeatherData() async {
  // API endpoint for weather data
  var apiUrl =
      'https://api.open-meteo.com/v1/forecast?latitude=52.52&longitude=13.41&current=temperature_2m,wind_speed_10m&hourly=temperature_2m,relative_humidity_2m,wind_speed_10m';

  // Send GET request to the API
  var httpClient = HttpClient();
  var request = await httpClient.getUrl(Uri.parse(apiUrl));
  var response = await request.close();

  // Check if the request was successful
  if (response.statusCode != HttpStatus.ok) {
    throw 'Failed to fetch weather data: ${response.statusCode}';
  }

  // Read and parse the response JSON
  var responseBody = await response.transform(utf8.decoder).join();
  var jsonData = json.decode(responseBody);

  return jsonData;
}

Map<String, dynamic> processWeatherData(Map<String, dynamic> weatherData) {
  // Extract relevant information from the weather data
  var current = weatherData['current'];
  var currentTime = current['time'];
  var currentTemperature = current['temperature_2m'];
  var currentWindSpeed = current['wind_speed_10m'];

  var hourly = weatherData['hourly'];
  var hourlyTime = hourly['time'];
  var hourlyTemperature = hourly['temperature_2m'];
  var hourlyHumidity = hourly['relative_humidity_2m'];
  var hourlyWindSpeed = hourly['wind_speed_10m'];

  return {
    'currentTime': currentTime,
    'currentTemperature': currentTemperature,
    'currentWindSpeed': currentWindSpeed,
    'hourlyTime': hourlyTime,
    'hourlyTemperature': hourlyTemperature,
    'hourlyHumidity': hourlyHumidity,
    'hourlyWindSpeed': hourlyWindSpeed,
  };
}

void displayWeatherInfo(Map<String, dynamic> weatherInfo) {
  // Display relevant information to the user
  print('Current Time: ${weatherInfo['currentTime']}');
  print('Current Temperature: ${weatherInfo['currentTemperature']}°C');
  print('Current Wind Speed: ${weatherInfo['currentWindSpeed']} m/s');
  
  print('\nHourly Forecast:');
  for (int i = 0; i < weatherInfo['hourlyTime'].length; i++) {
    print('Time: ${weatherInfo['hourlyTime'][i]}');
    print('Temperature: ${weatherInfo['hourlyTemperature'][i]}°C');
    print('Humidity: ${weatherInfo['hourlyHumidity'][i]}%');
    print('Wind Speed: ${weatherInfo['hourlyWindSpeed'][i]} m/s');
    print('-------------------------');
  }
}
