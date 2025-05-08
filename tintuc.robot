*** Settings ***
Library    SeleniumLibrary
Library    OperatingSystem
Library    Collections

*** Variables ***
${URL}                    https://vietnamnet.vn/
${BROWER}                 Chrome
${text_timKiem}           Công nghệ
${xp_btn_timKiem}         xpath=//span[@class="icon-search"]
${xp_btn_timKiem2}        //button[@class="btn__search"]
${xp_input_text}          xpath=//input[@class="input__search"]
${xp_baiViet}             xpath=//*[contains(@class,'horizontalPost')]
${xp_tieuDe}              xpath=//*[contains(@class,'horizontalPost__main-title')]
${xp_moTa}                xpath=//*[contains(@class,'horizontalPost__main-desc')]
${xp_hinhAnh}             xpath=//*[contains(@class,'horizontalPost__avt')]
${xp_noiDung}             xpath=//*[contains(@class,'horizontalPost__main-de')]
${xp_phanTrang}           xpath=//ul[contains(@class,'pagination__list')]//a
${xp_nut_tiep_theo}       xpath=//li[contains(@class, 'pagination-next')]//a
${xp_nut_truoc}           xpath=//li[contains(@class, 'pagination-prev')]//a
${luuFile}                data.csv
${trang_dang_xem}         1

*** Test Cases ***
Enter keyword
    [Documentation]    Tìm kiếm tin tức với từ khoá Công nghệ
    # 1. Vào website tin tức vietnamnet.vn.
    Open Browser    ${URL}    ${BROWER}    
    Maximize Browser Window
    Wait Until Element Is Visible    ${xp_btn_timKiem}
    Click Element    ${xp_btn_timKiem}
    # 2. Tìm một từ khoá tin tức bất kì(Công nghệ, ... ).
    Input Text    ${xp_input_text}    ${text_timKiem}
    # 3. Bấm ENTER để tìm kiếm từ khoá đã nhập.
    Press Keys    ${xp_input_text}    ENTER
    Sleep    2s
    Click pagination
    Close Browser


*** Keywords ***
Click pagination
    # 5. Lấy tất cả dữ liệu của các trang.
    ${phan_trang_elements}=    Get WebElements    ${xp_phanTrang}
    ${so_trang_elements}=    Get Length    ${phan_trang_elements}
    WHILE    ${trang_dang_xem} <= ${so_trang_elements}
        
        Run Keyword If    ${trang_dang_xem} < ${so_trang_elements}    Click Element    ${phan_trang_elements}[${trang_dang_xem}]
        Wait Until Element Is Visible    ${xp_tieuDe}    timeout=10
        Sleep    2s
        ${bai_viet_elements}=    Get WebElements    ${xp_baiViet}
        # 4. Lấy tất cả dữ liệu(Tiêu đề, Mô tả, Hình ảnh, Nội du) hiển thị ở bài viết.
        FOR    ${bai_viet}    IN    @{bai_viet_elements}
            ${text_tieu_de}    Get Text    ${xp_tieuDe}
            ${text_mo_ta}    Get Text    ${xp_moTa}
            ${text_hinh_anh}    Get Text    ${xp_hinhAnh}
            ${text_noi_dung}    Get Text    ${xp_noiDung}
            Log    Tiêu đề: ${text_tieu_de}
            Log    Mô tả: ${text_mo_ta}
            Log    Hình ảnh: ${text_hinh_anh}
            Log    Nội dung: ${text_noi_dung}
            # 6. Lưu dữ liệu đã lấy được vào file csv.
            Append To File    ${luuFile}    ${text_tieu_de},${text_mo_ta},${text_hinh_anh},${text_noi_dung}\n
        END

        ${nut_tiep_theo}=    Run Keyword And Return Status    Element Should Be Visible    ${xp_nut_tiep_theo}

        Run Keyword If    ${nut_tiep_theo} == False
        ...    ${phan_trang_elements}=    Get WebElements    ${xp_phanTrang}
        ...    ${so_trang_elements}=    Get Length    ${phan_trang_elements}
        ...    Run Keyword If    ${trang_dang_xem} >= ${so_trang_elements}    Exit For Loop

        Run Keyword If    ${nut_tiep_theo}    Click Element    ${xp_nut_tiep_theo}

        Wait Until Element Is Visible    ${xp_phanTrang}    timeout=10
        ${phan_trang_elements}=    Get WebElements    ${xp_phanTrang}
        ${so_trang_elements}=    Get Length    ${phan_trang_elements}

        ${trang_dang_xem}=    Evaluate    ${trang_dang_xem} + 1  
    END
