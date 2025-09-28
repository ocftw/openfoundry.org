# OpenFoundry.org 封存

## todo

- [ ] 列出所有的頁面目錄與標題清單
- [ ] 把檔案中的外部資源內部化
- [ ] 把頁面中到 http(s)?://openfoundry.org 的連結改成相對連結
- [ ] 移除 <script>jQuery.extend(Drupal.settings...</script> 標籤

- [x] 設定 git-pages repo 並將 /openfoundry.org/openfoundry.org 搬移到根目錄下以便打開 github pages
- [x] 刪除 <title>40x 的 HTML 檔案
- [x] 下載 to_be_download_url.txt 的檔案
- [x] 移除「Please log in or register to view or modify your profile.」的頁面
- [x] 下載 binary_list.txt 的檔案
- [x] 刪除沒有附檔名，但是有同名 .html 檔案的檔案
- [x] 排除的 of.openfoundry.org 另行處理
- [x] 列出所有的 binary 檔案清單並且抓取
- [x] 列出目前檔案中連結的多媒體檔案清單
- [x] 把所有的 page not found 刪除
- [x] 移除 0 Bytes 的檔案
- [x] 處理 `<TITLE>Page has moved</TITLE>` 的 .html 頁面
- [x] 處理「Click here...」的 html 頁面
- [x] 移除有對應檔案的 0 bytes HTML 檔案
- [x] 列出所有尚未 commit 的檔案清單

## 建立鏡像流程

### 在 mac 上安裝 httrack

```bash
➜  ~ brew install httrack
```

### Mirror

```bash
./httrack.sh
```

### 看到 binary 的策略

1. 第一次先抓 html
2. 第二次再從 hts-cache/new.txt 抓 binary

用 sftp 進去主機找該檔案，另外下載後置入，於 httrack.sh 手動排除該路徑

### binary 檔案位置

```text
/archived/*.zip
/wsw/dmdocuments/*.pdf
/of/MOST/103/*.pdf
/of/MOST/102_testing/*.pdf
/of/nsc_upload_dir/*.pdf
/of/public/tmp/nsc101-20130618/*.pdf
/of/public/download/* (120GB, 暫且不抓) //FIXME
```

## 處理腳本

### 1. page_search_to_list.sh - 搜尋特定文字並建立檔案列表

用法：`./page_search_to_list.sh "Page not found"`

功能：搜尋包含指定文字的檔案並建立 matched_files.txt

### 2. files_to_urls.sh - 將檔案路徑轉換為 URL

用法：`./files_to_urls.sh`

功能：從 matched_files.txt 讀取檔案列表，生成對應的 URL 列表到 matched_urls.txt

### 3. extract_media.sh - 提取多媒體檔案清單

用法：`./extract_media.sh`

功能：從 HTTrack 記錄中提取 openfoundry.org 域名下被略過的多媒體檔案，生成 media_tbd_openfoundry.txt 列表

## 處理流程

1. 使用 `page_search_to_list.sh` 搜尋問題頁面（如 "Page not found"）
2. 使用 `files_to_urls.sh` 將檔案路徑轉換為 URL
3. 使用 `extract_media.sh` 提取多媒體檔案清單
4. 根據 todo 清單逐一處理各項任務
