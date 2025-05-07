import time
import os

file_path = r"D:\nam22_Quynh\TuDongHoaQuyTrinh\BaiTapClass\BaiTapTinTuc\tintuc.robot"

folder_path = os.path.dirname(file_path)

while True:
    current_time = time.strftime("%H:%M:%S")
    # 7. Set lịch chạy vào lúc 6h sáng hằng ngày.
    if current_time == "06:00:00":
        print("6h sáng, chạy Robot Framework")
        os.chdir(folder_path) 
        os.system('robot tintuc.robot')  
        time.sleep(60)  
    time.sleep(1)
