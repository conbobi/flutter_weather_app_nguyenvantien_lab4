Weather Forecast App – Flutter

Ứng dụng Weather Forecast App được xây dựng bằng Flutter, sử dụng OpenWeatherMap API để hiển thị thông tin thời tiết theo thời gian thực. Ứng dụng hỗ trợ xem thời tiết hiện tại, dự báo theo giờ, dự báo 7 ngày, tìm kiếm thành phố và lưu địa điểm yêu thích.

link video của em:

https://drive.google.com/file/d/1gV9CodSmd9wNtfMBbcSn1nYbhQgE9-IP/view?usp=sharing

1. Chức năng chính
Thời tiết hiện tại

Nhiệt độ, cảm nhận, trạng thái thời tiết.

Độ ẩm, áp suất, tầm nhìn.

Tốc độ gió, hướng gió.

Chỉ số UV.

Thời điểm mặt trời mọc và lặn.

Giao diện thay đổi theo điều kiện thời tiết (nắng – mưa – nhiều mây – ban đêm).

Dự báo theo giờ và 7 ngày

Biểu đồ nhiệt độ theo giờ.

Dự báo chi tiết trong 7 ngày: nhiệt độ cao/ thấp, mô tả thời tiết.

Tìm kiếm & quản lý địa điểm

Tìm kiếm thời tiết theo tên thành phố.

Lưu danh sách địa điểm yêu thích.

Lưu lịch sử tìm kiếm.

Tự động lấy vị trí hiện tại bằng GPS.

Thiết lập

Đổi đơn vị nhiệt độ °C / °F.

Chọn ngôn ngữ giao diện.

Định dạng thời gian 12h / 24h.

Dark Mode.

Offline

Cache dữ liệu khi mất mạng.

Tự đồng bộ khi có kết nối lại.

2. Hình ảnh giao diện (đặt trong thư mục /img)
![Nắng đẹp](./img/01_nang_dep.png)
![Nhiều mây](./img/02_nhieu_may.png)
![Tìm kiếm & Lịch sử - Light mode](./img/03_tim_kiem_va_lich_su_lightmode.png)
![Tìm kiếm & Lịch sử - Dark mode](./img/04_tim_kiem_va_lich_su_darkmode.png)
![Đang tải](./img/05_dang_tai.png)
![Dự báo 24h và 5 ngày tới](./img/06_du_bao_24h_vaf_5_ngay_toi.png)
![Settings](./img/07_setting_va_chon_che_do.png)
![Dự báo 5 ngày tiếp theo](./img/08_du_bao_5_ngay_tiep_theo.png)


3. Cài đặt và chạy dự án
flutter pub get
flutter run

4. Cấu trúc thư mục
```
C:.
|   main.dart
|
+---config
|       api_config.dart
|
+---models
|       forecast_model.dart
|       hourly_weather_model.dart
|       location_model.dart
|       weather_model.dart
|
+---providers
|       location_provider.dart
|       settings_provider.dart
|       weather_provider.dart
|
+---screens
|       forecast_screen.dart
|       home_screen.dart
|       search_screen.dart
|       settings_screen.dart
|
+---services
|       connectivity_service.dart
|       location_service.dart
|       storage_service.dart
|       weather_service.dart
|
+---utils
|       constants.dart
|       date_formatter.dart
|       weather_icons.dart
|
\---widgets
        current_weather_card.dart
        daily_forecast_card.dart
        error_widget.dart
        hourly_forecast_list.dart
        loading_shimmer.dart
        weather_detail_item.dart
```
