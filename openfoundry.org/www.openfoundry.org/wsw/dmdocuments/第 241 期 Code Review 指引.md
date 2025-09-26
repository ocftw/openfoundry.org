___

□■□ 自由軟體鑄造場電子報第 241 期 | 2014/05/13 □■□
___

◎ 本期主題︰Code Review 指引

◎ 訂閱網址︰[http://www.openfoundry.org/tw/news/](http://www.openfoundry.org/tw/news/)

◎ 下次發報時間︰2014/05/27

#本期內容#

## [技術專欄] Code Review 指引 ##

Joey Chen (91)／文

### 為什麼需要 Code Review ###

要瞭解為什麼需要 code review 之前，先透過下面這張圖解釋，隨著軟體開發週期越後面的階段或經歷的時間越長，軟體修復 bug 的成本越高。

![圖1 軟體修復成本與時間關係](https://www.openfoundry.org/images/140513/01.jpg)  <br/><br/>
▲圖 1_軟體修復成本與時間關係（資料來源：[https://buildsecurityin.us-cert.gov/articles/best-practices/security-testing/risk-based-and-functional-security-testing](https://buildsecurityin.us-cert.gov/articles/best-practices/security-testing/risk-based-and-functional-security-testing)）


為什麼越晚修復，成本會越高呢？這跟技術債的情況相同，債會生利息，而這利息與循環利息和複利一樣可怕。開發越後期大樓越蓋越歪，疊床架屋與貪快累積的技術債將導致程式包袱越大，也越難維護。然而也因為只要是程式就一定會有 bug ，而越晚修復 bug 的成本越高，因此在各個開發團隊中，希望有效降低軟體維護成本最佳的方式，就是下列兩種：

1. 提早發現 bug 並進行修復，讓 X 軸的值小一點，自然 Y 軸所代表的成本就低一些。
2. 讓程式儘可能地好維護一些，以減緩成本上升的曲線斜率。一旦曲線平緩一些，Y 軸所代表的成本自然也會低一點。

而進行 code review 則是有效滿足上面兩個目的：**提早發現 bug 且修復，並讓程式好維護一些**。

### 什麼是 Code Review ###

程式一定有 bug 主要是因為開發人員很容易陷入自己的盲點，常見的盲點有兩種：

1. 程式是照你寫的跑，不是照你想的跑。
2. 程式照你想的跑，但你想的是錯的。

要突破上述的盲點，最簡單的方式就是找別人來 review 你開發中或開發完的程式，跟你一起確認程式是否寫的跟你想的一樣，以及確認你想的是對的。

註：當然，review 開發中或開發完的程式所發現 bug 的時間點，就是上圖的 Development 階段，如果希望能在 Design 與 Developer 階段中就發現問題，來讓 bug 根本不會發生，或是在第一時間點就被修復，這就是[極限編程 (eXtreme Programming)](http://zh.wikipedia.org/wiki/%E6%9E%81%E9%99%90%E7%BC%96%E7%A8%8B)中所提倡的[搭檔編程 (pair programming)](http://zh.wikipedia.org/zh-tw/%E7%BB%93%E5%AF%B9%E7%BC%96%E7%A8%8B)，這在實務上更是挑戰工程師的人性以及管理者的極限，但以 bug 修復成本的角度來看，這的確花費的成本最低。

簡單的說 code review 就是邀請其他人來幫你審查，原始碼上是否存在著不妥之處，例如風格是否與團隊一致、是否有哪邊程式可讀性不佳、有壞味道、不好維護、不好擴充、安全性疑慮、效能不佳、甚至壓根就誤解需求的問題存在。有的時候「三個臭皮匠勝過一個諸葛亮」，臭皮匠有臭皮匠的角度，諸葛亮有諸葛亮的盲點，一定要記住「程式碼是屬於整個團隊的」，不論自己寫的程式再高超、再有效率、再有彈性，如果沒有人可以維護，那就都只是空談。

### Code Review 會議的種類 ###

Code review 的方式見仁見智，個人覺得沒有絕對最佳解，只有慢慢 tuning 出最適合團隊的 review 方式，並建立起自己團隊的文化、價值觀與 Code review 的規範和流程。

但可以確定的是，當 code review 的頻率越低，則代表著需要 review 的範圍越大，可能重工的範圍與成本越高，而上線的時間壓力也越緊迫。團隊往往會因為上線時間壓力而導致空頭 review 或略過 review 的動作，大家都知道哪些地方設計不好，卻不進行修改。而 code review 的頻率過高，相對會帶來的 overhead 也會比較多。因此怎麼調整 code review 的頻率與 review 的重點就顯得格外重要。

這邊則針對幾種不同的團隊組成，提供幾種常見的方式供大家參考。

**一、團隊中有大量新進工程師，較少的資深工程師**   

這種時候通常新進工程師只有基本的教育訓練或是由他們自行參考舊的程式與文件，對團隊的開發標準 (coding standard)、開發規範 (code convention)、命名規則、系統架構、系統介接與領域知識不熟悉。他們需要由資深人員帶領，透過實際的例子來對他們進行教育訓練，只是訓練的方式是以 review 新進人員所撰寫的程式碼來進行。

這種情況下 code review 參與人員幾乎是整個開發團隊，好處是透過一次實務的例子，就能讓所有成員用最快的速度了解哪些錯誤不要犯，進而回去修改他們開發中的程式，避免犯同樣的錯誤。壞處則是與會人員一多，花費的時間成本就會相當高，一定要確保 review 會議有效率且有達到效果。

這類型的 code review 頻率建議上限一週一次。當新進工程師開始進入狀況，瞭解團隊文化與開發規範後，就可以減少這類型的 code review 會議，而往其他類型進行。

**二、團隊中資深與新進人員比例相當，或是彼此專長領域不相同**

這樣的團隊組成，建議可以進行 daily 的 pair review，由資深與新進的工程師進行配對，或是由熟悉不同領域知識的工程師配對，每天花 15~30 分鐘針對今天程式碼異動的部分 (Code Churn)，彼此同步一下。一般一個開發人員每天可以產出新的程式碼（不包含產生器自動產生的部分）行數約莫 200~400 行，因此建議要控制在半小時內 review 完畢，最好也可以把時段固定下來，如同 Scrum 的每日站立會議一樣，儘速且小範圍地針對原始碼提供回饋與建議。而這樣的範圍也是最容易找出 defect 的比例，如下圖所示：

![圖2 LOC 與 Defect 發現的關係圖](https://www.openfoundry.org/images/140513/02.jpg)  <br/><br/>
▲圖 2 LOC 與 Defect 發現的關係圖（資料來源：[http://smartbear.com/SmartBear/media/pdfs/11_Best_Practices_for_Peer_Code_Review.pdf](http://smartbear.com/SmartBear/media/pdfs/11_Best_Practices_for_Peer_Code_Review.pdf)）

這樣配對的好處是，參與的人員較少，可以輕量化地進行 review 與溝通。在 review 過程中，只要出現程式碼看不懂的情況，基本上可以歸類為：

1. 程式碼是對的，可能是新進人員的技術能力不夠或是不熟悉 domain 的伙伴對需求不夠瞭解。這時候可以針對技術或 domain 不懂的部分進行解說，趁這機會備份彼此的技術與領域知識，這是提升團隊能力與彼此備援的一個重要流程，比起單向的一對多專案分享或教育訓練，來得有效率地多。
2. 程式碼是有瑕疵的，可能是新進人員違反了開發規範、較難維護擴充或設計出效能較差的演算法，也可能是程式碼的易讀性不夠，讓其他工程師無法輕易瞭解需求與程式碼的設計目的。這時也是協助他們修正與學習的好時機，建立團隊的開發文化，就需要從平時開發的小細節著眼。

不論 review 後的程式碼如何，可以確保的是，這一份程式碼至少有兩個人以上瞭解其意義，也就是擁有共識。並且透過這個機會來提升或備援彼此的領域知識和技術能力，將 code review 的價值最大化。

### Code Review 前透過工具的 Preview ###
在進行 code review 之前，有一些開發規範應該要善用工具來作程式碼分析，以節省 review 過程中所需要花的時間。透過這些工具與定義的標準，可以客觀地審視與協助團隊成員在開發時不會像脫韁野馬、各自為政。下面列出幾個開發規範相關的工具（以 .NET 為例）：

1. **統一命名標準－詞彙表 (Glossary)**：可透過 GoogleDoc、Wiki、Excel 或其他知識管理平台來建立，屬於自己團隊領域知識的相關詞彙，以及開發上的命名習慣。命名，是軟體開發最基本，也是最重要的一件事。
2. **程式碼風格分析**：可透過 [StyleCop](http://stylecop.codeplex.com/) 來自訂屬於團隊的風格規則範本，讓開發團隊可以隨時檢查程式碼是否有違反風格規則。團隊中程式碼風格的一致性是易讀性與可維護性的基礎之一，風格沒有絕對的對錯，但當規範訂出來之後團隊就應該遵守，規範可以經過團隊同意後進行調整，但程式碼風格的檢查應交給工具來做，才會快速且客觀。如果 code review 還要花時間調整 style ，那就無法做到輕量化敏捷的 review ，時間一旦拉長，與會人員就容易失焦與失去耐心。
3. **程式碼相似度分析**：可透過 [Simian](http://www.harukizaemon.com/simian/) 或 [VS2012 Premium](http://msdn.microsoft.com/zh-tw/library/hh205279.aspx) 以上的版本來進行重複程式碼分析。重複的程式碼一直都是壞味道的基本來源，如何快速的掃描出專案中有哪些程式碼是重複的，可以幫助團隊快速地找到程式碼壞味道，檢查是否違反了單一職責原則（SRP）中的同一份職責散落在不同物件中。團隊也可以設定出自己的指標門檻，例如超過20行重複，才需要送出警告。
4. **程式碼複雜度分析**：可透過 [SourceMonitor](http://www.campwoodsw.com/sourcemonitor.html) 或 VS2010 Premium 以上的版本中的[計算程式碼度量功能](http://msdn.microsoft.com/zh-tw/library/bb385914.aspx)來分析循環複雜度。所謂的循環複雜度，簡單的說就是程式碼的分歧路徑，可以想像如果一個方法中程式碼可執行的路徑越多，代表人腦要理解程式碼意義的成本就越高，也代表程式碼可能越難維護。因此複雜度太高也是壞味道之一，直接透過工具分析出複雜度，可以讓開發人員在 code review 之前，就將這些可能不易懂的方法內容修正，以節省 review 的時間，也就是開發人員在開發時就透過工具來幫自己的程式碼做健康檢查，先行用工具 review 的意思。這邊建議分析的報告可以顯示前 15 個最複雜的方法來協助團隊瞭解，目前專案中最複雜的方法是哪一些。而團隊複雜度指標門檻建議可以限定複雜度在 15 以下，也就是複雜度超過 15 時，開發人員應說明原因，確認無法或不需要重構，方可通過審查。
5. **綜合品質分析**：可透過 [FxCop](http://msdn.microsoft.com/en-us/library/bb429476(v=vs.80).aspx) 或 Visual Studio 的[靜態程式碼分析](http://msdn.microsoft.com/zh-tw/library/ee1hzekz.aspx)來進行分析，團隊可依據團隊規範以及專案的性質，建立不同規則集。FxCop 與 Visual Studio 的靜態程式碼分析其實核心是一樣的，如果開發團隊針對基本的安全性分析找不到免費或可信任的工具，建議也可以直接使用 FxCop 中的安全性規則，在 [OWASP](https://www.owasp.org/index.php/FxCop) 上也有推薦使用 FxCop 來進行基本的分析。

上述的工具，除了在開發時期使用，也都可以部署在[持續整合](http://en.wikipedia.org/wiki/Continuous_integration)伺服器（如 [Jenkins](http://jenkins-ci.org/)、[TFS](http://msdn.microsoft.com/zh-tw/library/ff637362.aspx)）上每次建置時運作。不管是 daily build 或是 checkin build ，每次程式碼有異動時，團隊就可以在第一時間知道程式碼的品質趨勢是上升或下降。團隊應建立品質文化，當 build failed 或品質開始出現缺陷時，必須用最短的時間修正，否則在[破窗效應](http://zh.wikipedia.org/zh-tw/%E7%A0%B4%E7%AA%97%E6%95%88%E5%BA%94)下，技術債就可能累積越來越多，最後形成[焦油坑](http://zh.wikipedia.org/wiki/%E4%BA%BA%E6%9C%88%E7%A5%9E%E8%AF%9D)。

**相對大於絕對，趨勢大於數字**

在使用程式碼分析工具時，要避免成為數據的奴隸，這些指標報告就如同健康檢查報告，紅字不代表一定有問題，但一直紅字就代表需要關注。而許多團隊可能已經有既有的程式碼或系統 (legacy code)，這時建議大家應瞭解品質指標數據不是絕對的，但一定要守住相對的底限。

也就是不管原本的程式碼品質有多差，在每一次程式碼的異動後，經過每一位開發人員手中，程式碼品質只能更好，不能更糟。因此，這些指標的趨勢要比數字來得重要得多。只要每一次的異動，都能讓品質更上一層樓，哪怕只是一個風格警告的修正，都能幫助產品更好。只要維持住這樣的演進過程，就不用擔心被技術債壓垮，缺陷的趨勢是收斂的，團隊就能更有信心。

### Code Review 的注意事項 ###
如前面所說，方式沒有絕對的好壞或對錯，這邊列出一個基本的流程供讀者參考。

**Code review 之前的動作**

1. 確保程式碼已經通過靜態程式碼分析並符合指標規範，若存在違反規範的部分，應針對該指標進行說明。
2. 應先讓與會人員清楚這次要 review 的範圍、需求、流程，若有開發人員已經存在的疑問，也應提前告知與會人員。
3. 確保程式可以建置或正確執行。

**Code review 開始**

1. 先檢查工作清單上的 TODO 是否都被清除了，若沒有，應針對 TODO 進行說明。 
2. 透過 scenario 或測試案例來說明需求，針對異動的部分進行說明。
3. 商業邏輯的說明只需說明 context 的流程，透過程式碼的命名與抽象層級的設計，說明時其實就跟程式碼命名幾乎一模一樣。
4. 若有需要修改的部分，建議加上 TODO 相關註解，在 Visual Studio 透過[工作清單](http://msdn.microsoft.com/zh-tw/library/zce12xx2.aspx)視窗，就可以避免因紀錄或馬上修改導致 review 時間拉長。

**Code review 哪些東西**

1. 程式碼是否滿足業務與營運需求
2. 程式架構與系統設計是否滿足未來擴充性（確定可能會增加的需求）
3. 程式碼的易讀性、擴充性與抽象層級一致性
4. 程式碼效能問題
5. 程式碼安全問題
6. Error handling

### 結論 ###
Code review 很常因為資源、時程、習慣等問題，而被歸類到「我知道這很好，也知道應該要做，但我們無法落實在實務上」的情況。透過上述的簡要說明，整理出幾個重點：

1. 建立團隊文化與開發規範。
2. 透過工具來快速且客觀分析程式碼壞味道。
3. 頻繁且小範圍的進行 review。
4. Review 過程除了增進程式碼品質以外，更重要的效益在備援與教育訓練團隊成員間的領域知識與技術能力。
5. 提前準備不能省，讓會議效率最佳化。
6. 一定要有會議紀錄與待辦事項持續追蹤。
7. Review 的心態要正確，不應帶著挑戰或雞蛋裡挑骨頭的態度，目的應是彼此學習和讓產品更加進化。

希望這篇文章可以幫助讀者建立起最適合自己團隊的 code review 流程與規範，消除技術債的糾纏，讓軟體開發的過程能產出逐步進化的產品。


***作者簡介***

***Joey Chen (91)，一個熱愛軟體工程與敏捷開發的工程師，從 2010 年連任 Microsoft MVP 至今，也仍擔任 MSDN Forum 的版主，熱愛參與社群分享，除微軟技術相關研討會外，曾任 WebConf 2013, AgileCommunity.TW, tw.MVC, C.C.Agile 等研討會與社群講者。同時喜歡撰寫文章、授課與教育訓練，熟悉的語言為 C#，在實務上導入軟體工程的經驗豐富，如持續整合、自動測試、TDD/BDD、Scrum 等流程與技術。***

- ***專業技能：Web Development, TDD/BDD, Scrum, CI, C#, 電子商務。***
- ***學歷：長庚大學資管所。***
- ***Blog：[In 91](http://www.dotblogs.com.tw/hatelove/Default.aspx)***
- ***出版的書：翻譯「敏捷開發實踐」、翻譯「進入 IT 產業必讀的 200 個 .NET 面試決勝題」，著作「ASP.NET MVC 4 網站開發美學」。***
- ***工作經歷：Yahoo。***
___

## [技術專欄] PHP log 的勝利與挑戰 ##

謝良奇／翻譯

◎本文翻譯自 The NewYork Times，原作者為 Jonathan Marballi︰[http://open.blogs.nytimes.com/2014/03/25/the-triumphs-and-challenges-of-logging-in-php-and-really-most-languages-probably/](http://open.blogs.nytimes.com/2014/03/25/the-triumphs-and-challenges-of-logging-in-php-and-really-most-languages-probably/)


當你的網站出現問題，從 system logs 作為排除故障的起點，是不錯的選擇。伺服器出錯了嗎？檢查 log。網頁看起來不對勁或有亂碼？檢查 log。在重新設計紐約時報網站過程中，我們趁此機會為後端 PHP 框架，開發出輕量級、彈性好用的 log 類別。

我們決定利用開源程式庫，考量過一些選擇後，我們採納了 Symfony 的 Monolog logger。我們也考量過 KLogger 與 Analog 這兩套受歡迎的 log 程式庫，但是發現它們不符合我們的所有需求。KLogger 對輸出到檔案的 log 而言很棒，但缺乏將 log 輸出到其他管道的彈性。Analog 相當輕量而簡單，但是因為採用了靜態架構，難以在我們的單元測試中進行模似 (mock in)。Symfony 的 log 似乎是最輕量、最富彈性與延展性的。

為了建構我們的實作，我們從所需的 log-line 格式開始：

	%datetime% %serverName% %uniqueId% %debugLevelName% |[%codeInfo%] %message%

例如：

	2014/03/04+17:28:05T-0500 localhost 53165372b15fc DEBUG   |[Foo\Bar::helloWorld:3] Printing greeting to world  #output #salutation

以上大多數從欄位名稱到數值的對應是相當清楚的。%uniqueId% 是一個隨機字串，可以讓我們找出某單一伺服器端程式執行的所有 log 報表。%message% 則包含訊息與所有的 hashtags。多虧了 Monolog，藉由使用 Monolog 的格式器，可以很容易地運用這套格式。Monolog 格式器讓我們可以在鍵/值對被自動對應到 log-line 格式（像是出現在 log-line 格式 %codeInfo% 中的 $record[“codeInfo”]）前，操作記錄的所有欄位。例如：

	use \Monolog\Formatter\LineFormatter;
	class LoggerLineFormatter extends LineFormatter {
        public function format(array $record) {
            $record['debugLevelName'] = str_pad($record['debugLevelName'], 7 /* 最長層次長度 */, " ");

            $record["codeInfo"] = "";
            if (isset($record["extra"]["class"]) && isset($record["extra"]["function"]) && isset($record["extra"]["line"])) {
                $record["codeInfo"] = $record["extra"]["class"]."::".$record["extra"]["function"].":".$record["extra"]["line"];
            }

            //傳回 parent
            return parent::format($record);
        }
	}

一旦 LineFormatter 設定好，我們可以將其連接到 Monolog logger 上，好讓所有被抓取的 log 自動送進去：


	//logger 初始化
	$this->monologLogger = new Monolog\Logger('default');
	//取得行格式器
	$monologFormat = "%datetime% %serverName% %uniqueId% %customLevelName% |[%codeInfo%] %message%\n";
	$dateFormat = "Y/m/d+H:i:s\TO";
	$monologLineFormat = LoggerLineFormatter($monologFormat, $dateFormat);
	//建立 Stream 處理器（會讓 Monolog 寫到本地的 log 檔）
	$streamHandler = new Monolog\Handler\StreamHandler('/path/to/log', ERROR);
	$streamHandler->addFormatter($monologLineFormat);
	$this->monologLogger->pushHandler($streamHandler);

我們實作出將 log 寫到磁碟與用戶端 FireBug 插件的通道。接著我們設定環境，好讓開發伺服器抓取所有層級的 log（從 TRACE 到 ERROR）。在產品環境上，我們只抓取 ERROR。Monolog 提供設定 log 門檻的方法，簡化了這些設定。當我們決定加入 Sentry 通道時，只需要加入幾行程式：

	//建立 Raven 處理器（讓 Monolog 自動發送 log 訊息給 Sentry）
	$ravenHandler = new Monolog\Handler\RavenHandler(new Raven_Client('http://sentry-url'), DEBUG);
	$ravenHandler->addFormatter($monologLineFormat);
	$this->monologLogger->pushHandler($ravenHandler);

StreamHandler 與 RavenHandler 兩者都有 log 層級的參數。例如，以下的事件 log 會送到本地 log 檔案與 Sentry：

	$this->monologLogger->addRecord(ERROR, 'This is an error message #yikes');

而，因為除錯層級低於 StreamHandler 最低的 log 層級 ERROR，所以底下的 log 只會被記錄到 Sentry：

	$this->monologLogger->addRecord(DEBUG, 'This is a debug message #info');

我們採用兩種策略讓 log 易於分析。每個進來的要求在 log 中都有唯一的鍵值。因此我們可以輕易地追蹤出單一執行的所有事件。我們使用了 hashtags，以便輕易找出特定類型（例如 #apirequest、#missingdata）的問題。

Hashtags 是分類 log 項目一個快速且有效的方式。透過像是把所有 #apirequest 項目，都轉給負責 API 的團隊之類的做法，我們希望能好好利用這些類別。

我們對 Monolog 與我們的 hashing 解決方案很滿意。在我們的重新設計工作中，它們成為了邁向更棒 NYTimes.com 的有力助手。
___

## [自由專欄]七種幫助寫作的開源工具和開放資料 ##

洪華超╱編譯

Opensource.com 的一位專欄作家 [Jen Wike](http://opensource.com/users/jen-wike) 負責蒐集關於開放原始碼的小故事，她分享了撰寫這些文章的時候，常常會用到的工具。

###[Etherpad](http://etherpad.org/index.html)###
Etherpad 是一款即時的多人共同協作文件編輯器，因為即時的方便性，你的團隊成員馬上可以看到你對文章的修改、或是編輯上的建議，在文件上直接溝通，而不用再透過 email 或是即時通訊囉！Etherpad 有 Linux 和 Windows 的版本可供使用。

###[Drupal](http://drupaltaiwan.org/)###
Drupal 是開源的內容管理平台，只要透過簡單地安裝架設，就可以輕鬆建構和管理個人網站、社群或是大型的商業網站，很多知名的網站都是用 Drupal 這套工具來管理網站的內容。在台灣，Drupal Taiwan 社群每年都會舉辦一次 [Drupal Camp 大會](http://drupaltaiwan.org/forum/20140430/9676)喔！

###[Notepad++](http://notepad-plus-plus.org/zh/)
Notepad++ 是在 Windows 環境下可以使用的程式碼編輯工具，如果你的文章有需要寫到一些程式碼，用它來編輯文章，對於看清楚你的程式碼更有幫助喔！

###[LibreOffice Writer](https://zh-tw.libreoffice.org/) or [Apache OpenOffice Writer](https://www.openoffice.org/zh-tw/)###
這兩款都是能夠取代 Word 的文件編輯器，能夠畫表格、插圖片，轉存 PDF 或其他格式，功能非常的豐富。如果你也支持開放原始碼，那麽請把你的工具換成開源的 Office Writer 吧！

###[創用 CC 授權](http://creativecommons.tw/)###
創用 CC 提供了六種授權條款，讓創作者對於自己創作的圖像、文字或音樂產出，能夠透過創用 CC 授權而有一個讓自己的作品公開讓大眾合理使用、不侵犯智慧財產權的使用管道。Opensource.com、OpenFoundry 等支持開放原始碼的網站，其網站上的文章都是使用 CC 授權來釋出的。而創用 CC 在國外已經廣為人知，你可以透過[官網](http://search.creativecommons.org/)來搜尋需要的資源。

###[Public Domain Review](http://publicdomainreview.org/)###
[公眾領域 (Public Domain)](http://zh.wikipedia.org/wiki/%E5%85%AC%E6%9C%89%E9%A2%86%E5%9F%9F)，創作作品在創作者佛心放棄其著作權利，或其權利期間屆滿而不再受著作權保護時，這些創作品就進入了公眾領域，也就是任何人都可以隨時自由地使用和散佈這些作品了。古典樂可以一直被不同人權釋、老故事可以重寫成不同書籍、翻拍成不同電影，就是因為它們年代久遠，已經成為 Public Domain 了。你也可以透過 Public Domain Review 來看看有哪些可以自由免費使用的素材吧！

###[維基百科](http://zh.wikipedia.org/wiki/Wikipedia:%E9%A6%96%E9%A1%B5)###
維基百科是開放的內容及知識，透過公眾的力量，共同編輯而成的網路百科全書，一個人說一件事也許會記錯說錯，但十個、百個人一起來說同一件事，是不是更有可信度了呢？維基百科可以說是人類智慧的結晶也不為過呢！如果你的文章中有專有名詞，需要特別解釋、讓讀者知道更多資訊的地方，可以直接引用維基百科的說明，非常方便！

**參考資料**

1. [七種幫助寫作的開源工具和開放資料](http://opensource.com/life/14/5/seven-open-source-tools-writing)
___

##[自由專欄] 十大開源軟體，能讓你節省成本、與眾不同

四貓／編譯

科技網站 [LINUX IT](http://www.linuxit.com/) 表示，Linux 和開源軟體可以為您與您的組織節省寶貴的資源，今天我們要帶大家詳細地看看，到底是哪十種軟體能提高您組織的運作效率，讓您的組織看起來與眾不同。

1. [Nagios](www.nagios.org)
Nagios是一個頗為風行的遠端監控工具，能夠隨時監控系統的健康狀況，並在發生異常時提醒使用者或是依據預設好的指令進行處理，讓您的團隊能夠輕鬆保持系統的穩定運行。

2. [Python](https://www.python.org), [Perl](http://www.perl.org/)，[Ruby](http://www.ruby-lang.org/)
這是幾種非常強大而又風行的程式設計語言，被用於在世界各地的 DevOps 開發團隊。雖然他們之間有些不同，但設計模式都相當簡單明快，讓人發覺程式設計原來可以這樣的優雅與自由。

3. Authentication, Authorisation, Accounting （AAA 軟體）
一套完整的 Linux IT 工具可以保障您的資訊管理更輕鬆。認證 (Authentication) 機制能辨認使用者的身份，授權 (Authorization) 使用者登入網域使用相應資源，並提供計費 (Accounting) 機制，保存使用者的網絡使用記錄。此類軟體像是 [FreeRADIUS](http://freeradius.org/) 等，是 IT 人員必用的好幫手。

4. [OpenVPN](https://openvpn.net/)
OpenVPN，讓你的成員能通過網路加密連線內部網路。設定容易很方便，能保障網路通訊的安全性。是一個很棒的工具。

5. [Puppet](http://puppetlabs.com/)
超快速的好用自動化軟體，可以集中配置管理系統，是一個系統管理人員的好工具!
利用它IT人員可以對設備服務建立管理規則，Puppet會對系統進行檢查並實施。雖然功能看起來跟腳本很像，但是效率不可同日而語，因此2005年發布以來廣受IT人員的喜愛。

6. [Cobbler](http://www.cobblerd.org/)
Red Hat 發佈的網絡安裝套件，能批次部署 Linux 系統，輕鬆建構一個優良環境給您的團隊使用。
只要設定好腳本，Cobbler 讓安裝上百台的 Linux 可以像變魔法一樣輕輕點一下就完成。實在是IT人員的一大利器。

7. [Vagrant](http://www.vagrantup.com/)
Vagrant 使用於 Ruby 開發，背景用開源的 VirtualBox 作為虛擬化技術，可以輕鬆的跨平台部署。是個很受歡迎的虛擬機器軟體，具有優秀的跨平台兼容性。
不管在WINDOWS跟LINUX都可以良好的執行，運行不同系統並且輕鬆的進行環境調整。

8. [Red Hat](http://www.redhat.com), [Debian](http://www.debian.org/), [Centos](http://www.centos.org/), [SUSE](https://www.suse.com/)
這是已經在各大企業良好運行多年的開源 Linux 作業系統，具有優秀的穩定性，能為您的系統提供了一個良好的基礎。Red Hat 近年推出企業虛擬化平台產品也能為特定需求的使用者省下大量費用。

9. [Alienvault](http://www.alienvault.com/)
是一套專業的資安監控軟體，很棒的大型網路系統的入侵檢測工具。能偵測系統內所有資訊設備、軟體程式等資料，提供監控與稽核功能，為您的系統作完整的漏洞掃瞄與分析，假如想提升企業資訊安全，那它將是好用軟體工具。

10. Cloud infrastructure platforms ：
雲端資訊平台能為你的組織提供一種新的運算、儲存與應用服務的解決方案（例如，[Amazon Web Services](https://aws.amazon.com/)，[Google Cloud Platform](https://cloud.google.com/)）。只需投入少許的費用，就能在未來數個月，讓您擁有一個線上的作業空間，服務提供商會為您處理好備份、資料權限管理與資訊安全等問題、有如有專業的 Linux IT 和 OSS 支援一般。

###參考資料：###
1. [十大讓你節省成本開源軟體](http://www.linuxit.com/linux-blog/bid/324265/Top-Ten-OSS-Products-Cutting-out-Costs-and-Making-a-Difference-in-the-Public-Sector?utm_source=feedburner&utm_medium=feed&utm_campaign=Feed%3A+LinuxIT+%28LinuxIT+Blog%29)
___

## [自由專欄] 自由開源軟體與網路公民政治的參與 ##

四貓／文

![DemocracyOS官方網站截圖](https://www.openfoundry.org/images/140513/03.jpg)
▲ 圖1：DemocracyOS 官方網站，此專案強調透過網際網路與各種行動裝置，來發抒網路世代的真實民意：<http://democracyos.org/>

前陣子台灣吵得最沸沸揚揚的，莫過於服貿與太陽花運動的話題了。其中特別讓人注目的，便是太陽花運動中，年輕世代展現出來的高度技術能力。透過網路的串連，年輕世代從媒體的消費者變成媒體內容的生產者，從被動的接受訊息到主動的尋找內容、且在得到資訊時有能力反思、查證來源；網路的世界已經不只一日千里，而是用前人無法想像的光速傳遞訊息，竊以為，執政者要怎麼樣跟上人民的思考，而不是限制人民的思考，將會是未來掌握民意的關鍵。

其實像這樣的運用網路科技和軟體，已經不是第一次。從[茉莉花革命](http://zh.wikipedia.org/wiki/%E8%8C%89%E8%8E%89%E8%8A%B1%E9%9D%A9%E5%91%BD)、[阿拉伯之春](http://zh.wikipedia.org/wiki/%E9%98%BF%E6%8B%89%E4%BC%AF%E4%B9%8B%E6%98%A5)、[佔領華爾街](http://zh.wikipedia.org/wiki/%E4%BD%94%E9%A0%98%E8%8F%AF%E7%88%BE%E8%A1%97)到太陽花運動，網路和科技都扮演了極重要的角色。今天，我們就要帶大家來看看透過自由開放的軟體與網際網路，有什麼參與政治、發表聲音的方式。

阿根廷的政治學家 Pia Mancini 表示現在人民正面臨「代議制度的危機」，跳出來的抗議者中大部分來自民主國家，或者至少有名義上的民主，但還是有非常多的人對選出來的領導者不滿意。Mancini 並表示如果人們想要進入政治系統，則通常會伴隨著高昂的代價，但並不是每個公民都可以為政治獻身。Mancini 對候選人的不滿意源於她過去替政黨工作時的觀察經驗，她發現政黨常注重候選人的外表遠大於候選人的想法，更糟的是，選民的意見只有每兩或四年才會被重視一次。

因此，Mancini 創立了非營利組織「網路民主基金會」，想藉著網路的力量來改進公民參與的經驗。他們的第一個嘗試是使用開源軟體建立一個稱為 [DemocracyOS](http://democracyos.org/) 的網路平台，不但可以讓公民由下而上發起可供辯論的計劃，同時也由上而下呈現目前正在國會中辯論的法案，這樣雙向的呈現方式是由 DemocracyOS 的三個基本行動方針延伸出來的：讓公民獲得應有的資訊、讓公民都有機會參與議題的討論、並加入特定議題的投票。目前墨西哥的聯邦政府正使用這套開源系統收集選民對政策的意見，而突尼西亞的非政府組織 iWatch 則採用這套系統試圖讓人民可以有更多的發聲管道。

而網路影響公民政治參與的例子不止這些，在瑞典成立，以發起全球知識產權革命為目的的[「海盜黨」](http://zh.wikipedia.org/wiki/%E6%B5%B7%E7%9B%9C%E9%BB%A8)理念受到許多人的認同，在 2009 年的時候成為瑞典的第三大黨，而世界各地擁有相同理念的人也紛紛效法建立政黨，在 2012 年的時候，台灣亦有學者想要申請成立海盜黨，雖然內政部以會誤導民眾為海盜成員組織而拒絕；但在德國，海盜黨的成長速度卻令人驚豔，成立七年不到卻拿下了眾多地區議會席次，究竟是什麼原因讓海盜黨獲得這麼多人的支持？

在一篇天下雜誌的獨立評論中提到，德國海盜黨的主席施洛默爾 (Bernd Schlömer) 認為政策的透明度與年輕人關心政治的程度成正比，因此海盜黨致力於讓他們的資料雲端化，每一個黨員透過網路都能查閱。另外他們的會議也透過影音聊天室對所有人開放，雖然台灣也時興會議直播，但海盜黨的聊天室除了聽黨代表發言之外，所有參加者皆可參與發言，並不限於黨員。不僅如此，他們還提出了一項創新的運作方式名為「流動式民主」(Liquid Democracy)，核心概念是利用開放源碼的軟體建立一套系統，平台上每個成員都能針對議題開啟對話串展開為期三個月的公開討論，如果在期限內達到門檻便會進入政策的修訂階段，此時成員可以提出該政策的不同版本，最後結果將透過投票決定。此系統特別之處在於它既可以實現參與式民主，同時也擁有允許成員委託他人代為投票的代議制度。

現在台灣雖然還沒有類似的政黨，但已經有熱心的資訊人開發公民參與社會的資訊平台與工具。其中最廣為人知的非 g0v 莫屬。他們在網站上解釋了他們的名字：「將 gov 以『零』替代成為 g0v，從零重新思考政府的角色，也是代表數位原生世代從 0 與 1 世界的視野。」並秉持著開放原始碼的精神，除了協作工具都是以自由／開源軟體為主，他們也關心言論自由、資訊的透明化。讓公民更確實了解政府運作與各種議題，進而達到有效監督政府、全民皆公民的目標。

###參考資料：###

1. [讓公民的發聲的開源平台網站](http://www.wired.com/2014/05/democracy-os/)
2. [劉致昕：德國的「遙控民主」實驗──海盜黨總部現場觀察](http://opinion.cw.com.tw/blog/profile/187/article/639)
3. [德國海盜黨的流動式民主是如何進行的？](http://techpresident.com/news/wegov/22154/how-german-pirate-partys-liquid-democracy-works)
4. [g0v零時政府](http://g0v.tw/zh-TW/index.html)
___

## [源碼新聞] MySQL 變形版–迎合巨量資料庫所需的 WebScaleSQL 問世 ##

黃郁文／編譯

Facebook、Google、LinkedIn，與 Twitter，日前宣布 以自由開源授權版本的 MySQL 為基礎，攜手合作為處理巨量資料庫的網路公司，量身打造進化版本，名稱就叫作 [WebScaleSQL](http://webscalesql.org/)。Facebook 工程師 Steaphan Greene 也在 [Engineering Blog]( https://code.facebook.com/posts/1474977139392436/webscalesql-a-collaboration-to-build-upon-the-mysql-upstream )上發布相關訊息，表示打造 WebScaleSQL 變形專案的首要目的，就是要改造 Oracle 承繼昇陽成果的 MySQL，以切合巨量資料所需。

![WebScaleSQL 官方網站截圖](https://www.openfoundry.org/images/140513/webscalesql-we_are_gonna_need_a_bigger_database-20140513.png)  
▲ 圖1：WebScaleSQL 官方網站截圖，該專案的程式碼[以 GPL-2.0 授權託管於 GitHub](https://github.com/webscalesql/webscalesql-5.6)，並於 Facebook 同步設立[社團分頁](https://www.facebook.com/groups/webscalesql/)。
 
Greene 表示為了要處理超過 12 億名 Facebook 使用者的資料，必須要有強大先進的基礎建設支撐，這其中就包含對 MySQL 配置的優化與改變。Greene 希望該項計畫，能夠打造一個針對巨量資料、且有助於企業善加利用原有 MySQL 5.6 版本優勢功能的知識分享整合系統。大要來說，WebScaleSQL 與 MariaDB 的設定角色不同，MariaDB 為 MySQL 資料庫專案的完全衍生與替代方案，但 WebScaleSQL 則並非 MySQL 完整功能的分支，而是為了切合大型網路資料儲放所需，所將 MySQL 加以修改、優化的分支 (Branch)。至於特別選擇 MySQL 5.6 版本的原因，WebScaleSQL 網站指出，是因為其功能完備性剛好切中所需，其更新版本 MySQL-5.7 的基礎架構也更動不大所致，不過日後仍會因應情況隨時檢討相關決策的方向。

Greene 表示，WebScaleSQL 會持續以自由開放源碼的模式釋出，以讓其他對此有興趣的開發者，能一同加入客製化 MySQL 的行列，而開放源碼的共工模式，也才能確保系統的品質與穩定度。由於大部份的程式碼將承繼與衍生自 MySQL 的開源版本，故 WebScaleSQL 專案的主要授權策略，仍延用 GPL-2.0 的 Copyleft 授權模式。而這幾家巨型公司要如何分工合作來打造 WebScaleSQL 呢？據說是 Facebook 負責開發 WebScaleSQL 的基礎框架，Google 則加以檢視與提供進一步的修改建議；LinkedIn 也是負責檢視工作，至於 Twitter 則會在效能改進上做出貢獻。

目前 WebScaleSQL 在改造 MySQL 上已經有重要成果出現，像是能夠執行與發布 MySQL 內建測試系統成果 (mtr) 的自動化框架；全新的壓力測試套件，與自動化效能測試系統原型 (A suite of stress tests and a prototype automated performance-testing system)；對現有程式碼結構的更改，以避免原本會出現的程式碼衝突問題，還有像是改善記憶體緩衝與重刷的反應時間、資料查詢功能的優化，及針對網路環境著手的效能改善，以及隨使用者層級不同所精化的權限控管，和使用端失聯怠速所配套的定時登出功能添加。目前該計畫正著手將 Facebook 之前針對網站效能改善，所進行測試所得的表格、使用者資訊，以及資料壓縮演算法等解決方案，轉移至 WebScaleSQL 專案來進行呈現，這些因應大型網路資料庫才會碰到的使用挑戰與經驗，將有助於 WebScaleSQL 在調校之後，更能在大量使用者瀏覽的狀態下一樣提供高效率的資訊服務，並更機動式的在系統被低度利用的時段，能自動地啟動資料的備份機制。

而雖然目前 MySQL 原作者 [Michael Widenius (Monty)](http://fi.linkedin.com/in/montywi) 所主力參與的 MariaDB 分支版本，在自由開源軟體社群間的聲勢似乎已慢慢凌駕 Oracle 作為權利繼受公司所推出的 MySQL，不過在這些社交網路巨頭公司的支援下，MySQL 進化版的 WebScaleSQL，仍將成為處理 petabytes 或 terabytes 等級的巨量資料企業，切切不可忽視的新發展！


參考網址：

1. WebScaleSQL：為 Facebook 般規模的網路資料庫打造的 MySQL
    - [http://www.zdnet.com/webscalesql-mysql-for-facebook-sized-databases-7000027814/](http://www.zdnet.com/webscalesql-mysql-for-facebook-sized-databases-7000027814/)
2. Facebook、Google、LinkedIn，與 Twitter 合作建置 WebScaleSQL 專案
    - [http://thenextweb.com/dd/2014/03/27/facebook-google-linkedin-twitter-launch-webscalesql-custom-version-mysql-massive-databases/](http://thenextweb.com/dd/2014/03/27/facebook-google-linkedin-twitter-launch-webscalesql-custom-version-mysql-massive-databases/)
3. Facebook、Google 等跨國巨型公司利用 MySQL 5.6 版打造 WebScaleSQL
    - [http://www.theregister.co.uk/2014/03/27/webscalesql_launch/](http://www.theregister.co.uk/2014/03/27/webscalesql_launch/)
___

## [源碼新聞] 種子也開源？29種開源農作進入田野 ##

四貓／編譯

大家聽到開源的時候，第一個出現的念頭是什麼呢？相信許多人可能立刻就會聯想到開放原始碼。不過，現在有一種全新的開放概念誕生，那就是開源種子（Open Source Seed）！不知道有沒有人和我一樣，一看到種子的時候先想到的是 p2p 軟體所使用的 torrent 種子？不過這邊要講的並不是資訊科技裡的種子，而是貨真價實可以栽種在農地裡的種子。    
    
有不少農民和種子公司之間的糾紛便是源自於「種子專利」，取得專利的種子通常都是種子公司研發的基因改造品種，農民若購買了這種品種，僅可以將收成的作物拿去加工販售，例如將基改黃豆加工製成豆漿、豆花，但是不能留下黃豆種子販售，甚至留作下年度栽種的種子也不行，必須重新和種子公司購買。當然，種子公司投入大筆的金錢研究、研發新品種是值得被鼓勵的，但是若種子專利被不當利用，則有可能變成濫訴農民的工具。過去曾經有加拿大的案例是農民的田位在公路旁邊，雖然他並沒有購買或栽種基改作物，但過路往來的車輛有可能無意間掉落了別的農民栽種的基改作物種子，種子公司在農田採樣的時候發現該農民的田裡有抗除草劑的專利基因，因此判斷農民偷用他們的專利而一狀告上法院，最後最高法院判農民不須罰款，不過仍表示農民侵犯了種子公司的專利；類似的事件層出不窮，甚至造成農民破產的也大有所在。
  
以進步為名，過去數十年我們看到了專利種子在全世界控制大量的農田，種子公司介紹的基因改造種子成功地攻城掠「地」，擠壓到「較為常見、且可分享」種子的生長空間。因此科學家、農夫、還有永續作物的推動者從自由軟體的運作方式得到靈感，日前釋出了全球首批的「開源種子」。開源種子促進會（OSSI, Open Source Seed Initiative）聲明，推廣開源種子的目標是讓種子能自由的被任何人栽種、培育，並分享給全人類，確保植物不被專利或其他條約所限制。他們釋出的這批種子採用類似 GPL 的授權方式，換句話說，不管你是為了栽種農作或是為了育種而取得種子，你都可以自由的使用這些種子，唯一的限制是不能將成果變成專利產品。園藝教授兼植物培育家，同時也是開源種子宣言 （Open Source Seed Pledge）作者之一的 Irwin Goldman 說：「種子是人類從前人的農業文化繼承而來的，我們應該確保種子對所有人開放並能自由使用種子。」學者們也擔心種子專利發展下去，將沒有任何有價值的公共種子留存下來。

專利種子除了訴訟的問題外，更值得關注的是生態問題。當特定植物在農田裡成為絕對優勢的時候，很有可能造成自然種植的作物消滅，破壞了生態的多樣性。而生態的平衡一旦遭到破壞，往往環環相扣影響到其他生物，造成更大的影響。這樣的現象不只在科學界引起討論，亦被納入文化之中，不少科幻作品也有類似的關懷。在2012年的時候，日本富士電視台播映的動畫《心靈判官》（Psycho-Pass）以近未來的日本作為故事背景，其中就有提到未來糧食大量依賴基因改造的超級燕麥， 但由於品種的單一特性，剛好成為壞人企圖讓日本糧食供給系統崩潰的契機。我們在食用農產品的時候，也許趁機可以思考一下種子與開源之間的相互關係，並且去設想開源與世界的交互作用。
  
目前，開源種子促進會一共釋出了包括花椰菜、甘藍菜、芹菜、藜麥…等共29種類的蔬菜及穀物。威斯康辛大學麥迪遜分校的教授 Jack Kloppenburg 表示他們的目的是要提醒人們，透過種子專利的廣泛運用，生物多樣性正受到威脅，而分享開源種子讓培育者創造更好的種子，則是避免品種單一化的一種方式。


###參考資料：

1. [開源種子進入市場、喚起注意](http://www.voanews.com/content/open-source-seeds-hit-the-market/1898924.html)

2. [開源攜帶不受限的種子進入農田](http://arstechnica.com/business/2014/04/open-source-comes-to-farms-with-restriction-free-seeds/?utm_source=feedburner&utm_medium=feed&utm_campaign=Feed%3A+arstechnica%2Findex+%28Ars+Technica+-+All+content%29)

3. [終於，開源的花椰菜與甘藍菜來了！](http://www.resilience.org/stories/2014-04-24/finally-open-source-broccoli-and-kale)

4. [開源種子促進會官方網站](http://www.opensourceseedinitiative.org/) 
___

## [源碼新聞] 開放源碼促進會舉辦國際開源多媒體應用競賽 ##

四貓／翻譯

◎本文翻譯自 [開放源碼促進會新聞稿](http://opensource.org/node/708)。

開放源碼促進會 (Open Source Initiative，OSI) 興奮地宣佈國際開源多媒體應用競賽 (International Competition in Free and Open Source Software Multimedia，ICOM) 即將展開。這個影片競賽由馬來西亞塞納小學 (SK Sena)  、馬來西亞玻璃市大學 (UniMAP) 、馬來西亞玻璃市政府和馬來西亞教育部共同籌辦，將開放給來自世界各地的學生，從小學到就讀高等教育的學生都可以參加。

這次競賽的主要目標是：  

* 鼓勵參與者之間的創造性思維和團隊合作。
* 促進學會利用自由開源軟體 (FOSS) 。
* 為學生創造良性競爭的國際化平台。  

參賽者直到七月前，大約有三個月的時間去規劃、拍攝、編輯和上傳自己的作品，可以選擇有關都市開發，戲劇，新聞，紀錄片或公共事務，教育、通訊或地方事務等等的主題。所有參賽作品開放源碼促進會舉辦國際開源多媒體應用競賽將由來自馬來西亞的教育人員和媒體人員進行評比，而獲獎者將會獲得證書和獎項，還有機會得到超酷的 OSI  T-shirts！獲獎者的影片也將會公佈在 OSI 網站。

當然，這競賽最有趣的一點是，每個影片的所有前置作業，影片製作及後製工具將只會使用開源軟體。這是一個非常棒的模式，可以促進開源工具的認識和使用，同時建立教學和學習的創新方案─事實上，國際博物館協會已經開發出用於圖像和影片製作的[開源應用產品目錄](http://icom.sksena.edu.my/downloads-bot)，希望政府、教育單位或者是社群能夠多多利用這個資源。

OSI 很榮幸地被邀請成為競賽的贊助者，並希望來自世界各地的教育工作者能充分利用這點，不僅有機會讓學生參與一個跨國際、跨文化、跨領域的教育經驗，而且還能夠促進開源工具的使用，提升開源工具的價值。

如果你對這個競賽有興趣，你可以在 [ICOM: Free Software, Free Minds](http://icom.sksena.edu.my/) 網站了解更多，或直接連絡info@icom.sksena.edu.my 。
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