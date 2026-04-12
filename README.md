# OOP_MIDTERM
#  B2B Invoice (for MacOS) - Hệ thống Tự động hóa Báo giá & Hợp đồng

> Giải pháp số hóa quy trình chốt Sale cho doanh nghiệp SME, loại bỏ sai sót từ Excel và tối ưu hóa tỷ suất lợi nhuận.

##  I. Giới thiệu Dự án
Trong mô hình kinh doanh B2B, việc lập báo giá thủ công bằng Excel thường mất nhiều thời gian, dễ sai sót công thức và khó bảo mật giá vốn. **B2B Invoice** ra đời nhằm tự động hóa quy trình này, giúp nhân viên Sales tạo báo giá phức tạp chỉ trong 5 phút với độ chính xác 100%, đồng thời tự động xuất file PDF chuyên nghiệp.

##  II. Tính năng Cốt lõi
1. Quản Lý Hóa Đơn
```
- Tạo, chỉnh sửa, xóa hóa đơn
- Tính toán tự động: VAT, chiết khấu, tổng tiền
- Theo dõi trạng thái thanh toán
- Phát hiện hóa đơn quá hạn
- Tìm kiếm và lọc hóa đơn
```
2. Quản Lý Khách Hàng
```
- Lưu thông tin chi tiết khách hàng
- Theo dõi nợ của khách hàng
- Cảnh báo vượt hạn mức tín dụng
- Phân loại khách hàng (B2B, B2C, B2G)
```
3. Dashboard & Thống Kê

```
- Tổng doanh thu
- Tổng chưa thanh toán
- Số hóa đơn quá hạn
- Biểu đồ thống kê

```

4. Đồng Bộ Dữ Liệu


```
- Tự động đồng bộ khi có kết nối mạng
- Hàng đợi đồng bộ offline
- Giám sát trạng thái kết nối
- Tuỳ chỉnh khoảng thời gian đồng bộ
```


5. Cài Đặt & Tùy Chỉnh

```
- Cấu hình mức VAT mặc định
- Cấu hình chiết khấu mặc định
- Quản lý đồng bộ tự động
- Xuất/import dữ liệu
```

##  III. Công nghệ Sử dụng (Tech Stack)

<p align="left">
  <img src="https://img.shields.io/badge/Language-Swift_5-F05138?style=flat&logo=swift&logoColor=white" alt="Swift" />
  <img src="https://img.shields.io/badge/IDE-Xcode_15-157AF6?style=flat&logo=xcode&logoColor=white" alt="Xcode" />
  <img src="https://img.shields.io/badge/UI_Framework-SwiftUI-007AFF?style=flat&logo=apple&logoColor=white" alt="SwiftUI" />
  <img src="https://img.shields.io/badge/Architecture-MVVM-8E8E93?style=flat&logo=apple&logoColor=white" alt="MVVM" />
</p>
<p align="left">
  <img src="https://img.shields.io/badge/Database-Core_Data-4169E1?style=flat&logo=sqlite&logoColor=white" alt="Core Data" />
  <img src="https://img.shields.io/badge/PDF_Engine-PDFKit-red?style=flat&logo=adobeacrobatreader&logoColor=white" alt="PDFKit" />
</p>
</p>

## IV. Cấu trúc tổng quan
[![](https://mermaid.ink/img/pako:eNqNVV1LG0EU_SvDgKA0ETe7ahKKoEm1grGWqA9tikx2x92pyUyYnWitH1D60KeC0qdSSisipQ9CS98MfYr4P_afdD7WzSbG2H1YZubec-eec-_MHECXeRgWoc9RKwDr5RoF8hsbA0-o4PtgjREqzNp8q_WyBhdyC8t0lxEXy_njOp8bTzlO1OArkM3OgRKjAlMh_ePRJsF72nsV7RIfCcJotdUgeh08AlXi4TriCl-jSQpLBDHgkajzgYLxjWWgnMMJY47j6t02lrdW0D7mxmL-YbtuKN0agUxmIKDZDsSfRzh2VWJgfaG3GmcmwfFoCJP-OL1RkkMZC0QaWzp_lYeZGz592PvzUF_ZUlgUBnWGuKfQd8DlnHSJC7RCQjHcye45LTLeHO7kqOo1iBT5_kDTShcsBKF-eMcDU2-YKrGOIDuZnTu8PpHVeNcGwc2vqPOF-od9WhmQjpM0xXp09YP6WruKbN1G7JSUWTXEZmVEQ9waVSFSUR5uhc2K1dPNpJngdUesMJ-4QHQvaQAE654NNMZmZUhxBtEekuCwe-YGPfBQAUqMY7OWEDInj-MR5HtmoA8nx8A4P0y_ZMWIMhKogijyMdeJP29HV-cUNLp_ZfYC1VGI-4mXFO9VLPYY36livivpa-BS1PlIwPzawEEsqfas7lM3vcn1SdT5JGnXo87nB5RJt0WKr1JHm0bIk7Irff67NdKdYS6Hqknee1Z_Lf37Ceo-MEdrtPM9hafbxG9zffUALcxPuXx9KpVxQSO6umzpyXvgyjYCwqB2AjVxu3-ACJTNV9rHd2ma9fHxcbzDyC7qOZg-SqXUX8vFJWMPBaIi1HSfRle_ZUZh1DlVx-Q7BW7UuXAHaPe2ldSvT9T98FWiqEQR0JIcLmImgbnPkz0keeV87hqOIOp8A009ojdnJHnL9P3TxwRm5CtIPFgUvI0zsIl5E6kpPFCgGhQBbuIaLMqhh_hODdbokcS0EH3BWPMWxlnbD2BxGzVCOWu35JHAZYKkcM1klUuGmJdYmwpYLNhTOggsHsA3sJidtazJKcuZzdszztRsLp_LwH1YzNnWpDNj5XOO41j5WTtnH2XgW72vPWk5ufyUbc8Uph2rUChkIPaIYLxinnb9wh_9A7dtnuQ?type=png)](https://mermaid.live/edit#pako:eNqNVV1LG0EU_SvDgKA0ETe7ahKKoEm1grGWqA9tikx2x92pyUyYnWitH1D60KeC0qdSSisipQ9CS98MfYr4P_afdD7WzSbG2H1YZubec-eec-_MHECXeRgWoc9RKwDr5RoF8hsbA0-o4PtgjREqzNp8q_WyBhdyC8t0lxEXy_njOp8bTzlO1OArkM3OgRKjAlMh_ePRJsF72nsV7RIfCcJotdUgeh08AlXi4TriCl-jSQpLBDHgkajzgYLxjWWgnMMJY47j6t02lrdW0D7mxmL-YbtuKN0agUxmIKDZDsSfRzh2VWJgfaG3GmcmwfFoCJP-OL1RkkMZC0QaWzp_lYeZGz592PvzUF_ZUlgUBnWGuKfQd8DlnHSJC7RCQjHcye45LTLeHO7kqOo1iBT5_kDTShcsBKF-eMcDU2-YKrGOIDuZnTu8PpHVeNcGwc2vqPOF-od9WhmQjpM0xXp09YP6WruKbN1G7JSUWTXEZmVEQ9waVSFSUR5uhc2K1dPNpJngdUesMJ-4QHQvaQAE654NNMZmZUhxBtEekuCwe-YGPfBQAUqMY7OWEDInj-MR5HtmoA8nx8A4P0y_ZMWIMhKogijyMdeJP29HV-cUNLp_ZfYC1VGI-4mXFO9VLPYY36livivpa-BS1PlIwPzawEEsqfas7lM3vcn1SdT5JGnXo87nB5RJt0WKr1JHm0bIk7Irff67NdKdYS6Hqknee1Z_Lf37Ceo-MEdrtPM9hafbxG9zffUALcxPuXx9KpVxQSO6umzpyXvgyjYCwqB2AjVxu3-ACJTNV9rHd2ma9fHxcbzDyC7qOZg-SqXUX8vFJWMPBaIi1HSfRle_ZUZh1DlVx-Q7BW7UuXAHaPe2ldSvT9T98FWiqEQR0JIcLmImgbnPkz0keeV87hqOIOp8A009ojdnJHnL9P3TxwRm5CtIPFgUvI0zsIl5E6kpPFCgGhQBbuIaLMqhh_hODdbokcS0EH3BWPMWxlnbD2BxGzVCOWu35JHAZYKkcM1klUuGmJdYmwpYLNhTOggsHsA3sJidtazJKcuZzdszztRsLp_LwH1YzNnWpDNj5XOO41j5WTtnH2XgW72vPWk5ufyUbc8Uph2rUChkIPaIYLxinnb9wh_9A7dtnuQ)
