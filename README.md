# OOP_MIDTERM
#  B2B QuoteMaster - Hệ thống Tự động hóa Báo giá & Hợp đồng

> Giải pháp số hóa quy trình chốt Sale cho doanh nghiệp SME, loại bỏ sai sót từ Excel và tối ưu hóa tỷ suất lợi nhuận.

##  1. Giới thiệu Dự án
Trong mô hình kinh doanh B2B, việc lập báo giá thủ công bằng Excel thường mất nhiều thời gian, dễ sai sót công thức và khó bảo mật giá vốn. **B2B QuoteMaster** ra đời nhằm tự động hóa quy trình này, giúp nhân viên Sales tạo báo giá phức tạp chỉ trong 5 phút với độ chính xác 100%, đồng thời tự động xuất file PDF chuyên nghiệp.

##  2. Tính năng Cốt lõi
* **Trình tạo Báo giá Động:** Thêm dịch vụ, tùy chọn (add-ons) với giá tiền được tự động nội suy.
* **Bảo vệ Biên độ Lợi nhuận (Margin):** Cảnh báo hoặc chặn việc thiết lập mức chiết khấu (Discount) khiến hợp đồng bị lỗ.
* **Quản lý Phiên bản:** Lưu trữ lịch sử chỉnh sửa các bản báo giá (V1, V2, V3...).
* **Xuất PDF Tự động:** Khởi tạo Hợp đồng/Báo giá định dạng PDF từ template có sẵn chỉ với 1 cú click.

##  3. Điểm sáng Kỹ thuật & Ứng dụng OOP
Dự án áp dụng triệt để các nguyên lý Lập trình Hướng đối tượng để giải quyết bài toán nghiệp vụ:
* **Tính Đóng gói (Encapsulation):** Các thuộc tính nhạy cảm như `__gia_von` được bảo mật nghiêm ngặt ở lớp Backend, nhân viên Sales thao tác trên UI chỉ có thể truy xuất `gia_ban`.
* **Decorator Design Pattern:** Giải quyết bài toán "Tính giá động". Các dịch vụ gốc (Component) được bọc bởi các Tùy chọn phụ (Decorator) để tự động cộng dồn chi phí một cách linh hoạt mà không cần tạo ra hàng trăm Class thừa thãi.

##  4. Công nghệ Sử dụng (Tech Stack)
## 🛠 4. Công nghệ Sử dụng (Tech Stack)

<p align="left">
  <img src="https://img.shields.io/badge/Language-Python_3.10+-3776AB?style=flat&logo=python&logoColor=white" alt="Python" />
  <img src="https://img.shields.io/badge/Framework-Django-092E20?style=flat&logo=django&logoColor=white" alt="Django" />
  <img src="https://img.shields.io/badge/Framework-FastAPI-009688?style=flat&logo=fastapi&logoColor=white" alt="FastAPI" />
  <img src="https://img.shields.io/badge/Database-PostgreSQL-4169E1?style=flat&logo=postgresql&logoColor=white" alt="PostgreSQL" />
  <img src="https://img.shields.io/badge/Database-SQLite-003B57?style=flat&logo=sqlite&logoColor=white" alt="SQLite" />
</p>
<p align="left">
  <img src="https://img.shields.io/badge/Frontend-HTML5-E34F26?style=flat&logo=html5&logoColor=white" alt="HTML5" />
  <img src="https://img.shields.io/badge/Frontend-CSS3-1572B6?style=flat&logo=css3&logoColor=white" alt="CSS3" />
  <img src="https://img.shields.io/badge/UI-Bootstrap_5-7952B3?style=flat&logo=bootstrap&logoColor=white" alt="Bootstrap" />
  <img src="https://img.shields.io/badge/Library-ReportLab_(PDF)-red?style=flat&logo=adobeacrobatreader&logoColor=white" alt="ReportLab" />
</p>


