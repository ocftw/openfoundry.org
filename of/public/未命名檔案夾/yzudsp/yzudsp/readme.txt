demo 1

1. �w�� Quartus for Linux
2. �N new_de2_project20090830-1-SW_DCT-OK �����Y��w�Ф�
3. �N application/dct/ ������� script ������A�|���� dct app �M shared lib
4. �N application/signal/ �����T�� script ������A�|���ͤT�� daemon
5. �Ұ� reconfiguration daemon, upload_daemon
6. �^�� de2_driver �ؿ��Ainsmod de2_usb_driver.ko
7. �Ұ� dct app

demo 2

1. �N new_de2_project20090831-2-DEMO2-OK �����Y��w�Ф�
2. insmod de2_usb_driver.ko 
3. ���� burn.sh
4. ���� upload.sh
5. �Ұ� request_forward daemon
6. ���� dct app
