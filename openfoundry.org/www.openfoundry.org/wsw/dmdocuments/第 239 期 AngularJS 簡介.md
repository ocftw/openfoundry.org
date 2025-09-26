___

□■□ 自由軟體鑄造場電子報第 239 期 | 2014/04/15 □■□
___

◎ 本期主題︰AngularJS 簡介

◎ 訂閱網址︰[http://www.openfoundry.org/tw/news/](http://www.openfoundry.org/tw/news/)

◎ 下次發報時間︰2014/04/29

#本期內容#

___

##[技術專欄] AngularJS 簡介

劉佩昀／文

### 甚麼是 AngularJS？

AngularJS 是一個使用 HTML、JavaScript 和 CSS 來建立 Web 應用程式的框架（Framework），其由 Google 所創建，用來協助單一頁面應用程式的運行。

它可以擴展應用程式中的 HTML 詞彙，從而在 Web 應用程式中使用 HTML 聲明動態內容，並擴展 HTML 的語法，以便清晰、簡潔地表示應用程式中的組件，並允許將標準的 HTML 作為你的模板語言（Template Language）。

函式庫讀取包含附加自定義（標籤屬性）的 HTML，遵從這些自定義屬性中的指令，可將頁面中的輸入或輸出與 JavaScript 的變量表示模型綁定起來。這些 JavaScript 變量的值可以手動設置，或從靜態／動態的 JSON 資源中獲取。

AngularJS 可以通過雙向資料綁定（Two-way Data Binding），自動從擁有 JavaScript 對象（模型）的 UI（視圖）中同步數據。AngularJS 提供了強大的資料綁定、依賴注入（Dependency Injection）...等，使你可以測試和維護 Webapp。


1、	有別於傳統的函式庫或框架，AngularJS 擁有屬於自己的一套：

-   直接以 HTML（DOM）當成 Template 來使用
-   將 HTML 變成可複用的元件
-   資料綁定在 `{{}}` 裡面
-   支援表單操作與表單驗證
-   將程式碼（Code-behind）綁定在 DOM 元素上

2、	AngularJS 完整的前端解決方案：

-   適合用於 CRUE 類型的網站專案／後台（資料連結、基本範本指令、表單驗證...）
-   不適合用於需要大量 DOM 操作的網站
-   完整的單元測試與 E2E（End to End）測試架構

3、	AngularJS 表達式（Angular Expressions）：

-   使用「JavaScript」語法表達模型的程式片段
-   通常用來輸出 Model 的資料或執行控制器的函式
-   範例：`{{9*9}}`、`{{sum()}}`、`{{'hello'}}`


###AngularJS 框架介紹：

一個由 Google 打造的前端 JavaScript 框架，與其他 JS 框架最大的不同在於，它直接延伸現有的 HTML 架構，透過宣告式語法（Directives Syntax）直接賦予 HTML 額外的能力，並通過雙向的資料綁定來適應動態內容。雙向資料綁定允許模型和視圖之間自動同步。因此，AngularJS 提升了可測試性，也讓 Web 應用程式在元件化的過程變得極其簡潔有力。

1、	AngularJS 的強項：

-   「關注點分離」：<p>
	控制器（Controllers）與檢視（Views）之間切割的非常乾淨，再搭配模組（Module）與依賴性注入相關實作。將商業邏輯從 HTML 中抽離，簡化複雜度（從 DOM 操作中分離思考），以及將網站的前／後端乾淨分離，並簡化後端開發。
-   「以習慣取代配置」：<p>
	AngularJS 所設計的宣告式語法直接延伸 HTML 的能力，讓許多 AngularJS 自訂的 HTML 屬性能自然地融入其中，並賦予其意義，而這就是所謂的習慣（Convention）。這是大多數 JS 框架不敢做的嘗試，也因為如此，這樣的設計觀點並不是所有人都能接受。

2、	在 AngularJS 裡，當瀏覽器將 HTML 與這些 AngularJS 自訂的語法解析成 DOM 物件之後，AngularJS 會直接將原生的 DOM 物件當作網頁片段的範本，然後直接以 DOM 物件（原生的 JavaScript 物件）進行操作。這大幅減少了轉換型別的成本，但相對在範本操作的過程，其效能也比其他框架高出許多，這也就是AngularJS 所謂的 DOM Templates 特性。

3、	AngularJS 所提供的雙向資料綁定特性，可以說是最實用的功能之一，雖然這個特性並不是 AngularJS 獨有（其他 JS 框架也大多都有此特性），不過對於沒有接觸過其他框架的人來說，這確實是一個非常有趣的功能之一。

###AngularJS的設計與目標：

AngularJS 信奉的是，當組建視圖（UI）與寫軟件邏輯同時進行時，聲明式的代碼會比命令式的代碼來的好，儘管命令式的代碼非常適合用來表達業務邏輯。

AngularJS 透過 MVC（Model-View-Controller）模式功能增強瀏覽器的應用，使開發和測試變得容易，並通過依賴注入為客戶端的 Web 應用提供了傳統服務端的服務，例如獨立於視圖的控制。因此，後端減少了許多負擔，產生了更簡單的 Web 應用。


1、	AngularJS 的理念：

-   將應用邏輯與對 DOM 的操作分開處理（提高代碼的可測試性）
-   應用程序的測試與應用程序的編寫一樣重要（代碼的構成方式對測試的難度有巨大的影響）
-   將應用程序的客戶端與服務器端分開（這允許客戶端和服務器端的開發可以齊頭並進，並且讓雙方的複用成為可能）
-   指導開發者完成建立應用程序的整個歷程（從用戶界面的設計，到編寫業務邏輯，再到測試）
-   化繁為簡（總是好的）

2、	可以免除以下痛苦：

-   註冊大量的 Callback 函式（回調容易打亂代碼的可讀性）
-   大量操作 DOM 物件（DOM 很笨重且容易出錯）
-   從 UI 中擷取與資料處理（非具體的業務邏輯和業務細節）
-   需要撰寫大量的初始化程式才能使用框架



<br>
*參考資料：*

*[AngularJS 官網](http://angularjs.org)、*

*[AngularJS 維基百科](http://zh.wikipedia.org/wiki/AngularJS)、*

*[AngularJS 入門簡介](http://www.slideshare.net/kurotanshi/angularjs-31606698)*

*[前端工程的極致精品： AngularJS 開發框架介紹](http://blog.miniasp.com/post/2013/04/24/Front-end-Engineering-Fineart-An-Introduction-to-AngularJS.aspx)、*
___

##[源碼秘技] 嘗試 Arduino 初學者套件##

謝良奇／翻譯

◎本文翻譯自 opensource.com，原作者為 Luis Ibanez︰[http://opensource.com/education/14/3/arduino-starter-pack#comment-14709](http://opensource.com/education/14/3/arduino-starter-pack#comment-14709)

你是 Arduino 新手嗎？對於想要著手接觸這套小型電腦板的人，來自 Adafruit 的開放硬體 Arduino 初學者套件 (Arduino Starter Pack) 是不錯的入門磚，對於開放硬體的新手，或是想在專案中利用 Arduino 微控制器的人來說，都是理想的套件。

首先，你需要一部電腦用來撰寫在 Arduino 板上執行的程式。這套初學套件採用的是 Arduino Uno，這或許是最簡單的版本。一般的程式開發流程是，你先在電腦上寫好程式，透過標準 USB 纜線上傳到 Arduino 板上。不論 Linux、Mac 或 Windows 上都有 Arduino 的軟體。

當我開始玩起 Arduino 初學者套件時，我按照網站上在 Linux (Ubuntu 12.10) 安裝套件的步驟：

	 sudo apt-get update
	 sudo apt-get install arduino arduino-core

此時，我忍不住先暫停一下，轉而感謝 Linux 的套件包裝者 Scott Howard 與 Philip Hands。多謝他們對 Debian 的 Arduino 與 Arduino-core 套件的優秀維護成果。之後，我參考了 [Arduino 的教學](http://arduino.cc/en/Tutorial/HomePage)。裡頭有豐富的範例專案。然後我選了這個 [LED 專案](http://arduino.cc/en/Tutorial/Blink#.UxFKcx-M5eY)。

###LED Arduino 專案的步驟###

硬體

* 拿套件裡的紅色 LED，把短腳（陰極）接到 Arduino UNO 板的接地腳位 (GND)。
* 把紅色 LED 的長腳 (陽極)，接到麵包板線路上。
* 拿一個 1K 歐姆電阻（棕色，黑色，紅色），然後接到 Arduino 板的第 13 腳位。如果你不熟悉電阻器的色碼，可以試試這個圖形化的[電阻計算器](http://www.dannyg.com/examples/res2/resistor.htm)。
* 把電阻另一端，接到麵包板上和 LED 腳同一列的地方。
* 用 USB 把 Arduino 接上電腦。

軟體

* 從命令列啟動 Arduino 程式。
* 輸入下列程式碼。

*

	/* 閃爍 重複把 LED 亮起 1 秒鐘後，接著關掉 1 秒鐘。本範例程式碼屬於公眾領域。
	/* 
	
	// 選擇我們連接 LED 的腳位， 
	// 然後加以命名： 
	int led = 13; 
	// setup 程序會在每次按下重置鍵時執行： 
	void setup() { 
	  // 將該腳位初始化為輸出。 
	  pinMode(led, OUTPUT); 
	  } 
	
	// 不斷執行的 loop 程序： 
	void loop() { 

	  digitalWrite(led, HIGH);         // 讓 LED 亮 
	                                   // (HIGH 是電壓水平) 
	  delay(1000);             		   // 
	  等一秒鐘 digitalWrite(led, LOW);  // 藉由降低電壓關閉 LED delay(1000);                 // 等一秒鐘 }

最後，按下 CTRL+U 把程式上傳到 Arduino （或使用檔案上傳選單）。就會看到 LED 以 1 秒鐘的間隔閃爍不停。

從打開包裝到 LED 成功閃爍，整個過程只花約半個小時。

此時，我把電源供應接上板子，拔掉 USB 線。Arduino 板還是持續執行程式，LED 也不斷地開心閃爍。

[LED 淡出淡入](http://arduino.cc/en/Tutorial/Fade#.UxH3TB-M5eZ)是另一個好例子。

Arduino 板還可以讀取來自電子元件的數值，並以此作為程式邏輯的一部份來驅動其他元件。因此，下一步，我嘗試了這個 [LED 淡出淡入](http://arduino.cc/en/Tutorial/AnalogInOutSerial#.UxH7NB-M5eY)的範例，其中用到電位計 (potentiometer) 來控制 LED的淡出入。

這個時候，我開始大膽冒險修改範例。我試著結合光敏電阻 (photoresistor) 來改變 LED 的亮度。

按照之後的範例步驟，勇敢挺進嘗試做你自己的修改，是很棒也很重要的一步。這對於各種事物的學習，特別是開放硬體，是相當關鍵的態度。假如你準備教導其他人的話，請記住這一點。為了避免挫折感，以及長時間的除錯過程，重要的是從簡單的地方開始，然後逐漸小步伐推進，直到通盤掌握。

Arduino 初學者套件是很棒的元件組合。這個套件能確保你擁有首次踏入開放硬體或嘗試 Arduino 所需的一切，而不用面對任何失望和挫折。在幾小時之內，就能追趕上開放硬體、程式開發、動手組裝電子元件。這個套件結合 Arduino 網站的豐富資訊，以及極廣大社群的支援，你將有愉快的體驗。

Arduino 新手還有其他許多入門教材，例如這些[書籍](http://www.amazon.com/s/ref=nb_sb_noss_1?url=search-alias%3Dstripbooks&field-keywords=arduino&sprefix=arduin%2Cstripbooks&rh=i%3Astripbooks%2Ck%3Aarduino)與[影片](http://learn.adafruit.com/search?q=arduino)。[ABC Arduino](http://www.indiegogo.com/projects/arduino-basic-connections-the-book) 這本書有一系列描繪清晰且顏色鮮豔的關鍵電路圖，提供了在 Arduino 板上接線所需的資訊。
___

##[自由專欄] 利用開源軟體提高生產力##

謝良奇／編譯

◎本文翻譯自 Linuxaria︰[http://linuxaria.com/article/productivity-boosting-with-open-source-applications?lang=en](http://linuxaria.com/article/productivity-boosting-with-open-source-applications?lang=en)

生產力至關重要。生產力的提升有助節省時間，在短時間內完成更多工作。這也是今天許多工廠生產線自動化的原因。提高生產力在平日電腦使用上也很重要。不論是一般桌面用戶、進階用戶、開發者、播客 (podcaster)，生產力提升都有助你節省時間、完成更多工作，甚至是降低磁碟空間、CPU、記憶體用量。很多人不知道，有許多很棒的開源軟體可以幫助提高生產力。其中有些是每個 Linux 作業系統都有的標準 GNU 工具，有的則是主要 Linux 散佈套件的標準元件。

1. Linux 終端器︰<p>Linux 主控台 (Linux console) 很有用且功能強大。每位用戶都應該把學習主控台列在待辦事項上。現在大多數用戶都視主控台為過時軟體，然而主控台事實上並未壽終正寢。有數百萬用戶每天都會使用它。比起 GUI 應用軟體，在主控台裡進行系統管理、資料庫、開發等工作會更有效率。</p>

2. Libreoffice︰<p>
Libreoffice 是 2010 年從 Openoffice 分支出去的辦公室生產套件，可用來編輯文檔、做桌面出版、試算表、投影片、製作圖表與數學運算。此外 Libreoffice 也有一些很酷的功能與插件，有助於提高你的生產力。</p><p>Libreoffice 可以用來維護家庭與辦公室使用的小型資料庫。透過 Libreoffice 你也可以安裝延伸套件，編輯 Mediawiki 伺服器的圍紀 (wiki) 頁面而無需熟悉其語法。為此，你需要的是 wiki-publisher 插件。wiki-publisher 插件讓你可以就像一般文檔一樣編輯圍紀文件。其他有用的插件還有 nlpsolver（提供 Solver 引擎可幫助解非線性模型）和 presentation minimizer （縮減投影片檔案大小）。</p>

3. VIM︰<p>從 1970 初期 VI 就已經是知名的文字編輯器。Bram Moolenaar 在 1988 年開始以 VI 為基礎開發 VIM。1991 年為 Amiga 電腦釋出時，它叫 VI Imitation。在 1993 年 2.0 版釋出時，VIM 改名為 VI Improved。在很短的時間內，VIM 就在用戶間受到廣大歡迎。</p><p>採用自己的軟體授權釋出為自由軟體，VIM 的授權被稱為慈善軟體授權 (charityware license)，相容於 GNU 通用公共授權。VIM 有助你提高生產力並完成工作。至於快捷鍵和速查表，可以造訪[這裡](http://www.fprintf.net/vimCheatSheet.html)。以下是不錯的 VIM 插件。</p>

	* MRU – MRU 有助你追蹤並重用最近用過的文件。
	* VIMExplorer –  VIM 的檔案管理器。
	* NERDTree – 先進的 VIM 檔案瀏覽器。
	* NERDCommenter – 註解編輯器。
	* snipMATE – 為 VIM 提供 Textmates 的 程式碼片段 (snippets) 功能。
	* bufferexplorer – VIM 暫存區瀏覽器。
	* calendar – 看插件名稱應該就知道了吧（日曆）。
	* Fugitive – 整合 VIM 與 Git 的強大插件。
[這](http://linuxaria.com/howto/use-vim-at-its-best-to-edit-your-puppet-manifests?lang=en)是我在 GIT+Puppet+markdown 語言上工作的設定。如果你喜歡，請複製我在 github 上的[設定](https://github.com/ricciocri/vimrc)。</p>
4. Xmonad︰<p>像 GNOME 3 或 KDE4 這樣新穎且現代化的桌面管理器，外觀總是華麗多彩。雖然看起來很棒，但是外觀並非一切。在我看來，隱藏於外觀下的事物更為重要。</p>
所幸某些介面走的是不同路線。它們被稱之為視窗管理器。視窗管理器分為兩大類，浮動式視窗管理器與平鋪式視窗管理器 (tiling window managers)。平鋪式視窗管理器在提高生產力這一點上，引起了我的關注。Xmonad 是最普及的平鋪視窗管理器之一。<br><br>
Xmonad 是用 Haskell 撰寫的平鋪式視窗管理器，在 2007 年時作為 DWM 的分支而登場。一開始，Xmonad 只是把 DWM 從 C 改寫至 Haskell 而已。不過到了今天，Xmonad 擁有 DWM 所沒有的功能，而且許多還是 Xmonad 特有的功能。<br><br>
它的安裝簡便，幾乎所有散佈套件的套件庫都有 Xmonad。設定可以透過用戶家目錄底下的 .xmonad 資料夾裡的 xmonad.hf 檔案完成。Xmonad 也可以當作獨立的視窗管理器，或作為 GNOME、Xfce或 KDE 的視窗管理器。

5. Z Shell︰<p>簡單來說，Z Shell 或 ZSH 會是你用到的最後一套 shell。ZSH 是一套作為互動式 shell 與腳本直譯器的 shell。ZSH 相容於 Bash，並有許多優於 Bash 之處，像是：</p>

    * 速度
	* 更好的 tab 自動完成
	* 更好的檔名匹配 (globbing)
	* 更好的陣列處理
	* 可完全客制化

<p>在安裝 ZSH 前，用 echo $SHELL 確認你正在使用的 shell。多數散佈套件的套件庫都有 ZSH，因此只需抓取後安裝在系統上。Slackware 預先安裝了 ZSH，在設定剛安裝好的 Slackware 系統時，你可以選擇用 ZSH 作為預設 shell。執行 chsh -s $ (which zsh) 可以把 ZSH 設為預設 shell。在開始使用前，你得登出然後再登入，有時則必須重新開機。你可透過若干腳本進行組態設定：<p>
	
	/etc/prpfile
	~/.zshenv 
	~/.zshrc 
	~/.zshprofile 
	~/.zshlogin 
	~/zshlogout

我知道這些套件並不是都能讓每個人用來提高生產力，這還得看你從事的是什麼工作。或許對你而言 GIMP 是殺手級應用程式，但我卻很少用到。

不過有助提高生產力的套件並不僅于此，Mplayer、ffmpeg、MPD、mutt、Turpial、WordPress、RSSOwl、Task Coach、Bibus、Storybook，不管你所處領域為何，你從事何種工作，總有開源應用軟體可以幫助你提高你的生產力。
___

##[自由專欄] 2014 年，5 種開源的轉換技術 ##

劉佩昀／翻譯

◎本文翻譯自 opensource.com，原作者為 Eren Niazi：[http://opensource.com/business/14/2/5-ways-open-source-transforming-tech-2014](http://opensource.com/business/14/2/5-ways-open-source-transforming-tech-2014)

在過去的十年中，我們看見了在開源和專有技術之間如史詩般的競爭正展開，而 2014 年，將會是徹底改變的一年。當私人企業在開放原始碼的開發投入資源，而開源公司也在嘗試調整他們的商業模式的時候，開源和專有技術的界限正變得模糊且不能挽救。而這些表示開源社群正進行著技術性的商業活動，以備在資訊爆炸的 21 世紀裡能夠保有競爭力。

開源運動，建立在「匯集市井小民的點子」和共工合作的可擴展性，而這也正吞噬著專有技術的世界。要明白科技世界的未來走向，我相信我們需要在這五個開源的趨勢上保持密切的關注：

### 1. 資料儲存叢集 

在 2014 年，開源技術將讓資料中心把儲存資料的系統叢集在一起，讓它們保持快速。該軟體將使我們能複製整個存儲系統，使得幾分鐘內在線上帶來新的資料庫伺服器變得可能。本質上來說，開源技術將會解決高速吸收大量資料的問題。

這種能力在快速建立儲存的空間是重要的，因為我們的數位資料範圍正迅速擴大。在 2011 年，國際數據資料公司（IDC）發現，全球的數據資料容量大約每兩年多了一倍，而到了 2020 年我們的數據範圍將擁有 40 萬億 gigabytes。根據這份報告，由企業的資料中心託管的信息量將成長 50 倍。開源的資料儲存叢集將使之有效的擴張且能負荷得起。

### 2. 專有軟體公司走向開源

專有軟體供應商在支持開源技術上受到巨大的壓力。雖然 Oracle 被認為曾屏棄開源，但該公司擁有至少 14 項活躍的創始開源專案，且已成為 OpenStack 基金會的企業贊助商，並計劃將 OpenStack 功能結合到其產品與雲端服務。在 2013 年 9 月，IBM 宣布將投資十億到 Linux 和開源創新來幫助其客戶運行大量數據以及在 IBM's Power Systems 伺服器的雲端計算解決方案。就在今年 1 月，微軟透過 Facebook 的 Open Compute Project 開放其 Azure 雲端伺服器的原始設計，其他科技巨頭也紛紛效仿。

在今年，開源將進一步的進展到政府部門。美國政府已經建立 OpenSource.gov，一個後端的網站，致力於幫助各部門遷移至開源技術。五角大廈的國防高級研究計劃局（DARPA）資助並促進了超過 70 個與數據基礎建設、可視化和分析功能相關的開源項目。美國國家安全局（NSA）至開放 Apache Accumulo 的源碼，其 NoSQL 資料庫。幸虧有 Open Source Digital Voting Foundation 這樣的機構，美國大選可快速的利用在開源平台上的數字投票，就像愛沙尼亞和挪威。大規模採用開源的政府，將給專有軟體公司額外的壓力。

### 3. 高效能計算

開源將創造出下一代高性能計算叢集背後所需的大量資料分析和應用。這樣的高速計算叢集以毫秒為單位分析龐大的資料。現今的企業需要這樣的能力來讓收集到的資料變得有用。叢集還可以幫助企業網站能承受大幅度資料變動︰使用者登入網站和其他功能使用上的變動，而不至於影響效能。叢集的技術可回溯至 2004 年，在資料的分析對於商業策略顯得重要之前就被發明了，而在今天，它將會成為定義資料合理價值的關鍵角色。

### 4. 行動裝置開發

隨著桌上型電腦的衰退，行動裝置相對地興起，開源技術正在為卓越的行動裝置發展奠定基礎。現有的平台如 Joomla、Convertigo、DreamFactory、OpenMEAP，和其他許多允許開發者建立自己的產品，且快速有規模的進入市場。開源的程式語言、資料庫、中介軟體引擎和其他工具等，將繼續激起行動裝置開發和行動開源生態系統的成長。

### 5. 大學教授開源技術課程

大學一直是開源技術的使用者和生產者，且學生們在活動中得到收穫。依照 VentureBeat 十一月的報導，二十二所大學包括 Stanford、MIT、Berkley 和 Carnegie Mellon，都在提供學生安排學分作業的開源項目上與 Facebook 合作。多所大學正在調整它們的課程，並且欣然接受這樣的機會，以確保學生在畢業時有著所需技能和最好的就業前景。除了 Facebook 的靈感計畫外，每一個一流的科技大學使其教職員們致力於開源項目（通常與他們的學生們）。至於美國在高中、初中和中學的電腦教育上產生疏忽，我毫不懷疑開源技術將會找到它的方法進入他們的課程裡。


開源與專利的對抗已經結束，因為大部分在企業和政府的關鍵科學技術人員承認在更低的價格上，比起專利的解決方法，開源技術提供了更高的性能、可擴展性和可靠性。開源在數據的儲存叢集、高性能的計算、分析和移動開發的領導性，在未來的十年將是開源的優勢。開源在專利軟體供應商和增加開源技術教育之間的改變，也將改變國際間科技員工的學習，掌握和執行開源的方法遍及每一個重要的產業。希望我們記得的 2014 年，是我們開始認為開源是一個模範、而不是技術革新的一個例外。
___

##[源碼新聞] 從專有軟體到開源軟體─微軟的開源之路##



四貓／編譯

![圖一：DOS操作畫面](https://www.openfoundry.org/images/140412/Ms_dos.jpg)

（圖片引用自︰<http://commons.wikimedia.org/wiki/File:Ms_dos.jpg>）



2014年3月26日，微軟與計算機歷史博物館（Computer History Museum）合作，將較早期版 MS-DOS 和 Word for Windows（Windows 1.1a 版）的原始碼公開。儘管微軟在近幾年已經對開放原始碼一事開始積極配合與參與，這仍是第一個被釋放出來的微軟作業系統原始碼。



早年微軟對於自由軟體的態度相當排斥，漠視社會上對於微軟公開原始碼的呼聲，找出許多理由：諸如資訊安全、開發效率、商業機密等等，嚴詞拒絕公開其原始碼。而後開放原始碼活動席捲了整個世界，人們發現開放原始碼能夠讓程式開發的周期大幅縮短，減少非常多不必要的重複開發，並且讓世界上所有的人都能參與應用設計，所帶來的效益提升與創新都遠遠不是一家公司的工程師所能比擬的，那怕龐大如微軟聚集了幾千名優秀的工程師也一樣。



時至今日，GOOGLE 的 ANDROID 系統就是公開原始碼的一員，而開發者與使用者都從其中獲得龐大的演進動力，這世界完全不一樣了。而微軟在這過程中也慢慢地發現，公開原始碼對其並不見得全然都是壞處，尤其在資訊安全這部分是完全無法迴避的：許多國家的國家安全組織對於不公開原始碼的軟體懷有恐懼，無法確信裡面是否有來自美國老大哥的間諜程式在裡面，而公開原始碼能有效的減低這種疑慮。



因此 2004 年 9 月 20 日，微軟宣布將提供 Microsoft Office 2003 程式原始碼的免費存取授權，給包括臺灣在內的參加「政府安全計劃」的國家與國際性組織。這很大程度上清除了 1999 年以來的美國國家安全局間諜程式存的的謠言。另外微軟也加入了各種開放原始碼的組織，在  LINUX 與 JAVA 等各種團體中都可以看到微軟的身影，甚至成為主要合作公司之一。



今年初，.NET 編譯平台 Roslyn 也開放了原始碼，雖然這是一個僅對於開發者來說比較有意義的項目，但是依然是一個重要的風向指標，顯示微軟對於自由軟體，或者是說對公開原始碼越來越認同了。但是值得注意的是，微軟這次是捐給博物館作為展覽使用，雖然可以公開下載，但是在使用上則沒有任何的授權，所以並不符合現在所謂的開源軟體的定義，僅是個可以參考與觀摩研究的展覽品罷了。



然而，儘管這次公開的是已經是 30 年的老軟體了，但仍然有著不凡的意義，畢竟這些軟體伴隨著我們的成長與乘載著過去的記憶，在翻閱這些原始碼以緬懷過去以外，也象徵著開放原始碼的潮流不可阻擋，在可見的未來應該會有更多的原始碼釋出，讓我們拭目以待吧。  




###參考網址︰  


* [軟體之寶：計算機歷史博物館典藏之歷史原始碼系列 ─ 微軟 MS-DOS 早期版本原始碼](http://www.computerhistory.org/atchm/microsoft-ms-dos-early-source-code/)


* [軟體之寶：計算機歷史博物館典藏之歷史原始碼系列 ─ Word for Windows 1.1a 版原始碼](http://www.computerhistory.org/atchm/microsoft-word-for-windows-1-1a-source-code/)


* [微軟終於開放 MS-DOS 原始碼](http://www.wired.com/2014/03/msdos-source-code/)


* [為何微軟將會釋出 MS-DOS 與 Word 早期版本原始碼](http://www.zdnet.com/why-would-microsoft-release-early-ms-dos-and-word-code-7000027880/)

___

##[源碼新聞] 開源框架創造「超級」網路應用程式##

謝良奇／翻譯

◎本文翻譯自 opensource.com，原作者為 Michael Babker︰[http://opensource.com/business/14/4/open-source-frameworks-web-based-apps](http://opensource.com/business/14/4/open-source-frameworks-web-based-apps)

假如你希望搭配出世界上最棒的水果籃，你不會只從一個果園挑選所有的水果。你會收集各產地最棒的東西，像是華盛頓蘋果，來自佛羅里達州的柑橘，和夏威夷的鳳梨。

按照同樣的邏輯，許多程式設計者與開發者為了創造自己的客制化網站、內容管理系統與其他網路應用與服務，也會組合不同的開源網路應用程式框架 (Web Application Frameworks，WAF)。

這種包含眾多網路應用程式框架 DNA 的嵌合體應用程式，成為了私有開發或利用開源內容管理系統，撰寫網路應用程式或網站之外，一種新興的替代選擇。

開源網路應用程式框架運動背後有三大主要關鍵：控制與客制性高、沒有額外開銷、與其他開源軟體的互通性。

偏好避免從頭到尾撰寫整個產品的開發者，或許對使用私有軟體建制網路產品感到輕鬆愉快。然而，這麼做有個缺點：無法客制化預先開發好的解決方案，以及修改可更動之處帶來的額外開銷。就算是免費的開源內容管理系統，只要是其應用軟體架構或運作方式過於僵化，仍會有上述缺點。

另一方面，開源的網路應用程式框架，像是最近推出以 PHP 為基礎的 Joomla Framework，卻能讓程式設計者更細微地控制其網站或網路應用，好在利用框架工具的同時，還能改進、調整和加以重新配置。

然而該領域最刺激的趨勢，是開發者能結合個別工具，或利用多重開源框架與程式庫，創造或優化出混合式解決方案，以滿足程式設計者的目標。

舉例而言，某位開發者，可能會拿 Joomla 的應用軟體與路由套件，加上另一家網路應用程式框架供應商 Symfony 的連線管理功能，以及像是競爭供應商 Doctrine 的資料庫套件，還有 Monolog 的日誌方案。程式設計者不僅免去為這些程序撰寫程式的時間，這些套件也能彼此無接縫一同運作，儘管其來源各自不同。

事實上，某些同時提供了內容管理系統的 PHP 開源框架供應商，像是 Joomla 與 Drupal，已經著手或計劃要採納其他 PHP 框架的程式碼。這麼做有助他們為用戶建構更棒的全面化產品。

開源網路應用程式框架的大規模互通性，會將我們引領至一系列成功整合案例。例如，Joomla 最近成為了第一家 PHP 語言框架供應者，提供程式碼讓用戶連接至網路代管方案 GitHub 的 API。

利用開源框架眾多優點之一，是開發者透過了解並學習其他程式設計者如何實現不同功能，以建構最終產品時，所獲得的知識與技能。同樣重要的是，觀察來自其他開源社群的支援，如何讓這類網路應用程式與服務成為可能。這裡沒有私藏品，沒有不能分享的獨家配方。

這就是在今日程式設計者之間促進創造力與創新的協同環境，越來越多開發者在運用各類最佳解決方案之時，也從封閉源碼方案與傳統開源內容管理系統的限制中解放出來。

這樣的進展值得訂購一籃慶祝水果籃，只要裡頭裝的都是成熟摘採的最棒水果。
___

##[源碼新聞] 美國國家安全局對美國人的電話與電郵進行未經許可的搜查##

謝良奇／翻譯

◎本文翻譯自 The Guardian，原作者為 Spencer Ackerman & James Ball︰[http://www.theguardian.com/world/2014/apr/01/nsa-surveillance-loophole-americans-data](http://www.theguardian.com/world/2014/apr/01/nsa-surveillance-loophole-americans-data)

美國情報首長已經證實，美國國家安全局 (National Security Agency) 利用監控法 (surveillance law) 的後門，對美國人民的通訊進行未經許可的搜查。

美國國家安全局的採集計劃表面上是針對外國人，但 8 月時衛報 (Guardian) 揭露了一項秘密的規則變動，可以讓國家安全局分析人員在資料庫中搜尋美國人民的詳細資料。

在寫給俄勒岡州民主黨參議員 Ron Wyden 的信件中，國家情報總監 James Clapper 證實了，此種利用法律授權逕行搜尋美國民眾相關資料的做法。在衛報取得的信件中，Clapper 寫到，有許多使用美國民眾辨識資訊，針對合法取得之通訊內容進行的查詢，目的是為了取得鎖定合理相信身處美國外之非美國人士的外國情資。

這些查詢的進行乃是遵照美國海外情報監聽法庭 (Foreign Intelligence Surveillance Court，FISA) 所通過的最簡化程序，並符合規約與第四修正案。Wyden 控訴執行這些搜尋的法定權力，有如後門搜索漏洞。

國家安全局許多最具爭議性的計劃，都是在受到此一所謂漏洞影響的法律底下，進行資訊的收集。其中包含允許該機構收集來自 Google、Apple、Facebook、Yahoo 等科技公司資料的棱鏡計劃 (Prism)，以及該機構構建網際網路纜線竊聽網的上游計劃 (Upstream)。

Clapper 並未提到國家安全局執行過多少次這類未經許可的搜查。這並非這類搜尋首次曝光：在 Snowden 揭秘之後，國家情報總監辦公室就曾對討論此一規則變動的文件進行解密。Clapper 的信件只是為此議題引來更多關注。

對於美國國家安全局在其電話與電郵資料庫，對美國民眾通訊內容進行搜查一事的證實，恐怕是破壞了美國歐巴馬總統於 6 月針對廣泛監控進行的初次辯護。歐巴馬當時宣稱，關於電話，沒有人會聽取你的電話內容，這並非這項計劃的目的。正如已顯示的，情報計劃所做的是得知電話號碼與通話時間，他們不會搜尋人們的姓名和內容。

歐巴馬特別提到針對美國電話記錄的大量收集，但他的回答誤導性地指出美國國家安全局不會檢查美國民眾的電話通話與電郵。

在最近隱私和民權監督委員會 (Privacy and Civil Liberties Oversight Board) 的一場聽證會中，行政律師 (administration lawyer) 試圖捍衛此類搜索的執行範疇。該委員會計劃將針對收集這類通訊的法定權力提出報告，也就是 2008 年通過的海外情報監聽法 (Foreign Intelligence Surveillance Act，Fisa) 第 702 條款。

Wyden 與科羅拉多州民主黨的 Mark Udall，在 2012 年未能說服同黨參議院情報委員會成員，在重新授權 2008 年 Fisa 修正法案時，防止此類的未經許可的搜查。

加州民主黨擔任委員會主席的 Dianne Feinstein，為此做法提出辯護，並且認為在運用國家安全局強大能力以收集美國民眾資料上，此舉未違反該法案的逆向鎖定 (reverse targeting) 禁令。

Feinstein 在 2012 年 6 月曾說過，關於對在 702 條款下合法收集的資料進行分析，情報單位提供了若干案例，其中可能有合法的外國情資需要，以執行搜索來分析已經掌握到的資料。司法部與情報單位重申，針對 702 條款資料的任何搜索，將嚴格地遵循適用的準則和程序，也不會在 Fisa 之下作為規避鎖定美國人民前，必須取得法院命令此一一般要求的手段。

Clapper 在給 Wyden 的信件中，提及此一爭論。Clapper 寫到，如你所知，當國會重新授權 702 條款時，曾提出要求限制此類搜索的提案，但最終並未被採納。

Fisa 修正法案 702 條款涵蓋了國家安全局多數的大量資料收集，只要合理相信通訊屬於外國與海外，即允許無需個別搜索票 (warrant) ，收集通訊內容與後設資料。

美國民眾與外國目標的直接通訊，也可逕行進行收集而無需搜索票。情報機構坦承，單純的國內通訊也會在不經意間收到其數據庫中，並稱此為附帶性收集。

一開始，國家安全局對此類資料的規則，禁止該資料庫用來進行有關美國公民或居民的任何搜索。然而，在 Snowden  所揭露的文件中顯示，2011 年 Fisa 法庭通過新的程序，允許該機構搜索美國人民的資料。

這項裁決顯然給予該機構在其廣大資料庫中，搜索有關美國民眾資訊的自由，儘管該資料庫一開始並非專為收集美國民眾資訊而設。然而，直至國家情報總監向 Wyden 披露之時，仍不清楚國家安全局是否曾行使過如此權力。

Wyden 與 Udall 指出，國家安全局對美國人民電郵與電話未經許可的搜索，值得所有人關注。兩位參議員在聯合聲明中表示，這是不能接受的。此舉涉及嚴重的憲法問題，對守法美國民眾的隱私權構成了實際的威脅。如果政府機構認為某特定美國人士涉及恐怖主義或間諜活動，第四修正案要求政府在監控其通訊前，取得搜索票或緊急授權。這應該是不爭的事實。

今天國家情報總監的坦承，進一步證明了，實質的監控改革必須包含關閉後門搜索漏洞，並且要求情報機構在有意搜尋 702 條款收集的資料，以找出特定美國民眾通訊之前，必須出示可能的原因。
___

##[源碼新聞] 自由軟體之父 Richard Stallman 5 月來台！##

洪華超／文

美國自由軟體的發起人，也是精神領袖－Richard Stallman 即將在 5 月來台演說，透過台灣社群的安排聯絡，Richard Stallman 的足跡將遍佈全台，將在台北、新竹、南投、高雄等地舉辦四場演講。

Richard Stallman 除發起自由軟體運動外，也創立了[自由軟體基金會 (Free Software Foundation)](http://www.fsf.org/)、 [GNU](http://www.gnu.org/gnu/thegnuproject.html) 計劃，同時也是著名編輯器 [Emacs](http://www.gnu.org/software/emacs/) 的作者。他對於自由軟體的貢獻非常的大，也獲得許多獎項，包含 MacArthur Fellows、EFF Pioneer Award、ACM Grace Hopper Award、Internet Hall of Fame 等等。


這次 Richard Stallman 演說的主題也切合台灣及全國時事，生活在現今數位網路普及的社會，有哪些值得關注的事情正在發生？從自由軟體、網路自由、著作權、社群、政治與道德，Richard Stallman 將無所不談，歡迎您一起來聆聽這場 "A Free Digital Society!"



- 台北場（已額滿，可候補。）︰[http://rms.kktix.cc/events/2014-taipei?fb_action_ids=10152364892660799&fb_action_types=og.likes](http://rms.kktix.cc/events/2014-taipei?fb_action_ids=10152364892660799&fb_action_types=og.likes)
- 新竹場︰[http://rms.kktix.cc/events/2014-hsinchu](http://rms.kktix.cc/events/2014-hsinchu)
- 南投場︰未公佈。
- 高雄場︰未公佈。
___

##[接案 / 工作] 自由軟體鑄造場誠徵軟體工程師／程式設計師 ##

黃崇閔／文

- 工作內容：
	1. Ruby On Rails 或 PHP 程式維護及開發
	2. Linux及FreeBSD系統管理維護
	3. 技術文件撰寫
	4. 辦公室資訊設備管理及維護
- 工作地點： 台北市南港區
- 工作時間： 日班 AM 9:00~PM 6:00
- 工作待遇： 月薪 33,348 元
- 需求人數： 2 人
- 到職日期： 2014/4/30
- 學歷限制： 大學以上
- 科系限制： 資訊科學學門
- 工作經驗： 不拘
- 附加條件： 
	- 必備條件
		- 至少會 PHP 或 Ruby On Rails 任一種網站程式開發。
		- 負責任、積極吸收新知的工作態度及正向思考的個性。
	- 加分條件
		- 對於自由軟體共工開發模式及專案管理具有基礎的了解。
		- 曾有自由軟體專案開發或是社群參與經驗。
		- 流暢的英文溝通能力並能現場口語詢答或是檢附相關英文檢定證照。
- 應徵方式
	1. 請檢附履歷、基本資料（學經歷、可安排之工作時間、聯絡方式等），寄予黃崇閔，email:[charles.huang@citi.sinica.edu.tw](Mailto:charles.huang@citi.sinica.edu.tw "Mailto:charles.huang@citi.sinica.edu.tw")
	2. 標題請註明：「自由軟體鑄造場誠徵軟體工程師／程式設計師－中文姓名」
	3. 檔案請用 ODT 或 PDF 格式寄送。 
- 履歷隨到即審，將於收到信後一週內擇優通知面試，不適任者恕不退件及函覆。
___

##[接案 / 工作] 自由軟體鑄造場徵 IT 系統管理員 ##

黃崇閔／文

- 工作內容：
	1. 虛擬化平台管理 (KVM、XEN)
	2. 光纖儲存設備管理維護
	3. 伺服器管理維護
	4. 緊急系統網路案件支援處理
	5. 辦公室資訊設備管理維護
	6. 資訊設備盤點
- 工作地點： 台北市南港區
- 工作時間： 日班 AM 9:00~PM 6:00
- 工作待遇： 月薪 39,064 元
- 需求人數： 1 人
- 到職日期： 2014/4/30
- 學歷限制： 大學以上
- 科系限制： 資訊科學學門
- 工作經驗： 2 年以上工作經驗
- 附加條件： 
	- 必備條件
		- 熟悉 Linux 系統。
		- 負責任、積極吸收新知的工作態度及正向思考的個性。
		- 熟悉開放原始碼的概念、常用軟體。
		- 能於晚間及週末進行設備維護，並於一般工作時間進行補休。
	- 加分條件
		- 對於自由軟體共工開發模式及專案管理具有基礎的了解。
		- 曾有自由軟體專案開發或是社群參與經驗。
		- 流暢的英文溝通能力並能現場口語詢答或是檢附相關英文檢定證照。
- 應徵方式
	1. 請檢附履歷、基本資料（學經歷、可安排之工作時間、聯絡方式等），寄予黃崇閔，email:[charles.huang@citi.sinica.edu.tw](Mailto:charles.huang@citi.sinica.edu.tw "Mailto:charles.huang@citi.sinica.edu.tw")
	2. 標題請註明：「應徵自由軟體鑄造場 IT 系統管理員－中文姓名」
	3. 檔案請用 ODT 或 PDF 格式寄送。 
- 履歷隨到即審，將於收到信後一週內擇優通知面試，不適任者恕不退件及函覆。
___

#關於本報#

◎ 主編︰洪華超

◎ 法律專欄編輯︰葛冬梅

◎ 執行編輯︰洪立穎、陳蕙蓁、劉佩昀

◎ 外稿編譯︰林誠夏、黃郁文、謝良奇

本電子報自行採訪、報導、編譯、撰寫文章之智慧財產權屬於中央研究院，採用創用CC「姓名標示－禁止改作－非商業性」授權條款臺灣 3.0 版授權散布，歡迎在不變更內容的前提下，以任何形式重製與散布本報，但必須遵守下列義務︰(1) 不得為商業目的之利用；(2) 必須標明本電子報智慧財產權屬於中央研究院；(3) 完整引用本著作權說明。

若欲以創用CC「姓名標示－禁止改作－非商業性」授權條款臺灣 3.0 版以外的方式利用上述文章，請與自由軟體鑄造場編輯群(ossfepaper at openfoundry.org) 聯絡。

非自由軟體鑄造場自行撰寫的單篇文章，其智慧財產權利屬於原作者所有，其以非專屬的方式授權予自由軟體鑄造場運用，而與本電子報其他文章併以創用 CC「姓名標示－禁止改作－非商業性」授權條款臺灣 3.0 版的方式進行散布。

若欲以創用CC「姓名標示－禁止改作－非商業性」授權條款臺灣 3.0 版以外的方式利用個別作者的文章，請自行與該作者聯繫，或透過自由軟體鑄造場編輯群 (ossfepaper at openfoundry.org) 來轉發聯絡訊息。

授權條款全文請見︰
[http://creativecommons.org/licenses/by-sa/3.0/tw/legalcode](http://creativecommons.org/licenses/by-sa/3.0/tw/legalcode)

授權條款簡介請見︰
[http://creativecommons.org/licenses/by-sa/3.0/tw/deed.zh_TW](http://creativecommons.org/licenses/by-sa/3.0/tw/deed.zh_TW)

若欲訂閱本電子報，請至以下網址︰
[http://www.openfoundry.org/tw/news](http://www.openfoundry.org/tw/news)

如欲取消訂閱這份電子報，可透過自由軟體鑄造場新聞首頁左上方之自動退訂機制︰
[http://www.openfoundry.org/tw/news](http://www.openfoundry.org/tw/news)

或寄發電子郵件至︰ossfepaper@openfoundry.org，以進行人工退訂。