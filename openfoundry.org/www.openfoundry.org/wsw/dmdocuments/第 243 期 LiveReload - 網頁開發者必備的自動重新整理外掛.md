___
 
□■□ 自由軟體鑄造場電子報第 243 期 | 2014/06/10 □■□
___
 
◎ 本期主題︰LiveReload - 網頁開發者必備的自動重新整理外掛
 
◎ 訂閱網址︰[http://www.openfoundry.org/tw/news/](http://www.openfoundry.org/tw/news/)
 
◎ 下次發報時間︰2014/06/24
 
#本期內容#
 
## [技術專欄] LiveReload - 網頁開發者必備的自動重新整理外掛 ##
 
凍仁翔／文
 
網頁開發者 (Web Developer) 一天會在瀏覽器 (browser) 裡重新整理 (refresh) 個千百次是常有的事，但這樣不只會造成開發上的中斷，也會加重雙手的負擔。
 
這裡凍仁將介紹 LiveReload 給大家，**它是個可以在儲存檔案後自動重新整理 browser 的解決方案**，LiveReload 雖然不能即時呈現，但可以讓開發環境變得友善點，是值得投資的好工具，若能搭配雙螢幕使用其效果更佳。
 
(註：本文的撰寫環境是以 Ubuntu 12.04 為主，若版本不同可能會有些許的不同。)
 
###1. 建置 LiveReload server###
 
1.1. 安裝 Ruby 1.9.1 (若已安裝 Ruby 1.8 請移除)。
 
    [ jonny@precise ~ ]  
    $ sudo aptitude remove ruby1.8  
    [ jonny@precise ~ ]  
    $ sudo aptitude install build-essential ruby1.9.1 ruby 1.9.1-dev
 
1.2. 安裝 LiveReload 相關套件。
 
    [ jonny@precise ~ ]  
    $ sudo gem install bundle guard guard-livereload
 
1.3. 切換至專案目錄。
 
    [ jonny@precise ~ ]  
    $ cd project
 
1.4. 初始化並產生設定檔。
 
    [ jonny@precise project ]  
    $ guard init livereload
    12:33:40 - INFO - Guard here! It looks like your project has a Gemfile, yet you are running
    > [#] `guard` outside of Bundler. If this is your intent, feel free to ignore this
    > [#] message. Otherwise, consider using `bundle exec guard` to ensure your
    > [#] dependencies are loaded correctly.
    > [#] (You can run `guard` with --no-bundler-warning to get rid of this message.)
    12:33:40 - INFO - Writing new Guardfile to /home/jonny/project/Guardfile
    12:33:40 - INFO - livereload guard added to Guardfile, feel free to edit it  
 
1.5. 設定預追蹤的檔案 (此範例為追蹤 css/*.css, js/*.js 和所有副檔名為 css, js, html 之檔案)。
 
    [ jonny@precise project ]  
    $ vi Guardfile  
    # More info at https://github.com/guard/guard#readme
 
    guard 'livereload' do
              watch(%r{\.(css|js|html)})
              watch(%r{css/.+\.(css)})
              watch(%r{js/.+\.(js)})
    end  
 
1.6. 啟動 LiveReload 並監控該檔案列表。
 
    [ jonny@precise project ]  
    $ bundle exec guard  
    12:54:30 - INFO - Guard is using NotifySend to send notifications.  
    12:54:30 - INFO - Guard is using Tmux to send notifications.  
    12:54:30 - INFO - Guard is using TerminalTitle to send notifications.  
    12:54:30 - INFO - LiveReload is waiting for a browser to connect.  
    12:54:30 - INFO - Guard is now watching at '/home/jonny/project'  
    [1] guard(main)>
 
###2. 於瀏覽器安裝 LiveReload add-ons###
 
2.1. 下載並安裝 LiveReload add-ons，Firefox 的部份需使用 LiveReload 官方網頁的 add-ons 才可正常使用，[Mozilla](https://addons.mozilla.org/en-US/firefox/search/?q=livereload&appver=&platform=#) 上的可能無法正常運作)。
 
    [ jonny@precise ~ ]  
    $ firefox http://feedback.livereload.com/knowledgebase/articles/86242-how-do-i-install-and-use-the-browser-extensions-
    Safari extension 2.0.9
    Chrome extension on the Chrome Web Store
    Firefox extension 2.0.8
 
2.2. 於 Browser 按下 LiveReload 的圖示。
 
![](https://www.openfoundry.org/images/140610/LiveReload/2014-05-25-livereload-on-firefox.jpg)
![](https://www.openfoundry.org/images/140610/LiveReload/2014-05-25-livereload-on-chrome.jpg)
    
Firefox    Chrome
2.3. 回到執行 LiveReload server 的終端機 (Terminal)，成功運作時會出現 Browser connected 的訊息。
 
    [1] guard(main)> 12:55:29 - INFO - Browser connected.  
    12:55:29 - INFO - Browser connected.
 
最後要感謝創造出這等好物的前輩們，真的是造福人群啊！
 
 
資料來源：  
 
- [Using LiveReload on Linux \ Srikanth AD](http://www.srikanth.me/livereload-linux/)  
- [guard-livereload | GitHub](https://github.com/guard/guard-livereload)  
- [LiveReload 網頁程式設計師必備工具 | AppleBOY](http://blog.wu-boy.com/2011/10/how-to-install-livereload/)  
- [鳥毅的Blog: 在Linux使用Guard-LiveReload](http://blog.tenyi.com/2012/10/linuxguard-livereload.html)
___


##[自由專欄] 改善自動整合測試的用戶體驗##


謝良奇／翻譯


**本文翻譯自 The New York Times，原作者為 Silas Ray：[http://open.blogs.nytimes.com/2014/04/08/improving-the-user-experience-of-automated-integration-testing/](http://open.blogs.nytimes.com/2014/04/08/improving-the-user-experience-of-automated-integration-testing/)**




紐約時報的測試架構開發小組發展全新前端的匯報系統，用以呈現功能測試套件的結果。我們在持續開發之餘，更決定開源我們的專案。




###問題


測試工具就好像車子。一般而言，他們可以歸入兩種類別之一：一個是專注于開發者的類型，從引擎向外打造，強調動力與彈性；另一個則是專注于管理者的類型，從車體向內打造，重視易用性與展示方式。由引擎向外的方式能創造非常強大的工具，但通常得拿車體與操控作為代價。另一方面，由車體向內的方式，則傾向打造出非常優雅、簡易的操控，具回饋力的介面，但通常會有個蹩腳的引擎。


有效的測試自動化基本上拆分為兩大部分：告訴電腦如何像用戶 (引擎) 一般產生行為 ，以及，告訴管理者、開發者與開發團隊其他成員，測試做了什麼 (車體與操控)。我們認為，現在已經有許多很棒的方法，可以告訴電腦要做什麼，那就是程式語言。問題在於程式語言在向人們描述它們做了什麼時，一向是不太稱職的。我們決定從一顆好引擎 (Python 與 nose) 開始，在上面打造車體跟操控 (Pocket Change)。




###解決方案


在紐約時報，我們使用以 Python 打造的功能性自動框架。在該框架之上，我們用了 nose 單元測試框架作為測試探索與執行之用。我們的框架使用 Python 的日誌模組建構了許多的自動日誌功能 (服務要求與回應、網頁表單行為、資料庫查詢等)。這給了我們能吐出有用且格式一致資訊的測試，之後再輸出冗長且難看的文字區塊到 stdout/stderr。我們可以在透過 Hudson 執行測試時收集資料，不過卻沒辦法讓輸出更具可讀性，也沒辦法抓取元數據 (metadata)，像是測試所在的環境組態等，甚至沒辦法給出有用的歷史快照資料。


為此，我們打造了一個 nose 插件，能夠在執行時間將測試日誌與元數據分流至資料庫。我們還建構了一套網路應用程式，讓結果更容易瀏覽、過濾與閱讀。這麼一來我們不得不被綁定在匯報用 Python 撰寫的測試上，但這個限制還算能接受。我們在功能自動化上有單一框架，堅守這套框架意味著我們不用每次需要新功能程式庫或希望整合新的框架功能時，都要花時間在多種語言之間移植功能。


這套工具有四個部分。Sneeze 是一個 nose 插件，定義了匯報資料庫的核心綱要，並管理匯報介面的狀態以及與 nose 狀態的互動。Sneeze 自己有一個插件介面，揭露了資料庫模型並便於功能延伸。Pocket 是 Sneeze 的插件，負責佇列來自日誌的訊息，並推送至資料庫中。Pocket Change 是供 Sneeze 資料輸出的網路介面。最後的 Kaichu 是 Sneeze 插件，使用 JIRA REST API 與 JIRA 進行互動。


現在，這套系統看似 nose 測試結果的網路圖形介面，然而其建造之時已經著眼於未來的功能，我們計劃加以擴展的部分有：


* 更有趣的結果畫面與視覺化設計。
* 更強大的日誌過濾器。
* 輕鬆記錄圖像與其他媒體形態的功能。
* 整合 SCM 有關於建構與分支測試的資訊。
* 從使用者介面直接重新執行測試的功能。


如果你有興趣，請看一下我們的存儲庫。歡迎提供建議與貢獻。




連接、安裝與其他


GitHub 存儲庫的[到達頁面](http://developers.nytimes.com/opensource/sneeze)。


從 PyPI (由於 Sneeze 會安裝客制的 nose 版本，推薦使用 virtualenv) 安裝：


<pre>$ pip install pocket-change
# installs Pocket as well


$ pip install sneeze-pocket
# installs Sneeze as well


$ pip install kaichu
# installs Sneeze as well


$ pip install nose-sneeze
# installs fork of nose 1.3.0</pre>


文件：


* [Sneeze](http://sneeze.readthedocs.org/)
* [Pocket](http://pocket.readthedocs.org/)
* [Pocket Change](http://pocket-change.readthedocs.org/)
___


##[自由專欄] 改換 Linux 卻能免於資料丟失 - 在生產環境中管理系統轉換##


謝良奇／翻譯


**本文翻譯自 Linux IT，原作者為 Simon Mitchell：[http://www.linuxit.com/linux-blog/bid/345746/Migrating-to-Linux-Without-Losing-Your-Data-Managing-Migration-in-Production-Environments?utm_source=feedburner&utm_medium=feed&utm_campaign=Feed%3A+LinuxIT+%28LinuxIT+Blog%29](http://www.linuxit.com/linux-blog/bid/345746/Migrating-to-Linux-Without-Losing-Your-Data-Managing-Migration-in-Production-Environments?utm_source=feedburner&utm_medium=feed&utm_campaign=Feed%3A+LinuxIT+%28LinuxIT+Blog%29)**




沒有電腦系統可以恆久永存。升級只能撐得了一時：增添原來系統設計者想像不到的額外硬體、新的軟體和更大的資料庫，可以延長舊系統的使用期限，特別是對於優先考慮業務持續性的環境而言。


當這可敬且多次修補的老舊 UNIX 系統到了該汰換的時間點，由現代的 Linux 系統加以取代時，即使最富經驗的資訊長，都會因為資料丟失的可能性而感到暈眩。




###資料丟失


可能導致資料丟失的可能問題包括：


* 未能正確地從舊系統將資料複製到新系統，因此遭到某種程度的毀損，甚至完全丟失。
* 失去對資料的控制，因此雖然你成功複製了資料，卻也讓其他人得以存取。
* 未能定義轉換所需的資料。
* 在實際資料轉換前測試不足。


第一點可以癱瘓任何一家企業。如果資料重要性不高，第二點或許無關緊要，但如果你處在金融服務或是經營電子商務，未能保障用戶資料的法律後果會很嚴重。




資料轉移專案越複雜，誤差幅度就越大。這就是遵循最佳實踐之所以能夠減少資料丟失或毀損，並且最小化對組織可能衝擊的原因。




###尋求協助


設計新系統與轉移管理是專業工作。你由開發者與維護者組成的 IT 團隊，在維持現有系統運作的日常任務之外，並不適合這個工作。你需要尋求協助。


有大小型組織經驗的專責 Linux 與開源軟體 IT 顧問，能協助你選擇正確系統並管理轉換過程，讓損失降到最低。




###選擇工具


好的顧問公司與許多領先的開源軟體供應商應該有策略夥伴關係，才能夠取用轉換管理所需的最佳工具。


防範資料丟失的關鍵是備份。任何轉移過程的第一階段，應該是為你所有的資料建立雲端備份，不只是最明顯的資料庫，更包括你所有的軟體、授權與組態設定。


轉移管理的確複雜，但不要因為資料丟失的恐懼讓你止步不前。
___


##[自由專欄] 開放教育資源可以從 FOSS 學習的五個課程##
 
Circle／翻譯
 
**本文翻譯自 opensource.com ，原作者為
Scott Wilson：[http://opensource.com/education/14/4/5-lessons-open-education-resources-can-learn-foss](http://opensource.com/education/14/4/5-lessons-open-education-resources-can-learn-foss)**
 
開放教育資源（OER）社群欠缺一些成為開源和自由軟體運動的成因，而我認為以下這些自由開源軟體運動成功的因素是 OER 所缺少或需要強調的部分。
 
###1. 不只是分享，而是如何創造###
 
這些開源軟體運動的獨特元素其中之一，是[公開開發過程的專案 (open development projects)](http://oss-watch.ac.uk/resources/odm)。在公眾場合中，這些軟體是合作開發的專案（不合作也是必然的），通常人們是從多個組織裡將其貢獻出來。這一切的所有過程，導致軟體的創建和發行—設計、開發、測試、規劃—通常是使用公開可見的工具。專案也試著積極地使他們的貢獻基礎增加。
 
當一個專案有著公開和透明的管理，它更容易鼓勵人們自願提供無償且更多的力氣在專案上，而這將遠遠超過你在一個封閉的專案內所能買得起的。（當然，你必須因此放棄許多的控制權，但實際上，那些控制權又有什麼價值？）
 
雖然在開放教育資源空間裡有一些合作項目，例如一些開放式教材的專案，但在大多數的情況下，無論是資源的創建、個人獨立作業的發布，或是私下通過某大學的傳播媒體團隊所開發的，創建資源往往是比較私密的。
 
此外，在開源世界中，這種方式是很常見的：多家公司將資源投入在同一個軟體專案，以降低開發成本、提高軟體的質量和可持續性。我想不到任何教育組織在大規模設計上合作的有形例子—例如，合作建立一個完整的課程。
 
一般來說，這種 OER 的開源活動，最常見的是類似 "code dump"，組織堅持某個已經被放棄的專案的的開放授權。OER 需要從概念萌芽那一刻就開始公開過程並開始共工合作。
 
不可否認地，現今 OER 最熱門的形式有著這些傾向，像個人照片、PowerPoint 幻燈片和 podcast。這部分可能是因為創造開放教育資源的文化沒有被建立起來，而這將使它更容易產生大的片斷。
 
###2. 永遠提供「原始碼」###
 
許多 OERs 的分佈，是沒有任何分類的「原始碼」。在這方面，若不談授權的話，他們並不像開源軟體有那麼多可作為「免費軟體」發布的可執行程式，你無法輕易地修改。
 
將原有的資源作適當的分配，使其更容易的修改和利用。例如，其資源為 PDF、電子書或幻燈片之複合式檔案，在他們的原始分辨率、或原來可插入圖像作為編輯的表格，個別地提供其所有嵌入式的圖片。至於文件檔案，可從製作該文件的 DPT 軟體，提供原始佈局的文件（也請參考第 5 點）。
 
即使是一張圖片，公開原始的 raw 圖片其實和公開最後修完圖的版本是一樣的無害。同樣地，對於 podcast  或是影片，提供原始未壓縮失真的影片檔案，可讓人剪輯、重新編輯使用。
 
所以說，若是沒有「原始碼」，資源是難以修改和改善的。
 
###3. 有個管理生產流程的基礎架構，而不只是產出成果###
 
到目前為止，OER 的基礎架構大多是擺放成品的倉庫，而不是為了在開源裡合作創造成品的基礎建設 （維基百科是一個明顯的例外）。
 
我認為一個好的起始點，是促成 GitHub 成為用於管理 OER 生產過程的工具。我並不是唯一一個提出這點的；[Audrey Watters 也在部落格提到這個想法](http://www.hackeducation.com/2012/07/06/github-for-education-revisited/)。
 
它是個從起步時就可以用來創建開源專案的簡單方法，並且有一個內建機制可以用於創建衍生品和貢獻改進成果。從教育者的角度看來，也許它不是最好用的，但我認為它能夠讓 OERs 更清楚地建立開放資源的過程。
 
這亦有個倡議，做一個「GitHub 的教育版」，像是[CourseFork](http://coursefork.org/)，也許可彌補上述的不足之處。
 
###4. 有一些明確的準則來定義它是什麼或不是什麼###
 
目前已有許多（或許太多）關於 OER 的書面文章，但那些都不是一套標準的準則，必須考慮到 OER 並且符合它。
 
關於自由軟體，自由軟體基金會（FSF）所定義的四大自由：  
 
- 自由 1：能為任何用途自由地運行該程式。
- 自由 2：自由地學習軟體是如何運作，並可以修改它使其滿足你的需求。
- 自由 3：可以自由地重新發布或複製，以幫助你的夥伴。
- 自由 4：能自由地改善程式，並將你的成果（和修改版本）釋出給大眾，從而使整個社會獲利。
 
如果一個軟體無法支持上述這些自由，它就不能被稱為所謂的自由軟體。這像是有一大群的軍隊在你的生活裡，使你苦不堪言，而如果它不是，那麼請你試圖跨越它。
 
同樣地，「開源」是需要符合[由 OSI 公佈的完整開源定義](http://opensource.org/osd)的定義的。再說一次，如果你試圖將某個並不符合這些定義的專案冒充為開源，那麼將會有很多人樂意指出你的方式是錯誤的。並且很可能會起訴你，如果你違背任何授權方式的話。
 
如果開源不是根據 OSI 的定義，自由軟體也非根據 FSF 的定義，那麼它並不是「開放軟體」，討論結束。這之間沒有灰色地帶。
 
另外值得一提的是，雖然在功能層面上，自由軟體和開源之間有許多重疊的部分，然而如何將其標準從根本上表示出來，對他們各自的文化和觀點來說是很重要的。
 
現在也許被稱為「OER 運動」，底子裡和自由與開源軟體有著同樣獨特的觀點、文化，而且還開始出現了一些被廣義稱為「開放 OER」、「自由 OER」或「免費 OER」的差異討論。
 
然而，儘管 OER 有許多不確定的定義，也還沒有出現任何公認的定義和標準 — 對於那些分別支持這些差異的人，沒有重整的標竿。
 
現在看來似乎有點奇怪，因此未來有個建議是將其拆分成兩個派別，但自由軟體和開源陣營之間的緊張關係，我一直認為是純淨且正面的（當然，其他的陣營可能不這麼想）。透過一個又一個的社群調整自己，將使你更清楚自己的立場。你也許花更多的時間在批判另一個社群上，或者花更少的時間處理自己社群裡的內鬨！
 
直到有一些清楚的界線來區分什麼是其真正代表的定義之前，OER 將會繼續成為任何你想要它根據的一個定義，讓它難以有 [openwashing](http://readwrite.com/2011/02/03/how_to_spot_openwashing#awesm=~oGnTq8CP1CQ327) 的機會。（請參考[「漂綠 greenwashing」](http://zh.wikipedia.org/wiki/%E6%BC%82%E7%B6%A0)）
 
###5. 別讓 OERs 需要專有軟體###
 
好吧，大多數的教師和學生仍是使用微軟的 Office，且許多設計師亦是使用 Adobe。然而，其資源其實並不難開發，仍然可以透過使用免費或開源的軟體來編輯檔案。  
 
上述的關鍵是使用開放的標準來開發資源，並使用互通性 (interoperability) 廣工具。  
 
如果（或者更確切地）MOOC 為了讓使用者利用他們平台的功能而開始「擁抱和擴展」通用格式，這可能會變成很大的議題。同樣地，也有開放的標準（如 [IMS LTI](http://www.imsglobal.org/toolsinteroperability2.cfm) 和 [Experience API](www.adlnet.gov/tla/experience-api/)），能針對這一點幫上忙。這當然是 [CETIS](http://www.cetis.ac.uk/) 加入的點！
 
###是不是這樣呢？###
 
正如我在這篇文章提到的開頭，OER 某種程度上受到開源和免費軟體的啟發，它包含了許多重要的課程，例如在建立（和一定程度上簡化、改進）的自由以及開放授權模式的的概念。不管怎樣，OER 絕對不只是選擇授權那麼簡單的事情而已！
 
可能還有其他有益、值得學習的經驗學教訓—增加您自己的意見吧。
___


##[源碼新聞] Richard Stallman 來台演講紀實－談自由數位社會


四貓／文


在自由軟體的社群中，Richard Stallman 的大名應該是無人不知、無人不曉。美國自由軟體的發起人、同時也是自由軟體社群的精神領袖，人稱「自由軟體之父」(Father of Free Software) 的 Richard Stallman 在五月份的時候蒞臨台灣，在台灣各地展開巡迴演講。  
 
這次 Stallman 的演講主題著重在數位生活社會以及可能遇到的潛在威脅。他以風趣的語調談論嚴肅的講題，演講一開始他先從「拍照上傳 facebook」開始切入監控的主題，他說如果有人拍了他的照片，請不要把照片上傳到 facebook ，因為這會讓 facebook 有辦法追蹤被攝者，並傷害到他人的自由。同時，如果對演講有錄音、錄影的話，請使用開放格式分享，並採用 CC 授權。他強調這些，是因為他認為影響數位社會自由程度的原因取決於社會公民是否對自由有足夠的關注。舉例來說，記名悠遊卡能夠追蹤每個人的搭乘紀錄，但搜集資料並不是問題，關鍵在於「誰能夠取用這些資料」？如果公司把這些資訊交給政府，那政府就可以輕易的進行監控。假使我們真的遇到這樣的情況，那要怎麼樣對抗以國家機器力量進行的監控呢？


###數位社會與監控


在數位社會，有很多機會可以讓人民遭到監控，諸如服務替代軟體、在專有軟體裡面置入後門、或ISP紀錄我們的網路活動。Stallman 認為避免監控的唯一方法是政治行動。他表示，人民應該監督政府，不該讓某個人的權力大到足以掌握整個國家機器。民主的精神並不僅止於數年一度的投票，民主的真諦在於讓人民控制政府，而非政府控制人民。我們必須知道政府在做些什麼，才能有效監督政府，但政府也有可能透過祕密行動隱藏這些資訊，所以需要像是維基解密或是史諾登這些人來爆料，而我們必須要保障這些人的安全。照理說，保障安全的正常程序應該是用立法規範政府，使公權力不會被濫用，但這種作法緩不濟急，所以數位社會裡的公民必須要積極注重資安，才能保障自己的言論不會成為別人攻擊你的手段。Stallman 並強調每個人都喜歡聽和自己立場相同的言論，可是，我們同時也必須要捍衛反對立場說話的權利才行。


Stallman 也在演講中提到一個跟台灣人民可能會遇到的監控例子─車牌辨識系統。較好的車牌辨識運作方式應該是當遇到有問題、不合法的車牌才會進行檢查，其他的東西都不該被紀錄下來。一個合理監控系統應該是除非有法院命令，否則特定的車輛行蹤不能被掌握，要不然這個系統將有可能成為控制人民行蹤的工具。也許有人會疑惑，那街頭巷尾都有的保全監視器是否不應該設置呢？ Stallman 則認為，這兩者之間有一個最大的差別是有沒有連到網路上。保全監視器有定時、定點以及沒有特殊狀況則會定時刪除紀錄的特性，但監控攝影機則可以彙整、追蹤並分析資料。


###數位社會與審查


Stallman 也談到數位版權管理 (Digital rights management, DRM) ，他認為在資料上加入 DRM 就好比是替資料上了數位的手銬，藉著讓人無法散播為授權使用的資料，達到操控檢視與複製的權利。對提倡「著佐權」(copyleft) 的 Stallman來說，他當然不樂見這樣的情形，這不光單純是專利和著作權的問題。更進一步來說，他認為 DRM 有可能成為有心人士的工具，因為授權的制度必須要辨認客端的身份去檢查是否擁有使用權利，使用者的閱讀清單、購物習慣以及電子商務的消費紀錄都有可能被收集利用。然而，即使終端使用者付費取得了授權，在數位內容的使用上還是處於被動地位，例如過去曾經發生過電子書平台利用後門將書籍遠端刪除的事件，Stallman 認為這是一種「思想審查」，諷刺的是，被刪掉的書籍正好就是談論極權社會進行思想控制的經典作品─喬治‧歐威爾所著的《1984》。他認為，唯有原始碼透明開放自由軟體可以讓大家檢視裡面是否懷有惡意的程式，保障自己的資訊安全。


###數位社會與教育


另外，在我們關注數位生活中的危機時，也同時應該關心一下數位生活的未來，這裡想和大家談的便是「資訊教育」。有許多的學校在開設電腦課的時候，採用專有軟體的教導，也許是為了方便、也許是因為老師只會這套系統。但 Stallman 主張學校必須教導學生使用自由軟體，因為教育是形塑下一代的工具，如果我們教導學生使用非自由的軟體，那麼就會養出一批依賴專有軟體的學生，他指出：「就像是給你一口免費的毒品一樣」。使用專有軟體教學有什麼好處與壞處呢？好處有可能是，如果我們要過濾學生能得到的資訊，將會容易得多。但壞處是，如果有一個未來的工程師問老師：「這個軟體是怎麼運作的呢？」老師只能跟他說：「抱歉，我們不知道這個程式是怎麼寫的。」並錯失了一個培養工程師的機會，因為要養成一個好的程式開發者，代表他們必須去了解什麼是「好的程式」。這也是 Stallman 在自由軟體的四大自由之中所主張的自由之一：「研究、修改的自由」，而且知識的共享將有助於我們對世界的探索與了解，進而創造更多。


藉著這次自由軟體之父來台演講的盛事，再次提醒了我們，在享受數位生活的方便之際，其實也有許多議題是值得我們重視與關注的。特別是身為一個數位社會的公民，我們必須要有一個認知，了解到自由並非天生存在於大氣之中，也不該是「別人端過來給你」這麼方便、不需要付出代價的東西，自由其實是必須靠著大家共同的努力不斷去爭取而來的，不光是對軟體如此，對社會亦是。
___


##[源碼新聞] 最新雲端與開源講座##


謝良奇／翻譯


**本文翻譯自 Socialized Software，原作者為 Mark Hinkle：[http://socializedsoftware.com/2013/08/13/latest-cloud-and-open-source-talks/#utm_source=rss&utm_medium=rss&utm_campaign=latest-cloud-and-open-source-talks](http://socializedsoftware.com/2013/08/13/latest-cloud-and-open-source-talks/#utm_source=rss&utm_medium=rss&utm_campaign=latest-cloud-and-open-source-talks)**


上個月我有幸在 OSCON 發表若干演說。對於我的主題演講，建立包容社群 (Creating Communities of Inclusion) ，所收到的回應，我特別感到高興。該演說觸及了超出圍繞開源軟體的傳統授權與社群之外的許多議題。我也被邀請在 OpenSource.com 進一步深入這些議題。以下是演說與文章的摘要與連接。


[OSCON 主題演講：建立包容社群](http://www.oscon.com/oscon2013/public/schedule/detail/31470)


技術與人文對自由與開源軟體同等重要。除了程式碼標準、開發環境與自由軟體流通的基本層面之外，此一運動背後有著強大的驅動理念。這個演講是對於自由與開源軟體社群成功經驗的一個反思，並且呼籲將這些理念散佈至其他領域如醫學和政府。


[OSCON 演講：開源雲端運算的便車指南](http://www.oscon.com/oscon2013/public/schedule/detail/29394)


儘管銀河便車指南 (Hitchhiker’s Guide to the Galaxy) 這本書十分了得，其中並未介紹有關雲端運算的細節。不論你是要建構公開、私有或混合雲，許多的自由與開源工具都能有助你提供完整解決方案，或協助加強你現有的 Amazon 等代管雲端方案。這就是你為什麼需要開源雲端運算的便車指南，或者至少參加這場演講以了解開源雲端運算現況的原因。這場演講涵蓋架構即服務、平台即服務、巨量資料發展，以及有關如何有效部署與管理這些技術的開源方案。


這個指南將包含的特定議題：


* 架構即服務 - 系統雲 - 比較開放源碼雲端平台，包括 OpenStack、Apache CloudStack、Eucalyptus、OpenNebula。
* 平台即服務 - 開發者雲 - 了解為開發者將複雜度抽象化，並用來建構可移植之自動延展應用程式的工具，例如 CloudFoundry、OpenShift、Stackato。
* 資料即服務 - 分析雲 - 想知道有關巨量資料的一切？你會獲得有關開源 NoSQL 資料庫，以及 MapReduce 等用以協助資料採礦平行化與處理大規模資料集技術的概觀。
* 網路即服務 - 網路雲 - 真的可互換網路架構的最後一根支柱是網路虛擬化。我們將介紹軟體定義網路，包括 OpenStack Quantum、Nicira、open Vswitch 等。


最後這個演講將概略介紹這些能幫助你實際運用雲端的工具。你希望自動延展至數百萬個網頁，並在需求有所波動時縮減規模嗎？你對於自動化雲端運算環境的整個生命週期感到興趣嗎？你將學到如何將這些工具結合成工具鏈，以提供持續部署系統，協助你更加敏捷，並減少維護 IT 的時間，轉而將心力放在加以改進上。
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