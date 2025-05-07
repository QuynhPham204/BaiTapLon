# Lấy dữ liệu tin tức từ Vietnamnet.vn

## 1. Mô tả dự án

Với dự án này kết hợp giữa **Robot Framework** và **SeleniumLibrary** để tự động tìm kiếm và thu thập dữ liệu tin tức từ trang tin tức [https://vietnamnet.vn/](https://vietnamnet.vn/), sau đó lưu kết quả vào file csv.

Quy trình được tự động chạy mỗi ngày lúc **6h sáng** từ một script Python (`run.py`).

---

## 2. Công nghệ sử dụng

- [Robot Framework](https://robotframework.org/)
- [SeleniumLibrary](https://robotframework.org/SeleniumLibrary/)
- Python
- Trình duyệt Chrome

---

## 3. Các bước thực hiện trong `tintuc.robot`

1. Truy cập trang chủ `vietnamnet.vn`.
2. Nhấn biểu tượng tìm kiếm.
3. Nhập từ khóa `"Công nghệ"` và bấm Enter.
4. Duyệt qua tất cả các trang kết quả.
5. Lấy tất cả dữ liệu của các trang.
6. Ở mỗi trang, lấy thông tin:
   - Tiêu đề bài viết
   - Mô tả bài viết
   - Hình ảnh
   - Nội dung bài viết
7. Lưu thông tin thu thập được vào file `csv`.

---

## 4. Tự động chạy với `run.py`

- Mỗi ngày lúc **06:00:00**, script `run.py` sẽ:
  - In ra dòng thông báo: `6h sáng, chạy Robot Framework`
  - Thực thi file `run.py` bằng lệnh: `python run.py`
  - Chờ 60 giây trước khi tiếp tục kiểm tra thời gian lần kế tiếp.

---

## 5. Cách chạy

Để tự động chạy vào 6h sáng, chạy script Python:

```bash
python run.py
```

---
