___
 
□■□ 自由軟體鑄造場電子報第 245 期 | 2014/07/15 □■□
___
 
◎ 本期主題︰Xserver 的介紹與應用 
 
◎ 訂閱網址︰[http://www.openfoundry.org/tw/news/](http://www.openfoundry.org/tw/news/)
 
◎ 下次發報時間︰2014/07/29
 
#本期內容#


___


## [源碼秘技] Xserver 的介紹與應用 ##


陸聲忠╱文


**作者簡介：陸聲忠，國立成功大學土木工程研究所，現任職於國家高速網路與計算中心。**


###Linux 的特性與優點：


相較於「某知名廠商」的作業系統，Linux 具有以下的特性與優點：


1.系統比較穩定：Linux 是以 Unix 系統為根本所發展出來的作業系統，因此與其不但有相似的程式介面跟操作方式，同時也承襲其穩定與有效率的特點。有時一台 Linux 主機可連續運作一年以上都 不曾當機、也不需要關機，都是常有的事。


2.免費或僅需少許費用：由於 Linux 是基於 GPL 授權基礎下的產物，因
此任何人皆可以自由取得 Linux，至於一些「安裝套件」的發行者所發行的安裝光碟也僅需要些許費用即可獲得。不同於 Windows，使用者需要不斷的更新系統，並且還要繳納高額的費用。


3.安全性、漏洞的修補：在網路的世界中最常聽到的一句話應該就是「沒有絕對安全的主機」，不過由於 Linux 支援者日眾，有相當多的熱心團體、個人參與其中的開發，因此可以隨時獲得最新的安全資訊，並給予即時的更新，這意謂著其具有相對的安全性。


4.使用者與群組的規劃：在 Linux 主機上，檔案的屬性可以分為「可讀、可寫、可執行」等參數來定義一個檔案的使用權限 (permission)，此外，這些屬性還可針對為三種身份來設定，分別是「檔案擁有者」、「檔案所屬群組」、「其他非擁有者與群組者」。這對於專案計畫或者其他計畫開發者具有相當良好的系統保密性。


5.多工、多使用者：與 Windows 系統不同的是，Linux 主機可以允許多人同時上線來工作，如此系統資源在分配上不但較公平，也較能充被利用，不浪費。比起 Windows 的單人偽多工系統要實用多了！這個多人多工的特點可說是 Unix-Like 系統上一個相當強的功能，因為我們只要在一台 Linux 主機上面建立不同權限等級的使用者，而且每個使用者登入系統時的工作環境都也不盡相同，此外，還可以允許不同的使用者在同一個時間登入主機，並同時使用主機的資源。


6.較不浪費系統資源及且方便管理：由於可允許多人同時使用，因此系統的資源較能被充份利用，這與多台主機多作業系統相比，較不浪費系統資源，只要根據使用者數量及需求（如 cpu 數、記憶體大小、磁碟空間大小）就可以決定伺服器的規格，由於只有一台主機，一套作業系統，管理起來自然輕鬆多了。


###遠端連線伺服器




「遠端連線伺服器」如 同一般伺服器（如 mail or web）一樣，都是提供服務的，而兩者最大不同之處就是前者可允許一般使用者藉由遠端登入程式（如 ssh）直接進入主機來使用應用軟體，一般遠端登入程式，多以文字模式顥示，而大多數的應用軟體則需要用到圖形介面 (Graphical User Interface, GUI) 來操作，所以當你想要用桌機來使用「遠端連線伺服器」上的應用軟體時，除了要有遠端登入程式外還必須安裝 Xserver 軟體 ，這也就是本文之主題。


###X Window系统


X Window 系统（X Window System，也常稱為 X11 或 X）是一種以點陣圖方式顯示的軟體視窗系統。最初是 1984 年麻省理工學院的研究，之後變成 UNIX、類 UNIX、以及 OpenVMS 等作業系統所一致適用的標準化軟
體工具套件及顯示架構的運作協定。X Window 系统透過軟體工具及架構協定來建立作業系統所用的圖形化使用者介面，此後則逐漸擴展適用到各形各色的其他作業系統上。現在幾乎所有的作業系統都能支援與使用 X。更重要的是，今日知名的桌面環境——GNOME 和 KDE 也都是以 X Window 系统為基礎建構成的。


由於 X 只是工具套件及架構規範，本身並無實際參與運作的實體，所以必須有人依據此標準進行開發撰寫，如此才有真正可用、可執行的實體，始可稱為實現體。目前依據 X 的規範架構所開發撰寫成的實現體中，以 [X.Org](http://zh.wikipedia.org/w/index.php?title=X.Org&action=edit&redlink=1) 最為普遍且最受歡迎。X.Org 所用的協定版本，X11，是在 1987 年 9 月所發佈。而今最新的[參考實作](http://zh.wikipedia.org/w/index.php?title=%E5%8F%83%E8%80%83%E5%AF%A6%E4%BD%9C&action=edit&redlink=1)（參考性、示範性的實作體）版本則是 X11 Release 7.7（簡稱：X11R7.7），而此專案由 X.Org 基金會所領導，且是以 MIT 授權和相似的授權許可的自由軟體。


###X Window 運作架構


X Window 是採用主從式架構，將應用程式的運算處理與顯示功能劃分為兩個部份，也就是 X Client與 X Server。


X Server 是控制本機端輸出與輸入設備的程式，負責螢幕上圖形之顯示，並驅動滑鼠及鍵盤等輸入設備，讓使用者可以透過這些輸入輸出介面，達到與應用軟體式互動的目的。


在家裡或小辦公室環境中，通常 X server 跟 X client 都是在同一台電腦上執行的。 然而也可以在效能較差的桌機上執行 X server，而將應用軟體安裝在效能比較強、比較貴的遠端伺服器上並執行 X 程式 (client) 來做事情。 在這種場景下，X client 與 server 之間的溝通就需透過網路來進行。


這點可能會讓人產生困惑，因為 X 術語與一般人原本的認知剛好相反。他們多半以為 X server 是要在遠端伺服器上執行的，而 X client 則是在他們的桌機上執行的。實際上剛剛好相反。


簡單的說，X server 是在有接螢幕、鍵盤的機器上運作的，而 X client
則是運行在裝有應用軟體之遠端連線伺服器上的。


舉個例子來說，當我們在 X Window 的畫面中，將滑鼠向右移動時，X server 偵測到滑鼠的移動，便將滑鼠的這個動作告知 X Client，X Client 就會去運算，然後將這個結果告知 X server ，接下來，就會看到 X Server 將滑鼠指標向右移動了。


這樣做的好處就是，X Client（遠端伺服器）不需要知道 X Server（本機端）的硬體配備與作業系統。因為 X Client 單純就是在處理繪圖的資料而已，本身是不繪圖的。所以根本就不需要知道本機端 (X Server) 用的是什麼硬體和作業系統。 整個 X Window 運作架構如圖一所示。


![](https://www.openfoundry.org/images/140715/XServer/xconfigf.JPG)


▲圖一：X Window 運作架構。


###Windows 作業系統上的 X Server 軟體


由於 Windows 作業系統上並沒有提供預設的 X server，如有需要使用者必須自行下載安裝。目前 Windows 作業系統上常見的 X server 軟體有以下幾個：


- Hummingbird Exceed ：是一套商業軟體，就是要付費的，而且設定起來好像也蠻複雜的，在此就不多說了。


- X-win32：是一套由 starnet 公司所在 Windows 作業系統上開發的 X Server 軟體，因為也是一套付費程式，這裡也就不多說了，有興趣的人可下載試用版來玩玩。


- Xming ：基於 X.org X server 編譯，檔案並不大，也不包含別的東西，還帶了一個嚮導介面 (XLaunch)。雖然很小，不過該有的功能都有了。只是有個小小的問題，就是新版本的 Xming 並不是免费的，不過作者要求的並不是購買而是捐赠，如不捐贈就無法下載到新版本，免費下載的只有一個 2007 年的 6.90.31 版本。筆者因為工作的關係，常會利用 Xming 來使用很多各式各樣 Linux 版的應用軟體，截至目前為止無法開啟的軟體不會超過 5 個 ，所以這個老版本基本上來說是夠用的。使用此軟體所需下載安裝的檔案有二個，如後所示︰Xming-6-9-0-31-setup.exe 或 Xming-mesa-6-9-0-31-setup.exe（擇一即可）、Xming-fonts-7-5-0-34-setup.exe，其中 Xming-mesa-6-9-0-31-setup.exe 支援 openGL，由於它只提供了 X server，並沒有提供遠端登入程式（如 ssh），因此還要安裝一個終端機模擬軟體（如 putty）並且使用時還必須勾選 X11 forwarding 檢核方框（check box），這些對新手來說可能有點難度。以上是一位 MobaXterm
愛好者的說法，筆者並不認同，理由將在 putty + Xming 設定與使用一節中說明。


- VcXsrv：如果你需要最新版的 X.org X server, 可以試試 VcXsrv，它的用使用方式法和長相和 Xming 幾乎是一樣的，同樣带有 VcXsrv 的嚮導 (XLaunch），不過只需要下載安裝vcxsrv.1.10.1.0.installer.exe 程式即可。


- MobaXterm：又名 MobaXVT，是一款增強型終端、視窗，以最新的 X 服務器為基礎的 X.Org，可以輕鬆地來試用 Unix / Linux 上的 GNU
Unix 命令。增強型終端 MobaXterm\_v7.0.zip（可攜式版）裡面包含了bash 和眾多 posix 小工具（其實都是busybox）、openssh、X server，其實它是基於 Cygwin 打包而成的，啟動時會動解壓到臨時目錄，不過速度還是蠻快的。提供 gcc, perl, python, svn, git, emacs, vim 等 20 多個外掛程式，每個外掛程式也都是一個單一檔，攜帶、共用很方便（其實外掛程式是一個 zip 檔,對 Cygwin 比較瞭解的人很容易自己製作外掛程式），如果您之前就有使用 putty，當第一次啟動時便會匯入 putty 所有 session 及其設定。下載安裝的檔案為 MobaXterm\_Setup\_7.0.msi（安裝版），MobaXterm\_v7.0.zip（可攜版）。


### X Server 之比較


由於 MobaXterm、VcXsrv、Xming 這些軟體基本上都是部份免費的，所以我們直接拿一個應用軟體 (Sentaurus TCAD) 其中的 3 個模組(feature) 來進行測試，以了解不同模組利用不同的 X Server 軟體來開啟之結果，其中這 3 個模組分別是 Workbench (swb), Structure
Editor (sde), Visual(svisual)。整個測試環境如圖二所示，其中，遠端連線伺服器為網中心的 ALPS 超級電腦，其作業系統為 SuSELinux Enterprise 11 SP1，應用軟體為 TCADvG2012.06，筆者電腦的作業系統則為 Windows XP。


![](https://www.openfoundry.org/images/140715/XServer/test_env.JPG)


▲圖二︰X Server 比較測試環境示意圖。


使用 MobaXterm、VcXsrv、Xming 均可正常開啟 Workbench(swb)。MobaXterm 則無法開啟 Visual (svisual)，並出現以下訊息：


        Enforcing MESA version because GLX is missing.
        /pkg/em/sentaurus/G\_2012.06/tcad/current/suse64/lib/svisual\_exec:
        error while loading shared libraries: libImath.so.6: cannot open shared
        object file: No such file or directory


VcXsrv 則無法開啟 Structure Editor (sde)，並出現如圖三之錯誤訊息畫面︰


![](https://www.openfoundry.org/images/140715/XServer/vcxsrv.jpg)


▲圖三︰VcXsrv 開啟 sde 時出現之錯誤訊息畫面。


MobaXterm、VcXsrv、Xming 均可開啟 Structure Editor (sde)，不過使用 Xming 卻會出現 lag 現象，這個問題只要撰擇安裝 Xming-mesa-6-9-0-31-setup.exe 即可改善。


VcXsrv、Xming 均可開啟 Visual (svisual)，不過使用 Xming 可能會出現無法顥示文字的問題，如圖四。


![](https://www.openfoundry.org/images/140715/XServer/svisual.JPG)


▲圖四︰Xming 開啟 svisual 畫面。


只要在安裝字型時注意一下，在選擇 components 時選擇自訂安裝，並勾選所有字型，即可解決，如圖五。


![](https://www.openfoundry.org/images/140715/XServer/font.JPG)


▲圖五︰安裝字型時選擇自訂安裝畫面。


###putty + Xming 設定與使用


從 X Server 之比較一節中，可以發現使用 Xming 碰
到的問題比較少，所以特別針對 Xming 的設定與使用加以說明，由於它並沒有提供端登入程式（如 ssh），所以還必須下載一個終端機模擬軟體（如putty），之所以選擇 putty，主要是它的「複製貼上」非常好用，只要用滑鼠左鍵選取欲複製之範圍，再按下滑鼠右鍵即可，有關 putty的設定可參閱[這裡](https://service.nchc.org.tw/mrc/faq/faq\_answer.php?faqidnum=258)，在此就不再贅述了。不過有一個設定是非常重要的就是一定要記的勾選 X11 forwarding 檢核方框 (check box) 如圖六。如果你要同時管理多台主機或使用多台主機進行計算，為避免登入前須進行繁複的設定。您可以先先建立一個 session 並完成所有設定，然後以此為範本，先載入(Load) 此 session，再修改 IP 及名稱、再儲存 (Save) 即可。


![](https://www.openfoundry.org/images/140715/XServer/x11.JPG)


▲圖六︰puttyX11 forwarding 設定。


Xming 並不需要做什麼特殊設定，最好是安裝 Xming-mesa-6-9-0-31-setup.exe 還有在安裝字型時，在「選擇 components」時選擇「自訂安裝」，並勾選所有字型，如圖五。使用起來也相當簡單，只要執行Xming，
這時在工作列就會出現一個大 X，然後再利用 putty 登入遠端連伺服器，輸入啟動應用軟體指令即可。圖七為對一台伺服器同時啟動兩個程式；同樣的也可以對多台伺服器同時啟動多個程式。


![](https://www.openfoundry.org/images/140715/XServer/xeyes_xclock.JPG)


▲圖七︰一台伺服器同時啟動兩個程式。


###Xming 設定檢測除錯


Putty 有一個設定是非常重要的那就是「勾選 X11 forwarding 檢核方框 (check box)」如圖六。如果忘了勾選，就會出現以下錯誤訊息，以 echo \$DISPLAY 檢查，若無任何輸出，表示本機端之 putty 未勾選 X11 forwarding 檢核方框。若有勾選，那就是「遠端連線伺服器」之sshd\_config 檔案中之 X11Forwarding 未設定為 yes。


        a00scl00@alps6:\~\> xeyes&


        [1] 38863


        a00scl00@alps6:\~\> Error: Can't open display:


        a00scl00@alps6:\~\> echo \$DISPLAY


        a00scl00@alps6:\~\>


若有勾選且 sshd\_config 也設定無誤，但仍出現以下錯誤訊息，則表示本機端未啟動 Xming。


        a00scl00@alps6:\~\> xeyes


        Error: Can't open display: localhost:23.0


如果 Xming 有啟動，卻出現類似以下訊息，還有一個可能就是遠端伺服器上使用者家目錄沒有足夠的空間，讓應用軟體能成功啟動。


        xterm Xt error: Can't open display: localhost:22.0


###結論


由於 Linux 主機的高穩定性，所以很多的應用軟體都會選擇在上面開發，透過，Xserver 及終端模擬器便可讓許多人同時利用桌機上線來工作，本文主要介紹了 3 個 Xserver。分別是︰MobaXterm、VcXsrv 及 Xming。並拿 (Sentaurus TCAD) 的 3 個模組 (feature) 來進行測試，觀察不同模組利用不同的 X Server軟體來開啟之結果，其實這不意謂熟劣熟優，讀者可根據您使用的應用程式，來選擇適合的 Xserver，另外又提供一些偵錯及修正的方法，希望對
各位在從事計算工作時能有所助益。
___


##[源碼秘技] 安裝「Copy」，替代 Ubuntu One 的雲端服務##
 
Circle／翻譯
 
**本文翻譯自 ./themukt，原作者為 Sayantan Das：[http://www.themukt.com/2014/06/15/install-copy-alternative-ubuntu-one/?utm_source=feedburner&utm_medium=email&utm_campaign=Feed%3A+themukt%2Ffeeds+%28The+Mukt+Feed%29](http://www.themukt.com/2014/06/15/install-copy-alternative-ubuntu-one/?utm_source=feedburner&utm_medium=email&utm_campaign=Feed%3A+themukt%2Ffeeds+%28The+Mukt+Feed%29)**
 
 
在六月初，Ubuntu One 的雲端同步服務關閉了。許多用戶都轉移至其他雲端同步服務系統，例如 Dropbox、Google 雲端硬碟等。如果你不滿意正規的雲端存儲、或只是單純的想要增加你現有的存儲容量，你可以試看看 Copy。Copy 不像 Ubuntu One，它是更安全的，因為它使用 AES256 加密。根據該網站說明：
 
> *為了提高安全性，你存放在 Barracuda 的企業級雲端存儲資料，都透過多層次的加密保護著，包括最高機密級別的 AES256 加密，且具有進階的功能，像是資安共享 (secure sharing)、來源確認 (source validation) 身份驗證 (identity verification) 等功能，你可以輕鬆地控管你的資料要被誰看到。*
 
當你第一次註冊時，你將獲得 15 GB 的可用空間，每推薦一個人使用 ，還可以再獲得 5 GB。
 
 
###註冊###
 
如果你是第一次使用這個雲端同步服務器，你將需要先[註冊](https://www.copy.com/home/?r=cBG0P7&signup=1)。
 
 
###安裝###
 
不像 Google 雲端硬碟和其他 Windows、Mac 的工具，Copy 對 Linux 很友善。Copy 提供一個本機的雲端存儲給 Linux UI 的同步資料夾使用。你可以透過加入 PPA 安裝代理的 Copy。
 
        sudo add-apt-repository ppa:paolorotolo/copy
    sudo apt-get update && sudo apt-get install copy
 
如果你不想安裝不信任的 PPA，可以在這裡下載打包好的 deb 檔案：[32 bit](https://launchpad.net/~paolorotolo/+archive/copy/+files/copy_1.44.0357-0ubuntu1_i386.deb) ／ [64 bit](https://launchpad.net/~paolorotolo/+archive/copy/+files/copy_1.44.0357-0ubuntu1_amd64.deb)。如果你使用的是除了 Ubuntu 以外的其他任何 Linux 發行版，你可以從 [copy.com 網站](https://www.copy.com/home/?r=cBG0P7&signup=1)下載 .tar.gz 檔案。
 
 
###Ubuntu Unity 的安裝指南##
 
Copy 的預設安裝指南在 Ubuntu 13.10／14.04 有點問題，很多部落格也陸續發表關於如何解決這個問題的文章。我將它總結如下：
 
- 從 PPA 或從 .deb 檔，安裝 Copy  
 
            cd /tmp  
            wget https://github.com/hotice/webupd8/raw/master/libdbusmenu-gtk-$(arch).tar.gz
            tar -xvf libdbusmenu-gtk* sudo
            cp /tmp/libdbusmenu-gtk*/* /opt/copy-client/
 
- 從 .tar.gz 檔，安裝 Copy
 
    從 .tar.gz 檔安裝，需要在你的硬碟上找到安裝的資料夾。從[這裡](https://github.com/hotice/webupd8)下載 libdbusmenu-gtk.tar.gz 檔之後。記住要選擇符合你的電腦架構的檔案。完成之後，解壓縮檔案的內容到 Copy 的資料夾，有 CopyAgent 執行檔的資料夾。
 
 
###圖示###
 
在操作面板上，Copy 提供了自己的圖示。如果你使用的是 Numix 的圓圈主題，你將有 Numix 制訂的圖標。但是，如果你想要的是一個單色的圖示，你需要按照下面的步驟來安裝它們。
 
    cd /tmp wget https://github.com/hotice/webupd8/raw/master/copy-icons.tar.gz
    tar -xvf copy-icons.tar.gz
    sudo cp copy-icons/copyagent.svg /usr/share/icons/hicolor/scalable/apps/
    sudo cp copy-icons/copy.desktop /usr/share/applications/
 
- 深色面板  
 
            sudo cp copy-icons/copy_dark.svg /usr/share/icons/hicolor/scalable/apps/copy.svg  
 
- 淺色面板  
 
            sudo cp copy-icons/copy.svg /usr/share/icons/hicolor/scalable/apps/  
 
 
**請注意：**新的使用者註冊連結包含了推薦者的填寫。這將使用戶得到額外的存儲空間。如果你想得到額外的存儲空間，歡迎你在評論處發表你的推薦連結。
 
 
來源：[ubuntuforums](http://ubuntuforums.org/showthread.php?t=2217713&page=4&p=13043274#post13043274)
___


##[源碼專案] 讓簡報更為突出的三個開源工具##


謝良奇／翻譯


**本文翻譯自 opensource.com，原作者為 Joshua Holm：[http://opensource.com/life/14/7/3-open-source-tools-make-your-presentations-pop](http://opensource.com/life/14/7/3-open-source-tools-make-your-presentations-pop)**


不管你喜不喜歡，簡報的確在學術與商業生涯中占有相當大的比重。一般來說，簡報大多是以 Microsoft 的 PowerPoint 製作的，不過 Apple 的 Keynote 還有 LibreOffice/OpenOffice.org 的 Impress 也是強大的替代方案。這些應用軟體的問題 (撇開前兩者封閉源碼的特性不談) 就是，你必須安裝這些軟體後，才能瀏覽你製作好的簡報。你當然可以在 Google Drive 等選擇中打開檔案碰碰運氣，不過你不一定會成功。


最近這幾年，為了製作簡報而設計的網路框架開始流行，這些框架利用 HTML5、CSS3、JavaScript 製作的簡報，可在各種當今的網路瀏覽器中顯示。而且額外的好處是，簡報設計者握有對簡報的全權控制。他們不用擔心檔案相容性，或者被侷限在特定的網路服務中。因為這些簡報框架是開源的，能夠依你所需延伸並加強，不過呢，老實說寫 HTML、CSS 和 JavaScript 是比只用 PowerPoint、Keynote 或 Impress 要難上一點點。


impress.js 是最有趣的簡報框架之一，它讓簡報不僅僅是一大堆投影片而已。底下我會介紹 impress.js 還有兩個讓製作 impress.js 簡報更簡單的工具。




##Impress.js


impress.js 是 Bartek Szopka 開發出來的 JavaScript 簡報框架。受到 Prezi 的啟發，impress.js 使用了CSS3 變形效果 (CSS3 transformations)，達到傳統投影片無法呈現的簡報體驗。使用 impress.js 製作簡報可以讓講者用三度空間的滑動、旋轉、縮放，驚豔簡報聽眾。


以標準網路技術 (HTML、CSS、JavaScript) 為基礎，表示用戶不會因為 impress.js，而侷限在特定應用軟體或網路服務上製作簡報。由於採取 MIT 和 GPLv2+ 授權釋出，假如 impress.js 的功能不如你所想，你可以自行修改。然而，不像某些開源的 JavaScript 簡報框架，impress.js 需要非常先進的網路瀏覽器才能檢視簡報，它完全運用了最新的網路技術。對舊版瀏覽器的支援並非開發的優先事項。不過 Chrome、Firefox、Safari、Internet Explorer 最近的版本，應該都能和 impress.js 相處融洽。


甚至對 HTML、CSS 技巧不錯的人來說，製作一份 impress.js 簡報也非易事。基本的標記很好懂，不過 impress.js 簡報可以做得相當複雜，且需要許多思考和規劃。而且沒有預設主題，所以你必須為你的簡報，設計外觀和感覺。簡報的流程完全操之在你，所以你必須規劃好每一張投影片如何轉換到下一張，還有投影片在工作區中的相對位置佈局。從無到有製作 impress.js 簡報需要下足功夫，但是能夠獲得令人印象深刻的成果。精選的[展示與範例](http://github.com/bartaz/impress.js/wiki/Examples-and-demos) 可以提供靈感與指導，對想要深入了解學習的人還有[教學](https://github.com/bartaz/impress.js/wiki/impress.js-tutorials-and-other-learning-resources)。


假如從頭製作一份 impress.js 簡報，對你而言太過複雜的話，有許多工具可以幫助你。這裡列出的兩個工具各有優缺點。親自試試，然後看看哪個比較適合你。




##Hovercraft


Hovercraft 簡化了 impress.js 簡報的製作，允許你使用 [reStructedText](http://docutils.sourceforge.net/rst.html) 標記來製作簡報。製作簡報時，你可以專注在文字上，而不用撰寫 HTML 標記。不用複雜的標記，你就可以移動、更改元件。例如，底下的文字可以製作一張比前一張大 5 倍的投影片，並旋轉 90 度。


    ----


    :data-scale: 5
    :data-rotate: 90


    Heading
    =======
    * Bullet Point 1
    * Bullet Point 2


    ----


使用 Hovercraft 製作 impress.js 簡報大大簡化了流程並改進了 impress.js。Hovercraft 支援四種在簡報中放置投影片的不同方法。如果沒有特別指定的話，你產生的是一份傳統向左滑動的投影片放映。假如你想要更華麗一點，你可以用相對位置，而投影片就會根據你所制定相對於前面投影片的位移來出現。這個方式讓你在簡報中間輕鬆地添加新的投影片，然後讓後續投影片重新調整它們的位置。如果你想要完全控制它，你可以用絕對定位，允許你指定投影片的精確坐標。最後，你可以為投影片制定要遵循的 SVG 路徑。根據 Hovercraft 的文件，SVG 佈局雖然使用上有些繁瑣，但精確地控制佈局可以創造出令人印象深刻的投影片。此外，Hovercraft 支援針對簡報中各種原始程式碼的語法醒目標示，還有附帶計時器和注意事項的簡報者畫面。當你完成簡報製作時，有個非常簡單的指令，可以把 reStructuredText 檔案轉成 HTML 簡報：


    hovercraft [markupfile] [output directory]


儘管 Hovercraft 的功能強大，使用者仍然需要懂得 CSS。預設的 Hovercraft 主題相當的陽春，如果你想要的不只是白色背景和純文字內容，你還是得自行妝點你的簡報。為簡報加上 CSS 並不複雜，但也不像在 PowerPoint 中點選新簡報主題那樣簡單。


你可以閱讀 [Hovercraft 的文件](http://hovercraft.readthedocs.org/) 進行了解。


由 Lennart Regebro 所發展出來的 Hovercraft，採用[創用 CC (Creative Commons) CC0 1.0 Universal](https://creativecommons.org/publicdomain/zero/1.0/deed.en) 授權釋出。


##Strut


如果你要的是更像傳統簡報軟體般的工具，Strut 正是如此。Strut 是以網路為基礎的應用軟體，提供傳統的投影片瀏覽與編輯工具。圖形化工具讓你可以在投影片裡加入文字、圖片、影片、網站、預先設計的圖形。你還可以輕易針對整個簡報或個別投影片，更改投影片背景顏色和表面 (surface，指的是投影片後的帷幕)。Strut 還支援使用 [Markdown](http://daringfireball.net/projects/markdown/) 為投影片加入文字。對於進階用戶，你可以為物件套用客制化 CSS 類別，並撰寫 Strut 內部的客制化 CSS 規則。當你設計好投影片後，你可以切換到概覽 (Overview) 模式並圖形化設計投影片佈局。你只需拖放投影片，並輸入深度、旋轉、縮放的數值。除了建立 impress.js 簡報，Strut 也可以使用 [bespoke.js](https://github.com/markdalgleish/bespoke.js) 框架來產生簡報。


Strut 非常棒，不過還是有些美中不足。用戶偶爾會遇到一些臭蟲，專案的待辦事項列表也有點冗長 (儘管這不是太大的問題)。這個專案採取儘早釋出、經常釋出的原則，希望協助該專案的人，可以貢獻到 [GitHub](https://github.com/tantaman/Strut) 上。


要嘗試 Strut 可以使用該專案網站上的[編輯器](http://strut.io/editor/index.html)，或自行[下載](https://github.com/tantaman/Strut)執行。你需要 [Node.js](http://nodejs.org/) 的 npm 和 [Grunt](http://gruntjs.com/) 來安裝相依套件並建構 Strut。


Strut 的開發者 Matthew Crinklaw-Vogt，採用第三版 [GNU Affero General Public 授權](https://www.gnu.org/licenses/agpl-3.0.html)釋出該軟體。
___


##[源碼專案] KDE Connect 把你的 Android 手機變成個人電腦觸控板##


謝良奇／翻譯


**本文翻譯自 ./themukt，原作者為 Swapnil Bhartiya：[http://www.themukt.com/2014/06/29/kde-connect-turns-android-phone-touchpad-pc/?utm_source=feedburner&utm_medium=email&utm_campaign=Feed%3A+themukt%2Ffeeds+%28The+Mukt+Feed%29](http://www.themukt.com/2014/06/29/kde-connect-turns-android-phone-touchpad-pc/?utm_source=feedburner&utm_medium=email&utm_campaign=Feed%3A+themukt%2Ffeeds+%28The+Mukt+Feed%29)**


相當有趣的 KDE Connect 專案，經歷 Google 夏日程式碼大賽 (Google Summer of Code) 專案後，獲得可觀的改進，與 Android 也有更好的整合。不知道是誰先開始的，不過我們看到 Apple 與 Google 雙雙都實作了類似 KDE Connect 的功能，在他們的行動與桌面平台提供更好的整合。


KDE Connect 可以讓 Android 用戶將自己的設備，經由 wifi 連接到他們的 Plasma 桌面 (KDE Desktop 目前稱為 Plasma 桌面)。KDE Connect 讓 Plasma 用戶得以看到他們手機的電池狀態 (Google 的 Sundar Pichai 在 2014 Google I/O 為 Chromebook 發表了此功能)，在 Plasma 上收取手機通知，你還可以在設備間分享剪貼簿的內容。


這項專案剛剛發佈了另一項更新，為這套由社群推動的自由與開源工具帶來更多功能。由於是開源專案，因此不像是 Android (雖然是開源的，但不接受外部貢獻) 或完全封閉的 iOS，任何人都可以加入新的功能，這就是 Ahmed Ibrahim 所做的事。他加入的功能可以使用你的智慧型手機或平板，作為你 Plasma 桌面的輸入設備。這表示你可以用你的手機螢幕當作 Plasma 桌面的觸控板。雖然目前還不支援多點觸控與手勢，但此一更新未來發展令人期待。


KDE Connect 新增的另一項值得注意的功能，是透過 KDE Connet 向 Android 設備傳送檔案的能力。因此現在你不再需要 AirDroid 這類的應用軟體，或實際連接手機以傳送檔案到設備上。這項功能的作者是 Aleix Pol。


在我的希望清單上的一個功能，是能夠在我的 Plasma 桌面上看到我手機的內容，好讓我輕鬆地在我的個人電腦上製作備份。開發者們正在一個個完成他們列在待辦事項上的功能。在他們的待辦清單上，有許多令人興奮的功能，像是在桌面上回覆簡訊：也許和 Telepathy 整合；反向媒體控制：在 plasmoid 上加入遠端控制；同步：聯絡人、wifi 密碼等等；檔案瀏覽器：從桌面存取手機檔案系統的 FUSE 或 KIO slave，以及來電應答。


Albert 堅持等待你的散佈套件提供更新，他不鼓勵非進階用戶立即進行測試。所有的主要散佈套件在官方套件庫都有 kdeconnect，你可以輕易地加以安裝。
___


##[源碼專案] 專為開源汽車釋出的 Automotive Grade Linux##


謝良奇／翻譯


**本文翻譯自 The Var Guy，原作者為 Christopher Tozzi：[http://thevarguy.com/open-source-application-software-companies/070114/automotive-grade-linux-released-open-source-cars](http://thevarguy.com/open-source-application-software-companies/070114/automotive-grade-linux-released-open-source-cars)**


替物聯網時代中的汽車量身定做的 Linux 散佈套件，Automotive Grade Linux (AGL) 的首次釋出，宣告了開源作業系統 Linux 轉向一個相對較新的生態體系。


AGL 是由 Linux 基金會 (Linux Foundation) 贊助的協作專案，該基金會匯集了來自汽車產業、通訊、電腦硬體、學術與其他領域眾多合作夥伴。日前已經公開且可免費下載的這套開源作業系統，其首次釋出是以 Tizen IVI 作為基礎。基於 Linux 平台的 Tizen IVI，設計用來為各類型設備從智慧型手機、電視、車輛到筆電，提供作業系統方案。


在首次釋出中，AGL 為汽車等交通工具部署，量身打造出一系列功能與應用軟體，包括：


* 主屏幕 (Home Screen)
* 儀表板
* Google 地圖
* HVAC
* 媒體播放
* 新聞閱讀程式 (AppCarousel)
* 音頻控制
* 藍芽電話
* 智慧裝置連接整合


Linux 基金會和參與 AGL 專案的夥伴，希望該解決方案協助確保，未來的聯網車輛能使用開源軟體提供下一代娛樂、導航，以及其他車輛內使用的其他工具。Linux 基金會汽車部門總經理 Dan Cauchy 表示，開放性與協同合作是加速共同標準汽車平台的關鍵，可讓產業更快速地達成連網汽車的目標。


Cauchy 補充說，Linux 基金會預期 AGL 發展在第一次釋出後，會持續穩定地進行，而協同合作者希望能在後續版本中，加入許多額外功能和特點。
___


##[自由專欄] 自己的資安自己顧！保障隱私與資安的重要性##


四貓／文


###如果沒什麼要隱瞞的祕密，需要在意隱私嗎？ 


開放軟體促進會 (Open Source Initiative, OSI) 在一篇文章裡提出了一個很多人關心的問題：「如果我沒有什麼需要隱瞞的祕密，為什麼我需要在意隱私問題呢？」這個問題可能有千百種不同的回答，OSI 半開玩笑地表示他們最喜歡的短回答是：「真的？完全沒有祕密？」，不過如果要認真地回答這個問題，他們也有經過思考而且可以理解的答案希望可以跟大家分享：「想像有那麼一個世界，你的一舉一動都持續被周圍的人監看、批判，即使後果不是立刻造成，但也有可能在過了一段時間之後發酵，或者是你做了、說了什麼不那麼受歡迎或不太普通的事情。這種世界將會拖慢社會跟經濟的進步速度，因為大家都不敢做被認為是搗亂的事。」


OSI 還舉了幾個實例給大家參考，證明有多少當前人們認為是理所當然的自由，在以前其實是不存在的。如果人們連在家裡都沒辦法打破常規、累積動能，直到可以獲得合法的正當性為止，那麼同志權力、跨種族婚姻、藥用大麻這些都將不復存在。再想想 1920 年代的禁酒令，這個禁令最後因為人們的抵制而粉碎，如果要強制執行則會付出龐大的社會成本。但如果人們被全面監控、不能私下違抗禁令，那麼要擺脫這樣的禁令將會困難得多。全面監控可能會帶來什麼代價，OSI 在文中建議大家下次在大熱天自由地打開一罐冰涼啤酒暢飲時可以想想這件事。


###不做虧心事就不用怕被監聽？─全面監控的雙面刃 


劉靜怡教授在「[資訊、監控與自由](http://tahr.org.tw/transparency/blog/archives/5)」一文中提到：「在美國當前的監控社會（surveillance society）形貌下，政府在法律制度上幾乎可以『形式合法』且『範圍全面』地蒐集和人民一舉一動相關的各種資訊。」誠然，政府有可能利用收集到的資訊處理分析來提升行政效率、防範治安威脅、進行服務，但通訊監察與資料蒐集的權力若沒有經過法律的確實規範與制衡，則可能淪為威權統治的方便道具。自由軟體之父 Richard Stallman 曾經在演講中舉「車牌辨識」做例子，說明監控與利用的差別，如果系統辨識之後只紀錄下已違規的車輛沒有任何的問題，但若系統將所有通過的車牌都紀錄下來，則成為監控，結合網路之後，可以進行的追蹤與分析將十分強大。美國在九一一之後發展到現在已逐漸成為怪獸般的監控社會，但史諾登 (Edward Snowden) 透過媒體揭露了美國國家安全局 (National Security Agency) 的監控計畫後引發社會關注，也促使美國總統歐巴馬允諾提升監控計畫透明度與監督、制衡系統，以維護人民通訊的自由。 反觀台灣現在的法規，在保障通訊自由的把關仍有改進的空間。在去年 (2013) 的時候台灣司法與政治界曾因為監聽國會案而鬧得沸沸揚揚，當時有法界人士表示如果沒做虧心事，就不怕被監聽，但監察機關亦曾透過調查報告指出台灣通訊監察管理及查核系統有改進的空間，應該將監察範圍限縮在最小程度。


###Reset the Net### 
今年六月五號，距離史諾登揭密滿一週年，網路上一項名為 [Reset the Net](https://www.resetthenet.org/) 的號召便是企圖對抗全面監控的行動。電子前鋒基金會 (Eletronic Frontier Foundation) 表示他們已經對抗 NSA 的監控多年，但 2013 年是對抗全面監控戰爭的一個新章，因此包括自由軟體基金會 (Free Software Foundation, FSF) 等數十個組織加入 Reset the Net 行動，這項行動要求使用者在手機或電腦上安裝基於隱私保護設計的自由軟體，而開發者或網站設計者則應添加防止監控的設計， FSF 亦為了這樣活動撰寫了一份保護電子郵件資安的指南。


**參考資料**


- [如果沒什麼要隱瞞的祕密，還需要在意隱私嗎？](http://opensource.org/node/711) 
- [幫助Reset the Net，FSF 分享郵件保護指南](http://www.fsf.org/news/reset-the-net)
- [Reset the Net](https://www.resetthenet.org/)
- [資訊、監控與自由](http://tahr.org.tw/transparency/blog/archives/5)
- [電子前鋒基金會號召大家加入 Reset the Net](https://www.eff.org/deeplinks/2014/05/join-us-june-5th-reset-net)
___


##[源碼新聞] CoreOS 獲得 800 萬美元 A 輪融資，推出 Linux 管理服務##


謝良奇／翻譯


**本文翻譯自 Tech Crunch，原作者為 Frederic Lardinois：[http://techcrunch.com/2014/06/30/coreos-raises-8m-series-a-round-launches-managed-linux-as-a-service/](http://techcrunch.com/2014/06/30/coreos-raises-8m-series-a-round-launches-managed-linux-as-a-service/)**




為超大規模伺服器部署優化的 Linux 散佈套件 CoreOS，日前宣布已經獲得 800 萬美元的 A 輪融資。此次融資是由 KPCB (Kleiner Perkins Caufield & Byers) 領投，Sequoia Capital 與 Fuel Capital 跟進投資。去年 Andreessen Horowitz 與 Sequoia Capital 就已經對該公司做過前期投資。


該公司同時宣布推出第一個付費服務。就像類似的開源服務一樣，CoreOS 的散佈套件本身是以開源授權釋出，不過該公司計劃對於在該作業系統上運行的某些額外服務進行收費。此次推出的 CoreOS Managed Linux 正是踏出的第一步。


CoreOS 創辦人兼執行長 Alex Polvi 表示，這是我們的大日子。不僅是因為我們宣布獲得頂尖矽谷創投融資，更因為我們全力投入推出 Managed Linux。企業們今天開始可以把 CoreOS 當成他們作業系統團隊的延伸，對於企業 Linux 用戶來說，這會是他們所需要的最後一次轉換。


企業支付每月 100 美元讓 CoreOS 管理多達 10 台伺服器。他們享有自動修補、更新，加上有限支援。對於有更大規模部署需求的企業，該公司現在也提供加價方案，包括了電話、通訊軟體、電郵支援，以及使用該公司 CoreUpdate 服務進行防火牆後的滾動更新 (rolling updates) 管理。值得一提的是，一旦你超出最便宜方案的 10 台伺服器限制，費用會很快地攀升，支援 50 台 CoreOS 伺服器的基本方案要價每月 2100 美元，加價方案則為 6600 美元。


CoreOS 目前顯然氣勢正旺。例如，Google 最近開始在其 Compute Engine 平台上支援該系統，Rackspace 和 Amazon 也已經有該系統的映像檔。


支援運行分散式應用程式之用而日漸受到歡迎的 Docker 作為作業系統核心功能，對於該服務或許是有利的。和一般散佈套件不同，CoreOS 並不提供套件管理程式，你的各種軟體都必須在 Docker 容器之中運行。Docker 目前相當熱門，也因此運作在其生態體系中的公司獲得創投關注一事，或許並不特別令人訝異。


___


##[源碼新聞] Red Hat 為 OpenStack 夥伴新增雲端管理認證##


謝良奇／翻譯


**本文翻譯自 The Var Guy，原作者為 Christopher Tozzi：[http://thevarguy.com/cloud-computing-services-and-business-solutions/070114/red-hat-adds-cloud-management-certification-openstac](http://thevarguy.com/cloud-computing-services-and-business-solutions/070114/red-hat-adds-cloud-management-certification-openstac)**


為了讓企業採納其開源 OpenStack 雲端運算解決方案，Red Hat 正打算提供新的誘因。現在，該公司將為 Red Hat Enterprise Linux OpenStack Platform 認證雲端管理解決方案。


這項認證會是 Red Hat 的 OpenStack 雲端基礎架構夥伴網路 (OpenStack Cloud Infrastructure Partner Network) 的一部份。該公司稱此一夥伴網路為全球最大的 OpenStack 商業生態體系。透過這個計劃，針對整合通路夥伴的雲端管理產品到 RHEL OpenStack 中，Red Hat 將提供相關認證。


Red Hat 將此一舉措，定調為企業得以享有 OpenStack 多樣化市場方案，無需受限於單一廠商產品的一種方式。取而代之，企業能夠從廣泛的 OpenStack 認證管理工具中做選擇，並整合到 RHEL OpenStack 之中。


該公司也希望該項認證，加上整合後的 OpenStack 方案與其助長的夥伴合作關係，能夠為其在日益競爭的 OpenStack 市場帶來優勢。Red Hat 虛擬化與 OpenStack 總經理 Radhesh Balakrishnan 表示，由於 OpenStack 已成為許多用戶企業雲端策略的核心元件，擁有廣泛合作夥伴生態系統作為後盾的 Red Hat Enterprise Linux OpenStack Platform 會是首選平台。該生態體系的成長與成熟，反映出從基礎架構為中心以協助初期部署管理，到成為企業混合雲端實現一部份的產品演進。


BMC 與 Hewlett-Packard 已經著手與該公司合作推動新計劃的認證。該公司透露其 OpenStack 雲端基礎架構夥伴網路的合作夥伴名單相當廣泛，包括來自全球數百家獨立硬體廠商、OEMs、系統整合者與獨立軟體廠商。
___




#關於本報#
 
 
◎ 主編︰洪華超
 
◎ 法律專欄編輯︰葛冬梅
 
◎ 執行編輯︰洪立穎、劉佩昀
 
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