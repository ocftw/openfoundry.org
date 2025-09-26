demo 1

1. 安裝 Quartus for Linux
2. 將 new_de2_project20090830-1-SW_DCT-OK 解壓縮到硬碟中
3. 將 application/dct/ 中的兩個 script 都執行，會產生 dct app 和 shared lib
4. 將 application/signal/ 中的三個 script 都執行，會產生三個 daemon
5. 啟動 reconfiguration daemon, upload_daemon
6. 回到 de2_driver 目錄，insmod de2_usb_driver.ko
7. 啟動 dct app

demo 2

1. 將 new_de2_project20090831-2-DEMO2-OK 解壓縮到硬碟中
2. insmod de2_usb_driver.ko 
3. 執行 burn.sh
4. 執行 upload.sh
5. 啟動 request_forward daemon
6. 執行 dct app
