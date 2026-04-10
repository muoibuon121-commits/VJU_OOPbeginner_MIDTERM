# OOP_MIDTERM
#  B2B QuoteMaster(for MacOS) - Hệ thống Tự động hóa Báo giá & Hợp đồng

> Giải pháp số hóa quy trình chốt Sale cho doanh nghiệp SME, loại bỏ sai sót từ Excel và tối ưu hóa tỷ suất lợi nhuận.

##  1. Giới thiệu Dự án
Trong mô hình kinh doanh B2B, việc lập báo giá thủ công bằng Excel thường mất nhiều thời gian, dễ sai sót công thức và khó bảo mật giá vốn. **B2B QuoteMaster** ra đời nhằm tự động hóa quy trình này, giúp nhân viên Sales tạo báo giá phức tạp chỉ trong 5 phút với độ chính xác 100%, đồng thời tự động xuất file PDF chuyên nghiệp.

##  2. Tính năng Cốt lõi
```
- Trình tạo Báo giá Động: Thêm dịch vụ, tùy chọn (add-ons) với giá tiền được tự động nội suy.
- Bảo vệ Biên độ Lợi nhuận (Margin): Cảnh báo hoặc chặn việc thiết lập mức chiết khấu (Discount) khiến hợp đồng bị lỗ.
- Quản lý Phiên bản: Lưu trữ lịch sử chỉnh sửa các bản báo giá (V1, V2, V3...).
- Xuất PDF Tự động: Khởi tạo Hợp đồng/Báo giá định dạng PDF từ template có sẵn chỉ với 1 cú click.
```

##  3. Điểm sáng Kỹ thuật & Ứng dụng OOP
```
- Tính Đóng gói (Encapsulation): Các thuộc tính nhạy cảm như `__gia_von` được bảo mật nghiêm ngặt ở lớp Backend,
nhân viên Sales thao tác trên UI chỉ có thể truy xuất `gia_ban`.
- Decorator Design Pattern: Giải quyết bài toán "Tính giá động". Các dịch vụ gốc (Component) được bọc bởi các
Tùy chọn phụ (Decorator) để tự động cộng dồn chi phí một cách linh hoạt mà không cần tạo ra hàng trăm Class thừa thãi.
```

##  4. Công nghệ Sử dụng (Tech Stack)

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

## 5. Cấu trúc dự án
### Mindmap

[![](https://mermaid.ink/img/pako:eNqtVE2PmzAQ_SvIVcSuxCKcECDcmu7m1lvVQ4UUOTBhrWCbjk02bJT_XgO7JNltewonvzfz3gzjjyPJVQEkJZPJkUtuUueYScdxzTMIcFPH3TANrnfmfjLkbFOBdt9SbaBGLhi231SlsNN8eaKr-eppkJ3jP-BgzjkBnceL5cecpcIC8CJrmiSPdMyquIR_BrdKmhUTvGq76FfbZzXG8qrRBnC5K3vlqv_cLnjK5Ok0mWRScFkIVnccKmXu7jbTzZrLveI5rHVr5eL-frATTLIS_LodIMLvhqMdjjTaNwczsIXKd4APuRK10uC3ohr4XMktL4e142gwhstSj2aO02B1CV90yUfI6lqPeRpwBLYpu5FXQsfZc3i5ZqzEjoW_WuUV_6FmbqelxO3sWWGne8HUqIomN7exf9ujW_Vq-X1n99_52KOG7FY_8JeaBvTZvAPrT_49-16CeKREXpDUYAMesVsnWAdJf0cz0t_djKR2WTDcZcSeequpmfyllHiXoWrKZ5JuWaUtauqCGXjkrEQmRhZB9je0kYakUbzoTUh6JAeSTkM_Dul0FsTzaEbjeeyRlqQPNPHDRbCYzWkYJlEQnjzy2lelfkAXURLQ2TSIkmRGI49AwY3C78Or1D9Opz_eXmfn?type=png)](https://mermaid.live/edit#pako:eNqtVE2PmzAQ_SvIVcSuxCKcECDcmu7m1lvVQ4UUOTBhrWCbjk02bJT_XgO7JNltewonvzfz3gzjjyPJVQEkJZPJkUtuUueYScdxzTMIcFPH3TANrnfmfjLkbFOBdt9SbaBGLhi231SlsNN8eaKr-eppkJ3jP-BgzjkBnceL5cecpcIC8CJrmiSPdMyquIR_BrdKmhUTvGq76FfbZzXG8qrRBnC5K3vlqv_cLnjK5Ok0mWRScFkIVnccKmXu7jbTzZrLveI5rHVr5eL-frATTLIS_LodIMLvhqMdjjTaNwczsIXKd4APuRK10uC3ohr4XMktL4e142gwhstSj2aO02B1CV90yUfI6lqPeRpwBLYpu5FXQsfZc3i5ZqzEjoW_WuUV_6FmbqelxO3sWWGne8HUqIomN7exf9ujW_Vq-X1n99_52KOG7FY_8JeaBvTZvAPrT_49-16CeKREXpDUYAMesVsnWAdJf0cz0t_djKR2WTDcZcSeequpmfyllHiXoWrKZ5JuWaUtauqCGXjkrEQmRhZB9je0kYakUbzoTUh6JAeSTkM_Dul0FsTzaEbjeeyRlqQPNPHDRbCYzWkYJlEQnjzy2lelfkAXURLQ2TSIkmRGI49AwY3C78Or1D9Opz_eXmfn)
### ERD 
[![](https://mermaid.ink/img/pako:eNqdVd1u2jAUfhXLE4JJtEog_OWuBSJVU0vV0l5MSJGJ3WA1sanjVGXAU-wJqmmXewGqaRd9Et5kdgKEAOu25io53_nO_zmZQo9jAm1YKEwpo9IG0wEDoChHJCRFGxSHKCLFcia7RYKiYUCi4kpVAWNBQyQmbR5woTkfOpZjOlZKy_A-eZKZjlGzrFp3V-eUC0xEpmU2WyenmaWAMvJHMCIeZzgXiFNxTp3ORkMSIWleIXk2CnecSQeFNJho9ESlGhQ1NB-w-bxQGDAiOhT5AoUp4ea6ewVms6MjPgVnF7e9s3YX2GAA5XLxzEHJEwRJEn0cwH31du-if3XS7if6D_Fy8Y2B4PUnKIWIIX-L1L657vfOD_tho-XiBwMlQTxCH98g5bzdKzf3y8UvCUoR9dkWa611wNXr8xjg5ct35gNvpHLziSpGLru1tibPNmT3rN89TywMEQf-8uVrqAqj6ozolufLq17nZs9xxvVGFEiaxkyZF8SYYEBZwt_JeDWV-qFMAorB5adMFElBVQoMhWRPKNGTq9dhD0AYCxJFqXyej_gd7u4CjiSI1bq5auw9krO76cHbhrXIiyPJQyJchTlbGFZtUZ6RkK5-3QEIwzviVZCKIeN8kuuWvj-WBFPdFsiTB7FkRbA7nOynQKMoJjuxprWTXKLARSGPmfyPPNJ5-nsylD1y1ZdD8Y4Fx_HhVB5ixCSVk91g93uc3IF_Gpw4IuLgrAoerG3CMvQFxdCWIiZlqJoQIv0JEw_qGOm7PYB6jdR1vNcrozljxD5zHq5pgsf-CNp3KIjUVzzWZV_duo1UqNnR11lVHdr1ZjUxAu0pfIJ2xTpuWGalajRq9arZqDXKcALtI7N5bLWMVrVmWlazbljzMvySeDWPDbNVbxqmVbGMSt1qlSHBVHJxnv6Qkv_S_Dc85_3s?type=png)](https://mermaid.live/edit#pako:eNqdVd1u2jAUfhXLE4JJtEog_OWuBSJVU0vV0l5MSJGJ3WA1sanjVGXAU-wJqmmXewGqaRd9Et5kdgKEAOu25io53_nO_zmZQo9jAm1YKEwpo9IG0wEDoChHJCRFGxSHKCLFcia7RYKiYUCi4kpVAWNBQyQmbR5woTkfOpZjOlZKy_A-eZKZjlGzrFp3V-eUC0xEpmU2WyenmaWAMvJHMCIeZzgXiFNxTp3ORkMSIWleIXk2CnecSQeFNJho9ESlGhQ1NB-w-bxQGDAiOhT5AoUp4ea6ewVms6MjPgVnF7e9s3YX2GAA5XLxzEHJEwRJEn0cwH31du-if3XS7if6D_Fy8Y2B4PUnKIWIIX-L1L657vfOD_tho-XiBwMlQTxCH98g5bzdKzf3y8UvCUoR9dkWa611wNXr8xjg5ct35gNvpHLziSpGLru1tibPNmT3rN89TywMEQf-8uVrqAqj6ozolufLq17nZs9xxvVGFEiaxkyZF8SYYEBZwt_JeDWV-qFMAorB5adMFElBVQoMhWRPKNGTq9dhD0AYCxJFqXyej_gd7u4CjiSI1bq5auw9krO76cHbhrXIiyPJQyJchTlbGFZtUZ6RkK5-3QEIwzviVZCKIeN8kuuWvj-WBFPdFsiTB7FkRbA7nOynQKMoJjuxprWTXKLARSGPmfyPPNJ5-nsylD1y1ZdD8Y4Fx_HhVB5ixCSVk91g93uc3IF_Gpw4IuLgrAoerG3CMvQFxdCWIiZlqJoQIv0JEw_qGOm7PYB6jdR1vNcrozljxD5zHq5pgsf-CNp3KIjUVzzWZV_duo1UqNnR11lVHdr1ZjUxAu0pfIJ2xTpuWGalajRq9arZqDXKcALtI7N5bLWMVrVmWlazbljzMvySeDWPDbNVbxqmVbGMSt1qlSHBVHJxnv6Qkv_S_Dc85_3s)
### 3-Layer 
[![](https://mermaid.ink/img/pako:eNqVVE1v00AQ_SujrYpcKansdZ04llopH_0IJG1IXCRoOGztdWLqeNP1um1oe0YIISFx5AJCHDignkkOHNo_4n_CJnXSRBQq9uR5O_Pmzeh5z5HDXIos5AXs1OkSLsCutEOQZ3kZbj4ko3dhF8JO9-Y7Aef6iwNBMvrUB6VGBpRHK7epUXzY4aTfhQmqwUGjudna3LWLdnVvF2rF55tNyMIWZ6Ggofvytmh8XJ9TR_gsBLt0h-5XNaVJiSNW5jGs7Nj12gKkKyXGRCRk7wV8TakTQblPgux-Nb2RjdvhfXIxHJT2W9XdzVYLanvb1fJMcLFRfVCrzNGUyisSdhjIoW05JenRU8aPVhaSsNKi_MR3aLSI68ozEvguEWy2zb8q1eGgUrSLUCyXJ2JTmRUiyCGJ6INaKyVNabBIdDhtPZ3fZKWElb1mHdI56tISwT1qpCNqcTL6GHbATUZXEPjJ6E0MylgAbEkDpSWpC9bXNy62k9EPH3ZsuwFNehzTSEQX6drncvEk1-bxAE6S4Td58Qhsngy_zvdJ6_S5Oh2yq9mNC3iSDH8JOI7HFeKO5d5Ok4rHLenLJo36LIzoVJE2N6d9_XMATjcZvZX2711_jiFKhlcOKLOL9-HU_GIQ0OnMnh8E1hLVPey5GWlMdkStJawVcp6ehtlT3xVdC_fPMg4LGLeWVFX9gwlPmUzPoIUZ05pDPEP9LyY9ZfI8T6fqjMnzCqb6DyZNQxnU4b6LLLlRmkE9yntkHKLzcY82El3ao21kyU-X8KM2aoeXsqZPwheM9aZlnMWdLrI8EkQyivvS6bTiE-nq3gzl0mOUl1kcCmRpOK9OWJB1js5krKmrpmYaWDN1Q8c4l0EDZOVyqzndLBi6aZh5Xctplxn0etJWZmOsGnm8lpewmTNwBlHXl_9X_falmzx4l78BF7WXkg?type=png)](https://mermaid.live/edit#pako:eNqVVE1v00AQ_SujrYpcKansdZ04llopH_0IJG1IXCRoOGztdWLqeNP1um1oe0YIISFx5AJCHDignkkOHNo_4n_CJnXSRBQq9uR5O_Pmzeh5z5HDXIos5AXs1OkSLsCutEOQZ3kZbj4ko3dhF8JO9-Y7Aef6iwNBMvrUB6VGBpRHK7epUXzY4aTfhQmqwUGjudna3LWLdnVvF2rF55tNyMIWZ6Ggofvytmh8XJ9TR_gsBLt0h-5XNaVJiSNW5jGs7Nj12gKkKyXGRCRk7wV8TakTQblPgux-Nb2RjdvhfXIxHJT2W9XdzVYLanvb1fJMcLFRfVCrzNGUyisSdhjIoW05JenRU8aPVhaSsNKi_MR3aLSI68ozEvguEWy2zb8q1eGgUrSLUCyXJ2JTmRUiyCGJ6INaKyVNabBIdDhtPZ3fZKWElb1mHdI56tISwT1qpCNqcTL6GHbATUZXEPjJ6E0MylgAbEkDpSWpC9bXNy62k9EPH3ZsuwFNehzTSEQX6drncvEk1-bxAE6S4Td58Qhsngy_zvdJ6_S5Oh2yq9mNC3iSDH8JOI7HFeKO5d5Ok4rHLenLJo36LIzoVJE2N6d9_XMATjcZvZX2711_jiFKhlcOKLOL9-HU_GIQ0OnMnh8E1hLVPey5GWlMdkStJawVcp6ehtlT3xVdC_fPMg4LGLeWVFX9gwlPmUzPoIUZ05pDPEP9LyY9ZfI8T6fqjMnzCqb6DyZNQxnU4b6LLLlRmkE9yntkHKLzcY82El3ao21kyU-X8KM2aoeXsqZPwheM9aZlnMWdLrI8EkQyivvS6bTiE-nq3gzl0mOUl1kcCmRpOK9OWJB1js5krKmrpmYaWDN1Q8c4l0EDZOVyqzndLBi6aZh5Xctplxn0etJWZmOsGnm8lpewmTNwBlHXl_9X_falmzx4l78BF7WXkg)

## 6. So sánh hiệu năng

[![](https://mermaid.ink/img/pako:eNpNUr1u2zAQfpXDFYZSgDAkVZRFbnEStx0KFKiRodDCWIxEVKIEhgacGJo7Z-gQdMqUuU2nanRfRG9SSmqSbvzu-7nj4fa4qTOJHGezvdLKctinGsCzhaykx8HzyAs-F0aJi1Jeef9kjmiUDAbdqyBhx8vII_BChCOxWsWrOPiPMKoS5notd_akLmszinwaRfRsajaZ18qWchB9UjfjJKHf7LyBb1PdtrNZqp0K7CCbXCm-67uvYIu-u9U5LMMlHK377gf8ue27O1cpDo-CwKmw4kJcSQLHH9-_ThE4JPQp4Wy3kSU0LuKbCzr8cq6jtUMPsBkAgbeq774rKPrf9xqyw0-dTxEBRYK5URlya7aSYCVNJQaI46pSHFeYInfPTJgvKbpvOE8j9Oe6rp5spt7mBfJLUboJcdtkwspTJXIjqueqkTqT5qTeaos8YWwMQb7HHfIgDuYsoT5lbqU0ZJTgNfIFm7-JGYsWLKQs8WPaErwZu_pzSoOALeIo8aMk8n2XJjNla_NhOozxPtq_HN2vuw?type=png)](https://mermaid.live/edit#pako:eNpNUr1u2zAQfpXDFYZSgDAkVZRFbnEStx0KFKiRodDCWIxEVKIEhgacGJo7Z-gQdMqUuU2nanRfRG9SSmqSbvzu-7nj4fa4qTOJHGezvdLKctinGsCzhaykx8HzyAs-F0aJi1Jeef9kjmiUDAbdqyBhx8vII_BChCOxWsWrOPiPMKoS5notd_akLmszinwaRfRsajaZ18qWchB9UjfjJKHf7LyBb1PdtrNZqp0K7CCbXCm-67uvYIu-u9U5LMMlHK377gf8ue27O1cpDo-CwKmw4kJcSQLHH9-_ThE4JPQp4Wy3kSU0LuKbCzr8cq6jtUMPsBkAgbeq774rKPrf9xqyw0-dTxEBRYK5URlya7aSYCVNJQaI46pSHFeYInfPTJgvKbpvOE8j9Oe6rp5spt7mBfJLUboJcdtkwspTJXIjqueqkTqT5qTeaos8YWwMQb7HHfIgDuYsoT5lbqU0ZJTgNfIFm7-JGYsWLKQs8WPaErwZu_pzSoOALeIo8aMk8n2XJjNla_NhOozxPtq_HN2vuw)


