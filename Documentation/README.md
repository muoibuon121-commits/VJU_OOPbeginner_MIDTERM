<img width="128" height="128" alt="icon_128" src="https://github.com/user-attachments/assets/e0d73cd4-490e-4b77-a225-dd745bf83d33" /> 
# Muoi - B2B Invoice Manager - macOS Desktop App

Ứng dụng quản lý hóa đơn B2B cho macOS, được tối ưu hóa cho máy tính bàn.

## Tính năng chính

### Quản lý Hóa đơn
- Tạo, chỉnh sửa, xóa hóa đơn
- Tính toán tự động (VAT, chiết khấu)
- Theo dõi thanh toán
- Cảnh báo hóa đơn quá hạn
- In hóa đơn
- Export PDF

### Quản lý Khách hàng
- CRUD cho khách hàng
- Quản lý hạn mức tín dụng
- Thống kê doanh thu
- Phân loại khách hàng

### Dashboard
- Tổng doanh thu
- Doanh thu chưa thanh toán
- Số lượng hóa đơn quá hạn
- Biểu đồ thống kê

### Cài đặt
- Cấu hình VAT/Chiết khấu
- Cài đặt đồng bộ
- Quản lý dữ liệu
- Xuất/Nhập dữ liệu

## Cấu trúc Project

```
B2BInvoiceApp/
├── App/                 # Entry point
├── Models/              # Core Data entities
├── Services/            # Data, sync
├── Utilities/           # Constants, validation, extensions
├── Views/               # SwiftUI (MainWindow, sidebar, tables, forms)
└── Documentation/       # Markdown docs
```

## Yêu cầu

- **macOS** 12.0 hoặc cao hơn
- **Xcode** 14.0+
- **Swift** 5.7+

## Cài đặt

1. Clone project
2. Mở `B2BInvoiceApp.xcodeproj`
3. Chạy `Product → Run` (Cmd+R)

Thêm tất cả thư mục Swift (`App`, `Models`, `Services`, `Utilities`, `Views`) vào target Xcode.

## Sử dụng

### Khởi động ứng dụng
```
Cmd + R  - Run
Cmd + B  - Build
```

### Tạo hóa đơn mới
```
File → New Invoice
hoặc Cmd + N
```

### Tìm kiếm
```
Cmd + F  - Open search
```

### Preferences
```
Cmd + ,  - Open settings
```

## Giao diện

### macOS Specific Features
- Menu bar integration
- Keyboard shortcuts
- Toolbar actions
- Split view layout
- Autosave dữ liệu

## Bảo mật

- Input validation
- Error handling
- Secure storage
- Data encryption

## Responsive Design

- Desktop-optimized UI
- Resizable windows
- Dark mode support
- High DPI support

## Troubleshooting

### App không chạy?
1. Clean build: Cmd+Shift+K
2. Rebuild: Cmd+B
3. Restart Xcode

### Core Data errors?
1. Delete app from ~/Applications
2. Clean build
3. Rebuild & run

## Documentation

Xem thư mục `Documentation/`:
- `SETUP_GUIDE.md` - Hướng dẫn cài đặt
- `START_HERE.md` - Bắt đầu nhanh
- `FILE_INDEX.md` - Chỉ mục file

## Hỗ trợ

Nếu gặp vấn đề, kiểm tra:
1. Xcode Console logs
2. Documentation files
3. Code comments

## License

© 2024 B2B Invoice Manager

---

**Version:** 1.0.0  
**Platform:** macOS 12.0+  
**Status:** Production Ready
