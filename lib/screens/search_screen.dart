import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/weather_provider.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _controller = TextEditingController();
@override
  void initState() {
    super.initState();
    // Đảm bảo load lịch sử khi vào màn hình này
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<WeatherProvider>().loadSearchHistory();
    });
  }

  void _submitSearch(String city) {
    if (city.isNotEmpty) {
      context.read<WeatherProvider>().fetchWeatherByCity(city);
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final history = context.watch<WeatherProvider>().searchHistory;
    return Scaffold(
      appBar: AppBar(
        title: Text("Search City"),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _controller,
              decoration: InputDecoration(
                hintText: 'Enter city name (e.g., Hanoi)',
                prefixIcon: Icon(Icons.search),
                suffixIcon: IconButton(
                  icon: Icon(Icons.clear),
                  onPressed: () => _controller.clear(),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                filled: true,
                fillColor: Colors.grey[200],
              ),
              onSubmitted: _submitSearch,
            ),
            SizedBox(height: 20),
            if (history.isNotEmpty) ...[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Recent Searches",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  // (Optional) Nút xóa lịch sử nếu muốn làm thêm
                  IconButton(
                    icon: Icon(Icons.delete_outline, color: Colors.redAccent),
                    tooltip: "Clear History",
                    onPressed: () => _showClearHistoryDialog(context),
                  ),
                ],
              ),
              SizedBox(height: 10),
              // Hiển thị dạng Chips (Thẻ nhỏ) hoặc List
              Wrap(
                spacing: 8.0,
                children: history.map((city) {
                  return ActionChip(
                    avatar: Icon(Icons.history, size: 16, color: Colors.grey),
                    label: Text(city),
                    onPressed: () => _submitSearch(city),
                    backgroundColor: Colors.grey[100],
                  );
                }).toList(),
              ),
              SizedBox(height: 20),
            ],
            Text(
              "Popular Cities",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Expanded(
              child: ListView(
                children: [
                  _buildCityItem("Hanoi"),
                  _buildCityItem("Ho Chi Minh City"),
                  _buildCityItem("Da Nang"),
                  _buildCityItem("London"),
                  _buildCityItem("New York"),
                  _buildCityItem("Tokyo"),
                  _buildCityItem("Seoul"),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCityItem(String city) {
    return ListTile(
      leading: Icon(Icons.location_city, color: Colors.blue),
      title: Text(city),
      trailing: Icon(Icons.arrow_forward_ios, size: 16),
      onTap: () => _submitSearch(city),
    );
  }
  // Hàm hiển thị hộp thoại xác nhận xóa
  void _showClearHistoryDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text("Clear History"),
        content: Text("Are you sure you want to delete all search history?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx), // Đóng dialog
            child: Text("Cancel"),
          ),
          TextButton(
            onPressed: () {
              // Gọi Provider để xóa
              context.read<WeatherProvider>().clearSearchHistory();
              Navigator.pop(ctx); // Đóng dialog
            },
            child: Text("Clear", style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }
}