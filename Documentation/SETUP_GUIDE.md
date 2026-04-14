# macOS App Setup Guide

## Yêu cầu

- **macOS** 12.0 hoặc cao hơn
- **Xcode** 14.0+
- **Swift** 5.7+

## Cài đặt từng bước

### Step 1: Tạo Xcode Project

```bash
1. Mở Xcode
2. File → New → Project
3. Chọn "macOS" → "App"
4. Product Name: B2BInvoiceApp
5. Interface: SwiftUI
6. Nhấn "Create"
```

### Step 2: Tạo Core Data Model

```bash
1. File → New → File
2. Data Model
3. Tên: B2BInvoice
4. Nhấn Create
```

### Step 3: Thêm Entities

Thêm 2 entities vào B2BInvoice.xcdatamodeld:

#### Entity: Invoice
**Attributes:**
- id: UUID
- invoiceNumber: String
- invoiceDate: Date
- dueDate: Date
- status: String
- subtotal: Double
- discountRate: Double
- discountAmount: Double
- subtotalAfterDiscount: Double
- vatRate: Double
- vatAmount: Double
- totalAmount: Double
- clientId: UUID
- clientName: String
- clientEmail: String
- clientPhone: String
- clientAddress: String
- paymentMethod: String
- paymentStatus: String
- paidAmount: Double
- paymentDate: Date (optional)
- description_field: String
- notes: String
- createdAt: Date
- updatedAt: Date

#### Entity: Client
**Attributes:**
- id: UUID
- name: String
- email: String
- phone: String
- address: String
- city: String
- country: String
- taxCode: String
- companyName: String
- companyType: String
- industry: String
- website: String
- totalInvoices: Int64
- totalRevenue: Double
- outstandingBalance: Double
- status: String
- creditLimit: Double
- paymentTerm: Int32
- notes: String
- createdAt: Date
- updatedAt: Date

### Step 4: Copy Swift Files

Thêm các thư mục và file sau vào project (giữ cấu trúc thư mục):

**Utilities/**
- `Constants.swift`
- `ValidationHelper.swift`
- `Extensions.swift`

**App/**
- `B2BApp.swift`

**Models/**
- `Models.swift`

**Services/**
- `CoreDataManager.swift`
- `SyncManager.swift`

**Views/**
- `MainWindow.swift`
- `MainSidebar.swift`
- `ListHeaderToolbar.swift`
- `DashboardView.swift`
- `StatCard.swift`
- `InvoiceListView.swift`
- `InvoiceTableView.swift`
- `ClientsListView.swift`
- `ClientsTableView.swift`
- `SettingsView.swift`
- `SettingsFormView.swift`
- `PreferencesWindow.swift`
- `AboutWindow.swift`

Đảm bảo mọi file `.swift` trên đều được tick **Target Membership** cho app target.

### Step 5: Build & Run

```bash
1. Product → Build (Cmd+B)
2. Xác nhận không có errors
3. Product → Run (Cmd+R)
```

## Folder Structure

```
B2BInvoiceApp/
├── App/
│   └── B2BApp.swift
├── Models/
│   └── Models.swift
├── Services/
│   ├── CoreDataManager.swift
│   └── SyncManager.swift
├── Utilities/
│   ├── Constants.swift
│   ├── ValidationHelper.swift
│   └── Extensions.swift
├── Views/
│   ├── MainWindow.swift
│   ├── MainSidebar.swift
│   ├── ListHeaderToolbar.swift
│   ├── DashboardView.swift
│   ├── StatCard.swift
│   ├── InvoiceListView.swift
│   ├── InvoiceTableView.swift
│   ├── ClientsListView.swift
│   ├── ClientsTableView.swift
│   ├── SettingsView.swift
│   ├── SettingsFormView.swift
│   ├── PreferencesWindow.swift
│   └── AboutWindow.swift
├── Documentation/
└── Resources/
    └── B2BInvoice.xcdatamodeld
```

## Verification

Sau khi cài đặt xong:

- [ ] Xcode project tạo thành công
- [ ] Core Data Model tạo với 2 entities
- [ ] Tất cả Swift files thêm đúng target
- [ ] Build thành công (Cmd+B)
- [ ] App chạy được (Cmd+R)
- [ ] Dashboard hiển thị
- [ ] Có thể tạo invoices
- [ ] Có thể tạo clients

## Keyboard Shortcuts

| Shortcut | Tác vụ |
|----------|--------|
| Cmd+N | Tạo hóa đơn mới |
| Cmd+C | Tạo khách hàng mới |
| Cmd+F | Tìm kiếm |
| Cmd+, | Mở Preferences |
| Cmd+Q | Thoát ứng dụng |

## Troubleshooting

### Build Errors

**"Cannot find 'CoreDataManager' in scope"**
- Solution: Kiểm tra file `CoreDataManager.swift` được thêm đúng target

**"'NSApplication' is unavailable"**
- Solution: Kiểm tra deployment target là macOS 12.0+

### Runtime Errors

**Core Data crash**
- Solution: 
  1. Delete app from ~/Applications
  2. Clean build (Cmd+Shift+K)
  3. Rebuild (Cmd+B)

**Window không hiển thị**
- Solution: Kiểm tra `B2BApp.swift` có `MainWindow()`

## Next Steps

1. Customize Constants.swift với cấu hình của bạn
2. Thêm API endpoint trong Constants.swift
3. Test tất cả tính năng
4. Deploy lên Mac App Store

## Tips

- Use Cmd+K để Quick Open files
- Use Cmd+Shift+O để Go to Definition
- Use Option+Click để xem inline documentation
- Use Cmd+Option+/ để tạo quick documentation

---

**Status:** Production Ready  
**Version:** 1.0.0  
**Platform:** macOS 12.0+
