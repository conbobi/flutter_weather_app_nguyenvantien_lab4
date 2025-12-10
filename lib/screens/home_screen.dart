// lib/screens/home_screen.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

// Import Constants
import '../utils/constants.dart';

import '../providers/weather_provider.dart';
import '../models/weather_model.dart';
import '../widgets/current_weather_card.dart';
import '../widgets/hourly_forecast_list.dart';
import '../widgets/daily_forecast_card.dart';
import '../widgets/weather_detail_item.dart';
import '../widgets/loading_shimmer.dart';
import '../widgets/error_widget.dart';
import 'search_screen.dart';
import 'forecast_screen.dart';
import 'settings_screen.dart';
// import provider
import './../providers/settings_provider.dart';
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<WeatherProvider>().fetchWeatherByLocation();
    });
  }

  Color _getBackgroundColor(String? condition) {
    if (condition == null) return AppConstants.colorSunnyBg;
    
    switch (condition.toLowerCase()) {
      case 'clear':
        return AppConstants.colorSunnyBg;
      
      case 'rain':
      case 'drizzle':      
      case 'thunderstorm':
        return AppConstants.colorRainyBg;
        
      case 'clouds':
      case 'mist':       
      case 'smoke':
      case 'haze':
      case 'dust':
      case 'fog':
        return AppConstants.colorCloudyBg;
        
      default:
        int hour = DateTime.now().hour;
        if (hour < 6 || hour > 18) {
          return AppConstants.colorNightBg;
        }
        return AppConstants.colorSunnyBg;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<WeatherProvider>(
      builder: (context, provider, child) {
        return Scaffold(
          backgroundColor: _getBackgroundColor(provider.currentWeather?.mainCondition),
          
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            title: Text('Weather App', style: TextStyle(color: Colors.white)),
            actions: [
              IconButton(
                icon: Icon(Icons.settings, color: Colors.white),
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => SettingsScreen()),
                ),
              ),
            ],
          ),
          body: RefreshIndicator(
            onRefresh: () => provider.refreshWeather(),
            child: _buildBody(provider),
          ),
          floatingActionButton: FloatingActionButton(
            backgroundColor: Colors.white,
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => SearchScreen()),
            ),
            child: Icon(Icons.search, color: Colors.blue),
          ),
        );
      },
    );
  }

  Widget _buildBody(WeatherProvider provider) {
    final settings = context.watch<SettingsProvider>();
      String windValue;
  String windUnit;

  if (settings.isMsSpeed) {
    windValue = "${provider.currentWeather!.windSpeed}";
    windUnit = "m/s";
  } else {
    double kmh = provider.currentWeather!.windSpeed * 3.6;
    windValue = kmh.toStringAsFixed(1);
    windUnit = "km/h";
  }
    if (provider.state == WeatherState.loading) {
      return LoadingShimmer();
    }
    
    if (provider.state == WeatherState.error) {
      return ErrorWidgetCustom(
        message: provider.errorMessage,
        onRetry: () => provider.fetchWeatherByLocation(),
      );
    }
    
    if (provider.currentWeather == null) {
      return Center(child: Text('No weather data'));
    }

    return SingleChildScrollView(
      physics: AlwaysScrollableScrollPhysics(),
      padding: EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CurrentWeatherCard(weather: provider.currentWeather!),
          
          SizedBox(height: 20),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              "Hourly Forecast",
              style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(height: 10),
          
          HourlyForecastList(forecasts: provider.hourlyForecast),
          
          SizedBox(height: 20),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Next 5 Days",
                  style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                ),
                TextButton(
                  onPressed: () => Navigator.push(
                    context, 
                    MaterialPageRoute(builder: (_) => ForecastScreen())
                  ),
                  child: Text("See All", style: TextStyle(color: Colors.white)),
                )
              ],
            ),
          ),
          
          if (provider.forecast.isNotEmpty)
             DailyForecastCard(forecast: provider.forecast.first),

          SizedBox(height: 20),
           Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              "Details",
              style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(height: 10),

          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: GridView.count(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              crossAxisSpacing: 15,
              mainAxisSpacing: 15,
              childAspectRatio: 1.5,
              children: [
                WeatherDetailItem(
                  icon: Icons.water_drop, 
                  title: "Humidity", 
                  value: "${provider.currentWeather!.humidity}%"
                ),
                WeatherDetailItem(
                  icon: Icons.air, 
                  title: "Wind", 
                  value: "$windValue $windUnit",
                ),
                WeatherDetailItem(
                  icon: Icons.compress, 
                  title: "Pressure", 
                  value: "${provider.currentWeather!.pressure} hPa"
                ),
                WeatherDetailItem(
                  icon: Icons.visibility, 
                  title: "Visibility", 
                  value: "${(provider.currentWeather!.visibility ?? 0) / 1000} km"
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}