因為版權問題，我們以此檔案說明如何設計 DCT FPGA IP core。

首先實做硬體的 DCT.v，
然後用 Altera Quartus 中的 SOPC builder  開啟 Altera 公司 DE2 光碟中的 DE2_NIOS_DEVICE_LED 範例

接著選 create new component 將 DCT 加入，並紀錄 address 作為 firewarm 中的呼叫點



