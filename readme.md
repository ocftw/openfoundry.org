# OpenFoundry.org 封存

## todo

- [ ] 把檔案中的外部資源內部化
- [ ] 把頁面中到 http(s)?://openfoundry.org 的連結改成相對連結
- [ ] 移除 <script>jQuery.extend(Drupal.settings...</script> 標籤

- [x] 再次列出所有的頁面目錄與標題清單
- [x] 檔案下載的頁面中的檔案加上連結
- [x] 刪掉「Search Keyword xxx Total: 1 results found.」頁面
- [x] 重新下載 *.tmp 檔案
- [x] 重新下載 *.delayed 檔案
- [x] 刪掉所有內容不是 html 的 .html 檔案
- [x] 加入 script 把 github lfs 管理的檔案動態指向 github repo
- [x] 把 binary 檔案都重搬到 LFS 上
- [x] 列出所有的頁面目錄與標題清單
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

詳細的鏡像過程可參考 commit history - [main branch](https://github.com/ocftw/openfoundry.org/commits/main/)、[gh-pages branch](https://github.com/ocftw/openfoundry.org/commits/gh-pages/)

1. 在 mac 上安裝 httrack

  ```bash
  ➜  ~ brew install httrack
  ```

2. 建立基礎鏡像

  ```bash
  ./httrack.sh
  ```

3. binary 檔案的擷取策略

  - 先只抓 html 網頁
  - 接著再從 hts-cache/new.txt 中列舉 binary 檔案
  - sftp 進去主機找該檔案，下載後置入，於 httrack.sh 手動排除該路徑
  - 再用 httrack_url_list.sh 抓取其餘的 binary 檔案

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

## 處理流程

1. 使用 `page_search_to_list.sh` 搜尋問題頁面（如 "Page not found"）
2. 使用 `files_to_urls.sh` 將檔案路徑轉換為 URL
3. 使用 `extract_media.sh` 提取多媒體檔案清單
4. 使用 `httrack_url_list.sh` 抓取清單列出的 URL 目標

## 完整頁面清單

[pages.tsv](https://github.com/ocftw/openfoundry.org/blob/main/pages.tsv) 中列舉了所有頁面

## 授權

- [main](https://github.com/ocftw/openfoundry.org/tree/main) branch 下的所有檔案以 CC0 釋出至公眾領域。
- [gh-pages](https://github.com/ocftw/openfoundry.org/tree/gh-pages) 內的網頁、影像與多媒體檔案，依循 [openfoundry.org 網站授權](https://openfoundry.org/terms-of-use.html)——除另有註明外，採用 [CC BY-NC-ND 4.0 創用CC「姓名標示─非商業性─禁止改作 4.0 國際」授權](https://creativecommons.org/licenses/by-nc-nd/4.0/deed.zh-hant) 及其後續版本授權釋出，請標明著作智慧財產權屬於中央研究院。