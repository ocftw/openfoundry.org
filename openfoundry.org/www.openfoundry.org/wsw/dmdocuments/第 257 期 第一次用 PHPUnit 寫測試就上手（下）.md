___
 
□■□ 自由軟體鑄造場電子報第 257 期 | 2015/1/13 □■□
___
 
◎ 本期主題︰第一次用 PHPUnit 寫測試就上手（下）
 
◎ 訂閱網址︰[http://www.openfoundry.org/tw/news/](http://www.openfoundry.org/tw/news/)
 
◎ 下次發報時間︰2015/1/27
 
#本期內容#
___


##[技術專欄] 第一次用 PHPUnit 寫測試就上手（下）##


黃儀銘／文


###上篇文章：[第一次用 PHPUnit 寫測試就上手（上）](http://www.openfoundry.org/tw/tech-column/9326-phpunit-testing)###


### 3. Data Providers (資料提供者)
資料提供者，能提供多筆的測試資料給測試案例進行多次的測試。


使用資料提供者，能讓測試更簡潔，因為，可以將測試的 assertions 與測試資料分開寫。


#### ● 測試 3 - 限制報名人數
在一開始有提到，活動報名系統，會限制每個活動的報名人數。測試案例要測試多個不同報名人數的活動，如果報名成功，`reserve()` 會回傳 `true`，相反的報名失敗則回傳 `false`。


##### src/PHPUnitEventDemo/Event.php
```php
<?php
namespace PHPUnitEventDemo;


class Event
{
        // ignores ...


        public function reserve($user)
        {           
            // 報名人數是否超過限制
            if ($this->attendee_limit > $this->getAttendeeNumber()) {
                // 使用者報名
                $this->attendees[$user->id] = $user;
                
                return true;
            }
            
            return false;
        }


        // ignores ...
}
```
在 `Event` 類別的 `reserve()` 加入判斷，目前報名人數是否超過活動限制的報名人數，如果沒超過，`User` 物件加入到 `$attendees` 陣列內，回傳 `true`，超過的話，則回傳 `false`。




##### tests/EventTest.php
```php
<?php


class EventTest extends PHPUnit_Framework_TestCase
{
        // ignore ...
    
        /**
         *  @dataProvider eventsDataProvider
         */
        public function testAttendeeLimitReserve($eventId,
            $eventName, $eventStartDate, $eventEndDate,
            $eventDeadline, $attendeeLimit)
        {
            // 測試報名人數限制
            $event = new \PHPUnitEventDemo\Event($eventId,
                $eventName, $eventStartDate, $eventEndDate,
                $eventDeadline, $attendeeLimit);
            $userNumber = 6;
            
            // 建立不同使用者報名
            for ($userCount = 1; $userCount <= $userNumber; $userCount++) {
                $userId = $userCount;
                $userName = 'User ' . $userId;
                $userEmail = 'user' . $userId . '@openfoundry.org';
                $user = new \PHPUnitEventDemo\User($userId, $userName, $userEmail);
                
                $reservedResult = $event->reserve($user);
                
                // 報名人數是否超過
                if ($userCount > $attendeeLimit) {
                    // 無法報名
                    $this->assertFalse($reservedResult);
                } else {
                    $this->assertTrue($reservedResult);
                }
            }
        }
    
        public function eventsDataProvider()
        {
            $eventId = 1;
            $eventName = "活動1";
            $eventStartDate = '2014-12-24 12:00:00';
            $eventEndDate = '2014-12-24 13:00:00';
            $eventDeadline = '2014-12-23 23:59:59';
            $eventAttendeeFull= 5;
            $eventAttendeeLimitNotFull = 10;
            
            $eventsData = array(
                array(
                    $eventId,
                    $eventName,
                    $eventStartDate,
                    $eventEndDate,
                    $eventDeadline,
                    $eventAttendeeFull
                ) ,
                array(
                    $eventId,
                    $eventName,
                    $eventStartDate,
                    $eventEndDate,
                    $eventDeadline,
                    $eventAttendeeLimitNotFull
                )
            );
            
            return $eventsData;
        }
}
```


在 `EventTest` 類別內，加入一個測試方法為 `testAttendeeLimitReserve()` 來測試限制報名人數。


 - `testAttendeeLimitReserve()` : 標註了 `@dataProvider eventsDataProvider`，會取得來自 `eventsDataProvider()` 的測試資料
 - `eventsDataProvider()` : 資料提供者，回傳了一個陣列，第一層陣列有兩個元素，表示有兩筆測試資料；第二層陣列有六個元素，表示每個資料傳到測試案例內為六個引數


`eventsDataProvider()` 的活動資料會由 `testAttendeeLimitReserve()` 接收，共會分別測試兩次，第一次的測試，會收到報名人數 5 個人的活動；第二次則是會收到報名人數 10 個人的活動。


在 `testAttendeeLimitReserve()` 測試案例內，會依來自 `eventDataProvider()` 的回傳值建立不同報名人數的 `Event` 物件，每個活動都會有 6 個不同的使用者報名，如果已經報名的人數還沒超過活動限制的報名人數，預期 `Event` 的 `reserve()` 方法的回傳值為 `true`，反之，超過活動限制的報名人數，則就會預期回傳 `false`。


執行測試
```sh
$ phpunit --bootstrap vendor/autoload.php tests/EventTest
PHPUnit 4.4.0 by Sebastian Bergmann.


....


Time: 34 ms, Memory: 3.50Mb


OK (4 tests, 16 assertions)
```


從測試訊息可以看到，在 `EventTest` 測試中，有 3 個測試案例，但是測試結果跑了 4 個測試，為什麼呢？


因為 `testAttendeeLimitReserve()` 使用了 `eventsDataProvider()` 作為資料提供者，`eventsDataProvider()` 提供了兩筆資料，這兩筆資料會分別執行兩次測試，加上另外兩個測試案例，所以共有 4 個測試。


#### Data Provider 與 Test Dependency 的問題
先來看例子，再說明會造成的問題。


##### tests/EventTest.php
```php
<?php


class EventTest extends PHPUnit_Framework_TestCase
{
        public function testReserve()
        {
            // 測試報名
            
            // ignore ...
        }
    
        /**
         *  @dataProvider eventsDataProvider
         */
        public function testAttendeeLimitReserve($eventId,
             $eventName, $eventStartDate, $eventEndDate,
             $eventDeadline, $attendeeLimit)
        {
            // 測試報名人數限制
            $event = new \PHPUnitEventDemo\Event($eventId,   
                $eventName, $eventStartDate, $eventEndDate,
                $eventDeadline, $attendeeLimit);
            $userNumber = 6;
            
            // 建立不同使用者報名
            for ($userCount = 1; $userCount <= $userNumber; $userCount++) {
                $userId = $userCount;
                $userName = 'User ' . $userId;
                $userEmail = 'user' . $userId . '@openfoundry.org';
                $user = new \PHPUnitEventDemo\User($userId, $userName, $userEmail);
                
                $reservedResult = $event->reserve($user);
                
                // 報名人數是否超過
                if ($userCount > $attendeeLimit) {
                    // 無法報名
                    $this->assertFalse($reservedResult);
                } else {
                    $this->assertTrue($reservedResult);
                }
            }


            return [$event, $user];
        }
    
        public function eventsDataProvider()
        {
            // ignore ...
        }


        /**
         *  @depends testAttendeeLimitReserve
         */
        public function testUnreserve($objs)
        {
            // 測試取消報名
            
            $event = $objs[0];
            $user = $objs[0];
            
            // 使用者取消報名
            $event->unreserve($user);
            
            $unreserveExpectedCount = 0;
            
            // 預期報名人數
            $this->assertEquals($unreserveExpectedCount, $event->getAttendeeNumber());
            
            // 報名清單中沒有已經取消報名的人
            $this->assertNotContains($user, $event->attendees);
        }
}
```


原本 `testUnreserve()` 是依賴 `testReserve()` ，試著將 `testReserve()` 改成依賴 `testAttendeeLimitReserve()`，而 `testAttendeeLimitReserve()` 使用了`eventsDataProvider()` 作為資料提供者。


接著，執行這個測試。
```sh
$ phpunit --bootstrap vendor/autoload.php tests/EventTest
PHPUnit 4.4.0 by Sebastian Bergmann.


...PHP Fatal error:  Call to a member function unreserve() on a non-object in /Users/aming/git/PHPUnit-Event-Demo/tests/EventTest.php on line 114
PHP Stack trace:


# ignore...
```


從測試結果可以看出來，在執行 `testUnreserve()` 測試案例的時候，無法取得 `$event` 物件，表示 `testUnreserve()` 根本沒取得來自 `testAttendeeLimitReserve()` producer 所回傳的值。


所以，在使用相依測試 (Test dependecy) 與資料提供者 (Data provider) 要特別注意，被相依的測試案例，是否有使用資料提供者。


### 4. Test Exceptions (異常測試)
開發的時候，除了要確保程式運作正常、功能有達到之外，也要對程式可能會超出正常執行的部分進行異常處理，而不是讓程式直接噴出錯誤訊息或忽然的運作停止，如果是這個情況通常都會丟出一個異常出來，讓程式能順暢的處理錯誤，所以，Test exceptions 主要是預期執行發生錯誤的時候，程式會丟出異常出來。


#### ● 測試 4 - 防止重複報名
報名功能需要加入防止相同使用者重複報名相同的活動，如果重複報名的話，就會拋出一個異常出來，接下來的測試，會預期接收到重複報名的異常。


先撰寫要拋出的異常類別。
##### src/PHPUnitEventDemo/EventException.php
```php
<?php
namespace PHPUnitEventDemo;


class EventException extends \Exception
{
        const DUPLICATED_RESERVATION = 1;
}
```


接下來撰寫拋出異常的實作。
##### src/PHPUnitEventDemo/Event.php
```php
<?php
namespace PHPUnitEventDemo;


class Event
{
        // ignore ...
    
        public function reserve($user)
        {           
            // 報名人數是否超過限制
            if ($this->attendee_limit > $this->getAttendeeNumber()) {
                // 是否已經報名
                if (array_key_exists($user->id, $this->attendees)) {
                    throw new \PHPUnitEventDemo\EventException(
                        'Duplicated reservation',
                        \PHPUnitEventDemo\EventException::DUPLICATED_RESERVATION
                    );
                }
                // 使用者報名
                $this->attendees[$user->id] = $user;
                
                return true;
            }
            
            return false;
        }
}
```
因為 `Event` 的 `$attendees` 陣列，是用 `User` 物件 `$id` 為索引值，來儲存報名使用者的 `User` 物件。要判別使用者是否已經報名過相同的活動，只要報名的使用者 id 有存在 `$attendees` 陣列索引值，表示已經有報名活動，如果已報名活動，就會拋出例外。


##### tests/EventTest.php
```php
<?php


class EventTest extends PHPUnit_Framework_TestCase
{
        // ignore ...
    
        /**
         * @expectedException \PHPUnitEventDemo\EventException
         * @expectedExceptionMessage Duplicated reservation
         * @expectedExceptionCode 1
         */
        public function testDuplicatedReservationWithException()
        {
            // 測試重複報名，預期丟出異常
            
            $eventId = 1;
            $eventName = '活動1';
            $eventStartDate = '2014-12-24 12:00:00';
            $eventEndDate = '2014-12-24 13:30:00';
            $eventDeadline = '2014-12-23 23:59:59';
            $eventAttendeeLimit = 10;
            $event = new \PHPUnitEventDemo\Event($eventId,
                $eventName, $eventStartDate, $eventEndDate,
                $eventDeadline, $eventAttendeeLimit);
            
            $userId = 1;
            $userName = 'User1';
            $userEmail = 'user1@openfoundry.org';
            $user = new \PHPUnitEventDemo\User($userId, $userName, $userEmail);


            // 同一個使用者報名兩次
            $event->reserve($user);
            $event->reserve($user);
        }
}
```


在 `EventTest` 內增加一個 `testDuplicatedReservationWithException()` 測試案例，在註解內標註：


 1. `@expectedException \PHPUnitEventDemo\EventException` : 預期的異常類別
 2. `@expectedExceptionMessage Duplicated reservation` : 預期的異常訊息
 3. `@expectedExceptionCode 1` : 預期的異常代碼


也就是，預期在這個測試案例內會接收到 `EventException` 的異常類別、異常訊息為 `Duplicated reservation`，異常代碼為 1。


執行測試
```sh
$ phpunit --bootstrap vendor/autoload.php tests/EventTest
PHPUnit 4.4.0 by Sebastian Bergmann.


.....


Time: 53 ms, Memory: 3.50Mb


OK (5 tests, 19 assertions)
```


### 5. Fixtures
Fixture 能協助測試時，需要用到的測試環境、物件的建立，在測試完後，把測試環境、物件拆解掉，還原到初始化前的狀態。


主要透過 `setUp()`與 `tearDown()` 分別來初始化測試與拆解還原到初始化前的狀態。


下面一樣利用 *test/EventTest.php* 來示範，先了解目前測試有哪些問題。


##### tests/EventTest.php
```php
<?php


class EventTest extends PHPUnit_Framework_TestCase
{
        public function testReserve()
        {
            // 測試報名
            
            $eventId = 1;
            $eventName = '活動1';
            $eventStartDate = '2014-12-24 12:00:00';
            $eventEndDate = '2014-12-24 13:30:00';
            $eventDeadline = '2014-12-23 23:59:59';
            $eventAttendeeLimit = 10;
            $event = new \PHPUnitEventDemo\Event($eventId,
                $eventName, $eventStartDate, $eventEndDate,
                $eventDeadline, $eventAttendeeLimit);
            
            $userId = 1;
            $userName = 'User1';
            $userEmail = 'user1@openfoundry.org';
            $user = new \PHPUnitEventDemo\User($userId, $userName, $userEmail);
            
            // ignore ...
        }
   
        // ignore ...


        /**
         * @expectedException \PHPUnitEventDemo\EventException
         * @expectedExceptionMessage Duplicated reservation
         * @expectedExceptionCode 1
         */
        public function testDuplicatedReservationWithException()
        {
            // 測試重複報名，預期丟出異常
            
            $eventId = 1;
            $eventName = '活動1';
            $eventStartDate = '2014-12-24 12:00:00';
            $eventEndDate = '2014-12-24 13:30:00';
            $eventDeadline = '2014-12-23 23:59:59';
            $eventAttendeeLimit = 10;
            $event = new \PHPUnitEventDemo\Event($eventId,
                $eventName, $eventStartDate, $eventEndDate,
                $eventDeadline, $eventAttendeeLimit);
            
            $userId = 1;
            $userName = 'User1';
            $userEmail = 'user1@openfoundry.org';
            $user = new \PHPUnitEventDemo\User($userId, $userName, $userEmail);


            // ignore ...
        }
}
```


注意 `testReserve()`、`testDuplicatedReservationWithException()` 兩個測試案例，都需要在測試前建立 `Event` 與 `User` 物件，使用 `setUp()` 在測試前，建立兩個物件，測試完後，`tearDown()` 再把不需要的物件清空。


加入 fixtures 後
##### tests/PHPUnitEventDemo.php
```php


class EventTest extends PHPUnit_Framework_TestCase
{
        private $event;
        private $user;
    
        public function setUp()
        {
            $eventId = 1;
            $eventName = '活動1';
            $eventStartDate = '2014-12-24 12:00:00';
            $eventEndDate = '2014-12-24 13:30:00';
            $eventDeadline = '2014-12-23 23:59:59';
            $eventAttendeeLimit = 10;
            $this->event = new \PHPUnitEventDemo\Event(
                $eventId, $eventName,  $eventStartDate,
                $eventEndDate, $eventDeadline,    
                $eventAttendeeLimit);
                
            $userId = 1;
            $userName = 'User1';
            $userEmail = 'user1@openfoundry.org';
            $this->user = new \PHPUnitEventDemo\User($userId, $userName, $userEmail);
        }
        public function tearDown()
        {
            $this->event = null;
            $this->user = null;
        }
        public function testReserve()
        {
            // 測試報名
                    
            // 使用者報名活動
            $this->event->reserve($this->user);
            
            $expectedNumber = 1;
            
            // 預期報名人數
            $this->assertEquals($expectedNumber, $this->event->getAttendeeNumber());
            
            // 報名清單中有已經報名的人
            $this->assertContains($this->user, $this->event->attendees);
            
            return $this->event;
        }
    
        // ignore ...
    
        /**
         * @expectedException \PHPUnitEventDemo\EventException
         * @expectedExceptionMessage Duplicated reservation
         * @expectedExceptionCode 1
         */
        public function testDuplicatedReservationWithException()
        {
            // 測試重複報名，預期丟出異常
            
            // 同一個使用者報名兩次
            $this->event->reserve($this->user);
            $this->event->reserve($this->user);
        }
}
```


把 `$event`、`$user` 物件修改成全域變數，接著把建立物件寫在 `setUp()` 中，清空物件寫在 `tearDown()`，再將 原本 `testReserve()` 與 `testDuplicatedReservationWithException()` 中的 建立 `$event` 與 `$user` 物件程式移掉，且使用到這兩個變數改成使用全域變數，也就是 `$this->event`、`$this->user`。


所以在執行測試的時候，運作順序會是：
`setUp()` → `testReserve()` → `tearDown()` → ... → `setUp()` → `testDuplicatedReservationWithException()` → `tearDown()`




## 五、設定 PHPUnit
在前面此用 PHPUnit 工具來執行測試時，有用到 **--bootstrap**，在執行測試前先執行 *vendor/autoload.php* 程式來註冊 autoloading 的 function。可是每次執行測試，都要加上參數有點麻煩，所以，PHPUnit 可以利用 XML 設定檔來設定。


將 phpunit.xml 設定檔放在專案目錄下，與 src、tests 同一層。


##### phpunit.xml
```xml
<phpunit
        bootstrap="./vendor/autoload.php">
        <testsuites>
            <testsuite name="MyEventTests">
                <file>./tests/EventTest.php</file>
            </testsuite>
        </testsuites>
</phpunit>
```


 - `<phpunit>` : 加入 `bootstrap` 屬性，對應到的值就是要執行的程式檔案
 - `<testsuites>` : 在專案底下，能採用不同的測試組合。由一至多個的 `<testsuite>` 組成
 - `<testsuite>` : `name` 屬性，設定測試組合的名稱。測試組合內會包括許多測試程式檔案。


執行測試，如果 XML 設定檔檔名不是 phpunit.xml 的話，可以利用 `--configuraton` 來指定 XML 設定檔的路徑，如果檔名是 phpunit.xml ，就能省略不指定。
```sh
$ phpunit --configuration phpunit.xml tests/EventTest
```


也可以執行不同的測試組合
```sh
$ phpunit MyEventTests
```


還有更多 XML 設定檔可以使用，參考：https://phpunit.de/manual/current/en/appendixes.configuration.html


## 六、Code Coverage 分析
撰寫好單元測試之後，該如何了解到哪些目標程式還沒有經過測試？目標程式被測試百分比有多少？


PHPUnit 是利用 [PHP_CodeCoverage](https://github.com/sebastianbergmann/php-code-coverage) 來計算程式碼覆蓋率 (Code coverage)，需要安裝 Xdebug。


該如何產生 Code coverage 呢？
先在專案底下建立一個 *reports/* 目錄，存放 Code coverage 分析的結果。
```sh
$ phpunit --bootstrap vendor/autoload.php phpunit.xml --coverage-html reports/ tests/
```


當然，也可以使用 XML 設定檔來設定。
##### phpunit.xml
```xml
<phpunit
        bootstrap="./vendor/autoload.php">
        <testsuites>
            <testsuite name="MyEventTests">
                <file>./tests/EventTest.php</file>
            </testsuite>
        </testsuites>
        <logging>
            <log type="coverage-html" target="reports/" charset="UTF-8"/>
        </logging>
</phpunit>
```
接著執行測試
```sh
$ phpunit tests/
```


就可以在 reports/ 下打開 *index.html* 或其他 HTML 檔案，瀏覽 Code coverage 分析的結果。


![enter image description here](http://blog.fmbase.tw/wp-content/uploads/2014/12/Code_Coverage_for__Users_aming_git_Hands-On-Writing-Unit-Testing-With-PHPUnit_src_PHPUnitEventDemo_Event_php-%E6%8B%B7%E8%B2%9D.png)


## 更多資料


 - 範例程式：https://github.com/ymhuang0808/PHPUnit-Event-Demo
 - PHPUnit 安裝：https://github.com/ymhuang0808/Hands-On-Writing-Unit-Testing-With-PHPUnit/wiki
 - 參考資料：https://phpunit.de/documentation.html
___


##[企業應用] SME Server全功能閘道伺服器建置與管理##

顧武雄／文

**作者簡介：顧武雄，Microsoft MVP、MCITP 與 MCTS 認證專家、台灣微軟 Technet、Tech Day、Webcast、MVA 特約資深顧問講師。目前個人 Linux 著作有：「Linux 企業現場應用系統」、「Linux 私有雲社群網路現場實戰」。**

引言：今日筆者所要介紹的一款 SME Server 9.0 開放原始碼閘道伺服器，是如今國內外極為少有的全功能 IT 解決方案。它非常適用在中小型的企業網路架構之中，不僅可以幫老闆節省掉不少的建置成本，又可作為內外網路間、人員間協同作業時的安全管理平台。

###簡介

在 IT 預算相當有限的中小型企業營運中，若是想要自行建置一部全功能的閘道伺服器，來提供內外用戶端使用者跨平台的網路連線服務，即便是聘請了 Linux 伺服器平台的專家，也得花費好一段漫長的時日，才能夠建構出一個像樣的伺服器，更別說是採用以 Windows Server 平台為主的商用伺服器建置了，需要投入的成本肯定是相當可觀的。

早在 SME Server 8.0 時，筆者就已經注意到它的存在，等了近一年多的時間，歷經了 8.1 版本，如今最期盼的 9.0 正式版本終於發行了。值得注意的是，8.0 版本是架構在 Centos 5.8 的 Linux 作業系統之上，而 8.1 則是 CentOS 5.10，至於最新的 9.0 版本則是 CentOS 6.5。

SME Server 除了提供 Linux、Windows 以及 Macintosh 跨平台用戶端的連線存取之外，主要提供的功能有伺服器命令主控台基礎管理介面、全 Web 化完整功能管理介面、檔案分享與印表機共用配置、安全閘道連線服務、基礎 Email 服務、Web Mail 網站服務、垃圾郵件與病毒過濾、遠端存取服務、符合工業標準的 LDAP 目錄服務、企業 Apache 網站服務（支援 LAMPP 環境）、軟體式磁碟陣列、USB 與磁帶 (Tape) 儲存裝置備份、系統自動更新服務以及延伸整合功能等等。其中在延伸整合功能的應用部分，像是與 Joomla CMS、HylaFax Server、VOIP PBX 以及相關網站內容篩選器套件的延伸整合等等。

如圖 1 所示便是 SME Server 的官方網站，您可以在它的首頁上看到有關於 SME Server 主要功能的介紹，並且還可以點選進入到它專屬的[線上討論區](http://forums.contribs.org/)，或是去下載相關的[附加套件](http://wiki.contribs.org/Category:Contrib)。

SME Server最新版本下載網址：
http://wiki.contribs.org/SME_Server:Download

![圖 1：官方網站](http://www.openfoundry.org/images/150113/image001.png)
▲圖 1：官方網站

####基本安裝設定

關於 SME Server 的安裝，無論是哪個版本整個安裝設定的過程通常不會超過 20 分鐘。當我們使用所下載的 SME Server 9.0 ISO 檔案進行開機時，將會出現如圖 2 所示的安裝選單。在系統預設的狀態下，如果您已經連接了兩顆本地硬碟並且選擇第一個安裝選項，系統將會使用 RAID 1 的磁碟陣列模式來完成安裝。然而如果您所準備的本地硬碟僅有一顆或是大於兩顆以上，則可以改選取 [RAID and LVM installation options] 項目，來挑選使用無陣列模式 (No Raid)，或是以下幾種可選用的陣列模式：

- 三顆本地硬碟：預設將自動使用兩顆作為 RAID 1，一顆作為熱備援用途 (Hot-spare)。
- 四至六顆本地硬碟：預設將自動使用 RAID 5 並搭配一顆作為熱備援用途。
- 七顆以上本地硬碟：預設將自動使用 RAID 6 並搭配一顆作為熱備援用途。

在這種磁碟陣列的模式下，可允許在同一時間下兩顆硬碟的損毀狀態中，仍可以繼續維持系統的正常運作。

無論如何，只要是在正式運作的網路環境中，強烈建議您至少準備兩顆本地硬碟，以便讓系統能夠安裝在擁有基礎容錯架構下的硬體環境之中。在接下來的實戰講解中，筆者將以預設的 RAID 1 安裝模式，來介紹整個關於 SME Server 9.0 (64bit) 的建置與管理。

![圖 2：開機選單](http://www.openfoundry.org/images/150113/image002.png)
▲圖 2：開機選單

如同一般 CentOS 作業系統的安裝一樣，首先系統會詢問是否要測試來源的安裝媒體，為了節省時間我們通常都會選擇 [Skip]。接著會來到如圖 3 所示的 [Language Selection] 頁面挑選語系，目前這個版本仍建議選擇使用 [English]，若是選擇繁體中文語系，後續進入到 SME Server 主要的安裝設定中，可能會出現無法正常顯示的問題。

![圖 3：語系選擇](http://www.openfoundry.org/images/150113/image003.png)
▲圖 3：語系選擇

完成了介面語系的選擇之後，還得選擇鍵盤所使用的語言模式，請選取 [us] 即可。來到如圖 4 所示的 [System to Upgrade] 頁面中，請選取 [Erase All disks, and perform a fresh install] 項目，以便進行完整的全新安裝作業。點選 [OK] 繼續。

![圖 4：升級或安裝](http://www.openfoundry.org/images/150113/image004.png)
▲圖 4：升級或安裝

在完成時區選擇了 [Asia / Taipei] 設定之後，將會出現如圖 5 所示的提示訊息，主要是提示我們包括了可卸除式的媒體裝置（例如：USB 隨身硬碟），都將會被這一次的全新安裝，重新劃分磁碟分割區以及格式化，也就是說所有現行資料都會全部被清除。確認後點選 [Write changes to disk] 繼續。

![圖 5：安裝警告](http://www.openfoundry.org/images/150113/image005.png)
▲圖 5：安裝警告

成功完成基本的系統與程式安裝作業之後，將會出現如圖 6 所示的提示訊息。請點選 [Reboot] 按鈕，來重新啟動系統以便進入到 SME Server 初始化的組態配置，並且可以在一切就緒之後，透過它內建的更新功能，來進行線上更新程式的檢視與安裝。

![圖 6：完成安裝](http://www.openfoundry.org/images/150113/image006.png)
▲圖 6：完成安裝

重新啟動系統之後，首先將會來到如圖 7 所示的 [Choose administrator password] 頁面，請正確輸入兩次的預設管理員帳戶密碼。此密碼千萬不可以忘記，因為後續安裝後的首次登入，將需要使用到它才能夠成功連線使用。

![圖 7：預設管理員密碼設定](http://www.openfoundry.org/images/150113/image007.png)
▲圖 7：預設管理員密碼設定

接著請輸入您公司對外的網域名稱。在如圖 8 所示的 [Primary domain name] 頁面之中，此網域將會成為您公司後續 Email 地址以及網站的尾碼。點選 [Next] 繼續。

![圖 8：主要網域名稱設定](http://www.openfoundry.org/images/150113/image008.png)
▲圖 8：主要網域名稱設定

在如圖 9 所示的 [Select local network device] 頁面中，請正確選擇即將要作為內部網路連線的網路卡，也就是目前已連接公司內部網路的本機網路卡。點選 [Next] 繼續。

![圖 9：主要網域名稱設定](http://www.openfoundry.org/images/150113/image009.png)
▲圖 9：主要網域名稱設定

來到如圖 10 所示的 [Select system name] 頁面中，則必須輸入此伺服器的名稱，至於命名格式可以包含英文字母、數字以及連接符號。必須特別注意的是此名稱在您目前的區域網路中必須是唯一的，否則將可能導致因衝突而讓用戶端連線失敗的問題發生。點選 [Next] 繼續。

![圖 10：主機名稱設定](http://www.openfoundry.org/images/150113/image010.png)
▲圖 10：主機名稱設定

在如圖 11 所示的 [Local networking parameters] 頁面中，請為前面步驟中所指定的內部網路卡，設定一組尚未使用中的 IP 位址，以便後可以提供內部用戶端進行連線與存取。點選 [Next] 繼續。

![圖 11：輸入本地主機 IP](http://www.openfoundry.org/images/150113/image011.png)
▲圖 11：輸入本地主機 IP

緊接著在如圖 12 所示的 [Select local subnet mask] 頁面中，請輸入公司內部網路所使用的子網路遮罩。一般來說中小企業的網路環境，由於使用到的 IP 位址數量並不多，因此通常是輸入 255.255.255.0 即可。

![圖 12：輸入子網路遮罩](http://www.openfoundry.org/images/150113/image012.png)
▲圖 12：輸入子網路遮罩

在如圖 13 所示的 [Select operation mode] 頁面中，必須選擇此 SME 伺服器所要扮演的角色，依序分別是 [伺服器與閘道主機]、[內部伺服器與閘道主機]、[唯一伺服器角色]。在此若選擇 [伺服器與閘道主機] 角色，系統將提供您一部同時可以對內以及對外服務的伺服器，這包括外部 Email 與網站系統等等。然後如果您希望既能夠讓內部用戶端的使用者可以安全存取 Internet 以及內部資源，但卻又不希望開放任何對外的資源存取，這時候就可以選擇 [內部伺服器與閘道主機] 。至於如果公司網路中目前已經有專屬的閘道設備（例如：防火牆、VPN設備），則可以選擇唯一伺服器角色，以簡化管理與維護上的複雜度。

請注意！關於 SME 伺服器角色的選擇，無論是選擇 [Server and gateway] 還是 [Private server and gateway]，皆是需要準備好兩張網路卡，如此才能夠運行閘道的相關服務。

![圖 13：        作業模式選擇](http://www.openfoundry.org/images/150113/image013.png)
▲圖 13：        作業模式選擇

在如圖 14 所示的 [Select external access mode] 頁面中，必須選擇 SME 伺服器連線Internet 的方式。其中如果選擇第一項的 [dedicated]，即表示要透過公司目前現有的專線或 ADSL 的設備來直接連線 Internet，我將以此選擇來作為連線示範。至於如果選擇 [dialup] 則表示要使用傳統數據撥接的方式，一般公司應該已沒有在使用這種連線方式。點選 [Next] 繼續。

![圖 14：Internet 存取方式設定](http://www.openfoundry.org/images/150113/image014.png)
▲圖 14：Internet 存取方式設定

前面我們曾提到 SME 伺服器的三種角色，前兩種皆是需要有預先準備好兩張網路卡，否則到這個步驟時將會出現如圖 15 所示的錯誤訊息，而無法繼續前進接下來的設定。

![圖 15：可能的錯誤訊息](http://www.openfoundry.org/images/150113/image015.png)
▲圖 15：可能的錯誤訊息

若是系統有偵測到第二張網路卡，將會出現如圖 16 所示的 [Select external network device] 頁面。在此除非您還有連接第三張網路卡，否則唯一的外部網路卡的選擇，應該是像範例中的一樣，僅會有一張可用的網路卡可以選取。點選 [Next] 繼續。

![圖 16：選取外部連線網路卡](http://www.openfoundry.org/images/150113/image016.png)
▲圖 16：選取外部連線網路卡

來到如圖 17 所示的 [External Interface Configuration] 頁面中，必須選擇設定 IP 位址的方式。若是您的公司已經可以上網的 ISP 固定 IP 位址，對於內部網路中各類伺服器主機的使用，強烈建議採用靜態 IP 位址 (Use static IP Address) 的配置方式。至於一般的用戶端電腦以及各類行動裝置，則是採用 DHCP 的動態 IP 配置設定即可。點選 [Next] 繼續。

![圖 17：指定外部網路卡IP配置方式](http://www.openfoundry.org/images/150113/image017.png)
▲圖 17：指定外部網路卡IP配置方式

在如圖 18 所示的 [Select gateway IP address] 頁面中，請輸入目前公司連線 Internet 網路時，所使用的閘道 IP 位址。此位址有可能是外部真實的 IP 位址。點選 [Next] 繼續。

![圖 18：        輸入閘道IP](http://www.openfoundry.org/images/150113/image018.png)
▲圖 18：        輸入閘道IP

解決了外部網路連線的 IP 設定問題之後，緊接著必須決定內部用戶端配置 IP 的方式。如圖 19 所示，在 [Select DHCP server configuration] 頁面中，如果在您目前的內部網路之中沒有任何現行的 DHCP 伺服器，就請選取 [Provide DHCP service to local network] 設定，讓 SME 伺服器來幫您解決公司內所有用戶端的 IP 配置需求，如此一來就不需要為每一台用戶端電腦或智慧裝置手動配置固定 IP 了。點選 [Next] 繼續。

![圖 19：        是否提供DHCP服務](http://www.openfoundry.org/images/150113/image019.png)
▲圖 19：        是否提供DHCP服務

當決定要在 SME 伺服器上提供 DHCP 服務之後，緊接著便需要開始來設定 DHCP 服務的相關組態配置。在如圖 20 所示的 [Select beginning of DHCP host number range] 頁面，首先必須輸入動態 IP 位址分配時的起始 IP 位址，然後再點選 [Next] 完成結束 IP 位址的設定即可。必須注意的是對於這個 IP 位址範圍，請避開任何伺服器主機，或是特殊電腦所會使用到的可能固定位址，這包括了 SME 伺服器的內部網路卡 IP 位址。

![圖 20：        設定動態起始 IP](http://www.openfoundry.org/images/150113/image020.png)
▲圖 20：設定動態起始 IP

接著在如圖 21 所示的 [Corporate DNS server address] 頁面中，請輸入內部現有的 DNS 伺服器位址，以協助 SME 伺服器對於內部網路中所有電腦主機的解析。如果公司內部並沒有建置專用的 DNS 伺服器，則請先保留空白即可。點選 [Next] 繼續。

![圖 21：輸入DNS伺服器位址](http://www.openfoundry.org/images/150113/image021.png)
▲圖 21：輸入DNS伺服器位址

完成了上述有關於網域名稱、伺服器名稱以及各類網路 IP 的配置之後，將會來到如圖 22所示的 [Activate configuration changes] 頁面中，以確定是否要啟用前面步驟中的所有設定值。點選 [Yes] 即可。

![圖 22：啟用主機設定](http://www.openfoundry.org/images/150113/image022.png)
▲圖 22：啟用主機設定

等待幾分鐘的系統啟用設定之後將會重新開機，如圖 23 所示便是來到 CentOS 的命令提示列，請輸入預設的 root 帳號以及安裝時所設定的管理員密碼。成功登入之後，將可以看到目前所使用的 SME Server 版本資訊。

![圖 23：登入](http://www.openfoundry.org/images/150113/image023.png)
▲圖 23：登入

當我們改用預設的 admin 帳戶登入之後，將會開啟如圖 24 所示的伺服器主控台視窗 (Server console)。在此可以很方便管理員對於伺服器本身，進行一些常用的管理作業，這包括了運作狀態檢查、系統組態修改、重新啟動或關機、磁碟陣列資訊檢視、開啟文字介面的伺服器管理、系統備份與還原等等。首先透過 [Check status of this server] 功能，就可以檢視到目前此系統已運行了多久時間。

![圖 24：伺服器主控台](http://www.openfoundry.org/images/150113/image024.png)
▲圖 24：伺服器主控台

如圖 25 所示則是透過 [Manage disk redundancy] 功能，所檢視到的目前磁碟陣列狀態資訊。在這個範例中便是顯示了目前使用了兩顆硬碟，建立磁碟鏡像陣列的容錯備援機制 (RAID 1)。

![圖 25：檢視磁碟陣列狀態](http://www.openfoundry.org/images/150113/image025.png)
▲圖 25：檢視磁碟陣列狀態

當點選 [Access server manager] 將會來到如圖 26 所示的頁面，它即將在您點選 [Yes] 之後開啟純文字模式的瀏覽器，來連線全功能的伺服器管理頁面。必須注意一旦進入後，若想要離開純文字模式的瀏覽器介面，只要按下 q 鍵即可。

![圖 26：存取伺服器管理](http://www.openfoundry.org/images/150113/image026.png)
▲圖 26：存取伺服器管理

如圖 27 所示便是純文字的瀏覽器連線登入頁面。請輸入安裝步驟中所設定的 admin 帳戶與其密碼。後續若想要離開選單畫面只要按下 [ESC] 鍵即可。

![圖 27：文字管理介面登入](http://www.openfoundry.org/images/150113/image027.png)
▲圖 27：文字管理介面登入

如圖 28 所示便是一個純文字的瀏覽器介面，您可以透過 [File] 的下拉選單，來選擇開啟任一網址，瀏覽文字網頁的過程之中，還可以透過相關的快速組合鍵，來進行相關網頁的瀏覽操作，例如您只要按下鍵盤左方位置的 Ctrl+B 就可以回到上一頁，若是按下 Ctrl+F 則可以前進下一頁。

![圖 28：文字管理介面](http://www.openfoundry.org/images/150113/image028.png)
▲圖 28：文字管理介面

請再一次回到伺服器主控台的選單中，您可以開啟如圖 29 所示的 [Reboot, reconfigure or shutdown this server] 頁面，來進行重新啟動、重新設定伺服器、關機。

![圖 29：開關機管理](http://www.openfoundry.org/images/150113/image029.png)
▲圖 29：開關機管理

####使用者與群組管理

在伺服器主控台中以文字瀏覽器的連線管理方式，終究無法像一般瀏覽器的連線方式操作方便。接下來筆者就要開始來講解與示範，正確配置此伺服器功能設定的各項技巧，整個操作過程都將以圖形化的瀏覽器連線方式來進行，並且還會示範幾個透過 Ubuntu Linux 以及 Windows 8.1，來做為用戶端電腦存取各項 SME Server 網路功能的小技巧。

在前面步驟的示範講解中，其實我們就已經看到透過瀏覽器連線 SME Server 的方法了，也就是連線至 https://SME Server位址/server-manager/ 的網址，然後完成帳戶密碼的登入即可。其中 SME Server 位址的輸入可以是 IP 位址、伺服器名稱或是完整網域名稱(FQDN)。不過必須注意的是，在系統預設的狀態之下是不允許管理人員經由外部網路，來連線登入 SME Server 管理中心網站，而是僅能從經由內部網路的連線，否則將會出現如圖 30 所示的錯誤訊息。

![圖 30：預設外部無法連線](http://www.openfoundry.org/images/150113/image030.png)
▲圖 30：預設外部無法連線

當我們經由內部網路中的任一部用戶端電腦瀏覽器，來連線 SME Server 管理中心網站時，將會出現如圖 31 所示的登入頁面，第一次的登入請以預設的 admin 帳號以及您所自訂的密碼來完成登入即可。點選 [Login]。

![圖 31：連線登入 Web 主控台](http://www.openfoundry.org/images/150113/image031.png)
▲圖 31：連線登入 Web 主控台

如圖 32 所示便是 SME Server 的伺服器網站管理介面，在此您可能會發現有一些功能選單是顯示為中文，其實主要是因為此系統介面顯示是支援多國語系，但由於目前繁體中文尚未全面支援，因此才會有這種現象發生。不過沒有關係，您只要將目前瀏覽器所設定的語言優先順序進行修改，例如將 English 設定為第一順位，便可以讓整個介面以全英文的語系來呈現了。

![圖 32：Web 主控台首頁](http://www.openfoundry.org/images/150113/image032.png)
▲圖 32：Web 主控台首頁

初步完成 SME Server 的安裝與登入，首先要進行的管理作業通常是建立新使用者帳戶以及群組，以便讓公司內部的使用者，後續可以經由內部網路甚至於網際網路，來連線存取公司網路中的各項資源。在系統預設的狀態下，僅會有一位內建的 admin 管理員帳戶。請在如圖 33 所示的 [使用者] 頁面中點選 [增加使用者帳號] 按鈕繼續。

![圖 33：使用者帳戶管理](http://www.openfoundry.org/images/150113/image033.png)
▲圖 33：使用者帳戶管理

在如圖 34 所示的新使用者建立設定頁面中，除了帳戶名稱與電話欄位之外，其餘都是可以輸入中文的。其中 [電郵傳遞] 的設定部分，如果該名使用者對於所接收到的 Email，沒有特別要進行轉遞動作，就只要選擇預設的 [傳遞本地端電郵] 設定即可，否則就還必須特別輸入所要進一步轉遞的 Email 地址。最後如果您要授權給該名稱使用者，透過網際網路來連線登入公司的 VPN 網路，則可以在此授予 [VPN使用者端存取] 權限。

![圖 34：增加使用者帳號](http://www.openfoundry.org/images/150113/image034.png)
▲圖 34：增加使用者帳號

如圖 35 所示完成新使用者帳戶的建立之後，您必須點選此帳戶的 [重設密碼] 連結，以便讓該名使用者有一組密碼可以進行第一次登入。未來如果該名使用者留職停薪，則還可以將他的帳戶進行鎖定而無須刪除。

![圖 35：完成新使用者建立](http://www.openfoundry.org/images/150113/image035.png)
▲圖 35：完成新使用者建立

如圖 36 所示便是執行帳戶密碼重設時的顯示頁面，請在完成兩次密碼的輸入之後，點選 [儲存] 按鈕即可。

![圖 36：修改密碼](http://www.openfoundry.org/images/150113/image036.png)
▲圖 36：修改密碼

接下來的示範筆者已將顯示介面切換為純英文的模式。請點選至 [Group] 頁面中並點選 [Add Group] 按鈕，來開啟如圖 37 所示的新群組建立設定頁面。在此請依序輸入新群組名稱、群組的用途描述以及勾選屬於此群組的成員清單。點選 [Add] 按鈕完成建立。

![圖 37：新增群組](http://www.openfoundry.org/images/150113/image037.png)
▲圖 37：新增群組

如圖 38 所示，便是成功完成一個名為 sales 新群組的建立，未來如果有新的業務同仁要加入此群組，只要回到此頁面並點選 [Modify] 連結來修改成員清單即可。值得注意的是後續有一些關於人員權限的賦予方式，也都可以直接授予給特定的群組。

![圖 38：完成群組新增](http://www.openfoundry.org/images/150113/image038.png)
▲圖 38：完成群組新增

####網路芳鄰共用管理

對於公司內部網路中的用戶端使用者而言，最簡便存取公司檔案資源的方式，就是透過類似於網路芳鄰的功能來進行。在 SME Server 中的每一位使用者，除了皆有自己專屬的網路資料夾存放空間之外，也能夠存取其它有被賦予權限的網路共用資料夾（例如：業務部資料夾）。想要提供這一項便利的功能給使用者之前，我們必須先點選至位在 [Configuration] 區域中的 [Workgroup] 點頁面，在此必須輸入將要在網路芳鄰中顯示的工作群組名稱、伺服器名稱。至於其它兩項功能則可以暫時先設定為 [No] 即可。點選 [Save]。

![圖 39：網路工作群組設定](http://www.openfoundry.org/images/150113/image039.png)
▲圖 39：網路工作群組設定

一旦完成了 SME Server 工作群組的建立之後，內部用戶端使用者無論是 Windows 還是 Linux，皆可以在如圖 40 所示的 [網路] 資源瀏覽中，找到 SME Server 的伺服器名稱。請連續點選開啟它。

![圖 40：Windows 網路芳鄰](http://www.openfoundry.org/images/150113/image040.png)
▲圖 40：Windows 網路芳鄰

在開啟 SME Server 的共用資源內容之後，使用者除了可以依據權限設定，來存取各類由管理員所建立的共用資料夾之外，最重要的是還會有屬於自己的儲存空間，那就是以自己帳戶名稱所建立的個人資料夾。如圖 41 所示，在此將可以存入各類型的檔案，包括了 Office 文件檔、照片檔、影音檔等等。

![圖 41：存取共用資料夾](http://www.openfoundry.org/images/150113/image041.png)
▲圖 41：存取共用資料夾

請注意！如果您需要限制每一位使用者在 SME Server 中的資料儲存空間，只要在 [Collaboration] 區域中點選至 [Quotas] 頁面中，然後便可以對於目前任一的帳戶名稱，察看到他目前已使用的空間大小，以及修改所要警告與限制的儲存量大小。

####郵件組態管理

在 SME Server 中有一項相當重要的功能服務，那就是電子郵件伺服器 (Mail Server) 功能，更重要的是它不僅提供一般 SMTP、POP3 以及 IMAP 的 Email 收發服務，還提供了基礎垃圾郵件的過濾功能以及病毒程式的防治服務。因此接下來我們就要來完成一連串有關 Mail Server 的組態配置，以便實際符合自家公司的郵件管理需求。首先請點選至位在 [Configuration] 區域中的 [Email] 頁面。如圖 42 所示，在此可以看到共用有四大類的郵件組態可能需要調整，依序分別是 Email 存取設定、Email 篩選設定、Email 收件設定以及Email 傳遞設定。請先點選第一類的 [Change e-mail access settings] 按鈕繼續。

![圖 42：郵件服務設定](http://www.openfoundry.org/images/150113/image042.png)
▲圖 42：郵件服務設定

在如圖 43 所示的 [E-mail settings] 頁面中，在預設的狀態下 POP3 與 IMAP 的電子郵件信箱服務，皆只允許來自內部網路的用戶端進行連線存取，而 Web Mail 連線功能則是關閉的。一般正常的使用需求，都會將這兩種信箱服務設定，修改成允許內部與外部的網路安全存取，以及開放使用者可以透過 HTTPS 的安全連線方式，來使用 Web Mail 的網站收發信功能。完成修改後請點選 [Save]。

![圖 43：郵件存取方式設定](http://www.openfoundry.org/images/150113/image043.png)
▲圖 43：郵件存取方式設定

接下來我們點選 [Change e-mail filtering settings] 按鈕，來開啟如圖 44 所示的 Email 篩選設定頁面。在此建議您最好能夠將其中的 [Virus scanning] 與 [Spam filtering] 皆設定成 [Enabled]，以便能夠過濾掉各種不需要的垃圾郵件與病毒郵件。然後再來決定垃圾郵件判別的敏感度 (Spam sensitivity) 設定值，此設定一般都會先暫時設定成中度等級 (Medium)，等到觀察一段時間之後，再根據用戶端接收 Email 的情況，再來決定是否需要往更上一層級或向下一層級進行調整。目前垃圾郵件篩選的層級共有五級，當然啦！您也可以自訂標示垃圾郵件主旨以及退件的等級。在預設的狀態下只要被判定為垃圾的郵件，其主旨將會自動被標示 [SPAM] 關鍵字。

![圖 44：垃圾郵件篩選設定](http://www.openfoundry.org/images/150113/image044.png)
▲圖 44：垃圾郵件篩選設定

緊接著點選 [Change e-mail reception settings] 按鈕，來進入到如圖 45 所示的 Email 收件設定頁面。此功能並非是必要的設定，只有在需要變更預設 Email 收件組態時才需要，例如您想要變更上班時間以及下班時間時的自動收件頻率，預設皆是每隔 15 分鐘檢查一次新郵件，太過於頻繁可能會讓一些不是使用行動網路吃到飽方案的使用者，增加其行動數據網路連線的流量問題。

![圖 45：郵件接收設定](http://www.openfoundry.org/images/150113/image045.png)
▲圖 45：郵件接收設定

接著請點選 [Change e-mail delivery settings] 按鈕，來進入到如圖 46 所示的 Email 傳遞設定頁面。在此除了可以設定針對外部 Internet 使用者，寄給公司內未知的收件人時的處裡方式之外（預設 = 自動退信），還可以進一步決定是否要授權給特定的 SMTP 伺服器進行轉信，或是將所有寄送的郵件轉送到其它已授權給此伺服器的 SMTP 服務，然後再寄送到目的地使用者信箱之中。

![圖 46：郵件傳遞設定](http://www.openfoundry.org/images/150113/image046.png)
▲圖 46：郵件傳遞設定

前面我們曾介紹過郵件服務可以結合啟用 ClamAV 的掃毒功能，來防範可能夾帶病毒程式的惡意郵件進入到公司內部網路之中。其實 ClamAV 整合 SME Server，還可以幫我們掃描伺服器中的檔案系統。如圖 47 所示，我們只要開啟 [Antivirus] 設定頁面，就可以決定自動掃描檔案系統的週期（例如：每天），以及決定是否要自動隔離受感染的檔案。點選 [Save] 儲存設定。

![圖 47：防毒功能設定](http://www.openfoundry.org/images/150113/image047.png)
▲圖 47：防毒功能設定

####連線使用VPN網路

對於企業行動工作者而言提供遠端存取的便利服務，將有助於改善協同商務的效率。其中最重要的除了 Email 的收發管理之外，就是屬於 VPN 網路的使用了。我們可以從 [Security] 區域中點選開啟如圖 48 所示的 [Remote access] 設定頁面。在此首先您可以決定允許經由 PPTP 存取 VPN 網路的連線數量，若是設定為 0，即表示關閉此功能。接著可以決定是否要限制遠端使用者存取內部網路時的範圍限制，必要的話、可以透過網路以及子網路遮罩的輸入來加以限制。

在 [Secure Shell Settings] 區域中，則可以決定是否要開放讓管理者能夠經由遠端來開啟 SSH 的連線工具存取伺服器，其目的在於方便管理人員可以人在外部網路時，仍然可以對於伺服器進行遠端診斷以及故障排除。最後在 [FTP Settings] 設定部分，則可以選擇是否要啟用 FTP 服務的功能，讓人員在外部網路時可以透過像是 FileZilla 的用戶端程式，來進行檔案的上傳或是下載。若打算開放 FTP 遠端存取服務，請將 [FTP access] 設定為 [允許公開存取]，以及將 [FTP password access] 設定為 [Accept password from anywhere] 即可。
![圖 48：遠端存取管理](http://www.openfoundry.org/images/150113/image048.png)
▲圖 48：遠端存取管理

完成了 VPN 網路的啟用設定之後，接下來我們就可以嘗試透過一部位在外部網路的 Windows 8.1 電腦，來建立 VPN 網路的連線登入。首先請如圖 49 所示開啟 [網路和共用中心] 介面，然後點選 [Setup a new connection or network] 連結繼續。

![圖 49：Windows 8.1 網路和共用中心](http://www.openfoundry.org/images/150113/image049.png)
▲圖 49：Windows 8.1 網路和共用中心

在如圖 50 所示的 [Choose a connection option] 頁面中，請在選取 [Connect to a workplace] 項目之後，點選 [Next] 按鈕。接著系統可能會詢問您是否要使用現行的連線還是建立新的連線，請點選建立新的連線繼續。

![圖 50：選擇連線需求](http://www.openfoundry.org/images/150113/image050.png)
▲圖 50：選擇連線需求

在如圖 51 所示的 [How do you want to connect] 頁面中，請選取 [Use my Internet connection (VPN)] 設定，來建立與 SME Server 的 VPN 網路連線。接著您需要設定連線的位址，也就是SME Server外部網路卡 IP 位址，或是現有其它閘道設備的 IP 位址，您可以選擇輸入 IP 位址或是完整網域名稱 (FQDN)。點選 [Create] 按鈕完成新連線建立。

![圖 51：選擇 VPN 連線方式](http://www.openfoundry.org/images/150113/image051.png)
▲圖 51：選擇 VPN 連線方式

完成 VPN 網路連線的設定之後，接下來使用者只要點選位在桌面右下方的網路圖示，便會開啟如圖 52 所示的右側窗格。在此將可以看到我們所建立的 VPN 網路連線項目，請點選它繼續。

![圖 52：選擇網路連線](http://www.openfoundry.org/images/150113/image052.png)
▲圖 52：選擇網路連線

緊接著將會出現如圖 53 所示的身份驗證視窗，請輸入在 SME Server 中有授予 VPN 網路權限的使用者帳戶與密碼。點選 [OK]。

![圖 53：輸入帳號密碼](http://www.openfoundry.org/images/150113/image053.png)
▲圖 53：輸入帳號密碼

一旦成功連線了 SME Server 的 VPN 網路之後，將同樣可以在如圖 52 所示的 [Network] 頁面中，檢視到已連線的 VPN 網路。後續如果想要中止 VPN 連線，只要再一次點選該連線項目，然後再點選 [Disconnect] 即可。

![圖 54：成功連線 VPN 網路](http://www.openfoundry.org/images/150113/image054.png)
▲圖 54：成功連線 VPN 網路

過去許多 VPN 網路的用戶端使用者，經常會遭遇到一個問題，那就是一旦連線了公司的 VPN 網路之後，雖然可以開始存取公司內網路的各項資源，但奇怪的是卻無法連線網際網路。其實這個問題與閘道 IP 的設定有關，解決方法請先在目前所建立的 VPN 網路上，按下滑鼠右鍵點選 [Properties] 來開啟如圖 55 所示的頁面，然後在選取 [Internet Protocol Version 4 (TCP / IPv4)] 項目之後，點選 [Properties] 按鈕繼續。

![圖 55：        VPN 連線屬性](http://www.openfoundry.org/images/150113/image055.png)
▲圖 55：        VPN 連線屬性

在如圖 56 所示的 [IP Settings] 頁面中，請將 [Use default gateway on remote network] 設定勾選。點選 [OK] 完成設定即可。再試試是否已經能夠連線網際網路了。

![圖 56：IP 組態設定](http://www.openfoundry.org/images/150113/image056.png)
▲圖 56：IP 組態設定

在 VPN 網路的連線狀態下，如果遠端使用者想要查看目前所配置的 IP 位址資訊，以及所使用的 VPN 網路通訊協定資訊，只要在連線的 VPN 網路圖示上，按下滑鼠右鍵並點選 [Status]，即可開啟如圖 57 所示 [Details] 的完成資訊頁面。在此不僅可以看到遠端用戶端電腦與伺服器各自的 IP 位址，還能夠知道此 VPN 網路所使用的通訊協定以及加密驗證方式。

![圖 57：連線資訊檢視](http://www.openfoundry.org/images/150113/image057.png)
▲圖 57：連線資訊檢視

在確認已經完成 VPN 網路的連線並且取得內部 IP 位址之外，在遠端用戶端電腦上，最好能夠進一步開啟如圖 58 所示的命令提示介面，透過 Ping 命令來測試一下與公司內部的其它電腦通訊是否正常。

![圖 58：連線內部網路測試](http://www.openfoundry.org/images/150113/image058.png)
▲圖 58：連線內部網路測試

####人員郵件收發管理

在前面有關於伺服器設定的講解中，我們已經啟用了郵件伺服器的相關設定，因此接下來我們就可以透過任何的收發信軟體，在內部或是外部用戶端電腦上來進行 Email 信箱的連線。在此筆者以一款內建於 Ubuntu Linux 作業系統中的 Thunderbird 軟體來作為操作示範。如圖 59 所示便是 Thunderbird 的個人 Email 收發管理介面，在 [帳號] 區域中請點選 [建立新帳號] 繼續。

![圖 59：Thunderbird 個人郵件管理](http://www.openfoundry.org/images/150113/image059.png)
▲圖 59：Thunderbird 個人郵件管理

如圖 60 所示便是 [郵件帳號設定] 頁面，在此除了需要輸入識別用的中文姓名、電子郵件地址以及密碼之外，還必須指定收件與發信的服務類型以及主機名稱，至於通訊埠、SSL 以及認證方式皆採用自動偵測即可。完成設定之後，可以先進行連線測試，只有在通過連線測試時才能夠點選 [完成] 按鈕。

![圖 60：郵件帳號設定](http://www.openfoundry.org/images/150113/image060.png)
▲圖 60：郵件帳號設定

成功完成 Email 伺服器的登入連線之後，您可以立即點選 [寫信] 圖示來測試對內以及對外的發信測試，等到內部使用者與外部連絡人都收到 Email 之後，再透過這一些信箱進行 Email 的回覆即可，若是都能夠收到 Email 即表示 SME Server 的郵件服務是在正常運行之中。

![圖 61：郵件收發測試](http://www.openfoundry.org/images/150113/image061.png)
▲圖 61：郵件收發測試

關於 SME Server 的用戶端使用者，不僅可以透過任何的郵件收發軟體（包括 Office Outlook、Outlook Express 等等），來進行個人 Email 信箱的收發信管理，若是 SME Server 有特別啟用 Web Mail 功能，則使用者也可以透過更方便的網站信箱服務，以瀏覽器開啟如圖 62 所示的 Web Mail 登入頁面。使用者只要在網址列輸入 https://SME Server位址/webmail/ 即可。在此除了需要輸入登入的帳戶密碼之外，還可以在登入之前挑選想要使用的介面語系。點選 [登入]。

![圖 62：Web Mail登入](http://www.openfoundry.org/images/150113/image062.png)
▲圖 62：Web Mail登入

如圖 63 所示便是 SME Server 的 Web Mail 網站操作介面。在這裡除了可以進行一般常見的收發信、通訊錄管理之外，最棒的就是它可以直接讓使用者存取到本地端的 LDAP 人員群組名錄，有效解決了企業公用通訊錄的使用需求。

![圖 63：本地LDAP帳戶管理](http://www.openfoundry.org/images/150113/image063.png)
▲圖 63：本地LDAP帳戶管理

如圖 64 所示頁面即是 [寫信] 的編輯範例。在此除了可以自訂編碼方式、拼字檢查、上傳附件檔案之外，還可以決定是否要連同附件一同完成寄件備份，此外更可以決定是否要讓附件檔案僅顯示超連結，來供收件者點選後才進行下載，有效大幅節省伺服器的可用儲存空間。點選 [通訊錄] 繼續。

![圖 64：郵件寄送測試](http://www.openfoundry.org/images/150113/image064.png)
▲圖 64：郵件寄送測試

在如圖 65 所示的 [通訊錄] 視窗之中，除了可以從使用者個人的通訊錄來挑選收件人、副本以及密件副本之外，也可以從公司的通訊錄 (Local LDAP) 來挑選人員或群組。完成設定請點選 [確認]。

![圖 65：挑選收件者](http://www.openfoundry.org/images/150113/image065.png)
▲圖 65：挑選收件者

如圖 66 所示，便是執行傳送郵件之後，收件者所收到的 Email 範例，從中可以發現其中的附件檔案已被轉換為超連結位址，使用者必須點選附件中的伺服器超連結，來下載所需要的檔案。

![圖 66：收件範例](http://www.openfoundry.org/images/150113/image066.png)
▲圖 66：收件範例

####其它常用功能的使用

關於 SME Server 的系統更新，它本身已經內建了專屬的更新功能，管理員只要點選位在 [Configuration] 區域中的 [Software Installer] 項目，即可開啟如圖 67 所示的軟體更新管理頁面。在此預設的狀態下更新檢查功能已是在啟動狀態，您可以點選 [List available updates] 按鈕，查看目前可用的軟體更新清單。

![圖 67：        軟體更新管理](http://www.openfoundry.org/images/150113/image067.png)
▲圖 67：        軟體更新管理

在如圖 68 所示頁面的 [Update available] 欄位之中，便可以看到目前所有可下載與更新的軟體套件，您只要在連續選取多個要更新的項目之後，再點選 [Install selected updates] 按鈕，即可進行指定套件的更新作業。

![圖 68：        軟體更新安裝](http://www.openfoundry.org/images/150113/image068.png)
▲圖 68：        軟體更新安裝

本文最後相信有一項功能是所有讀者都必須知道的，那就是如圖 69 所示位在 [Administration] 區域中的 [Reboot or shutdown]。在此頁面中您將可以從下拉選單之中，挑選所要執行的操作，依序分別是重新啟動 (Reboot)、重新設定 (Reconfigure)、關機 (Shutdown)。確認選擇後點選 [Perform] 按鈕即可。
![圖 69：        關機管理](http://www.openfoundry.org/images/150113/image069.png)
▲圖 69：關機管理

###結論
SME Server 是一套筆者在國內相當推薦的優質網路閘道方案，它不僅在伺服器安裝與管理介面設計上，讓即便不熟悉 Linux 的網管人員也能夠輕鬆上手，對於不同用戶端使用者的資源存取需要，也能夠在一個高度安全的基礎平台上，輕鬆完成團隊的任務以及使命。不過可惜的是如今國內只有鮮少的企業 IT 知道，期望能夠藉由此專欄的技術分享，讓更多有心一同打造優質開放原始碼網路環境的 IT 人，可以知道更多學習更多發揮更多創造更多。
___


##[自由專欄] 國家地理野放開放源碼##


謝良奇／翻譯


**本文翻譯自 opensource.com，原作者為 Robin Muilwijk：[https://opensource.com/life/14/12/interview-shah-selbe-national-geographic-explorers](https://opensource.com/life/14/12/interview-shah-selbe-national-geographic-explorers)**


一群國家地理探險家起身前往非洲原野的奧卡萬戈三角洲 (Okavango Delta)，使用開放硬體、Raspberry Pi 以及開源軟體，調查水質、野生動物蹤跡等等。他們建了一個網站公開分享資料，在開放源碼的協助下，保留了非洲原野的這一片生態。


日前我獲得訪問 Shah Selbe 的機會，他來自國家地理，打從心底就是一位探險家。我問了他關於他是如何跨入保育工作、如何學習並使用開放源碼，以及他如何在奧卡萬戈原野計畫 (Okavango Wilderness Project) 的工作上運用開源方法。


**問：可以介紹一下你自己、你的背景，以及你如何得知開放源碼？**


我是位工程師，並且衷心相信工程能力可以解決我們這個星球最大的問題。我在取得工程學士學位後，進入某航太主要製造商工作。儘管我覺得作為航太動力工程師的工作在技術上很有挑戰性，我仍持續不斷地找尋其他方式，讓我的工程能力可以直接對世界做出貢獻。在研究所時我參加了無國界工程師 ([Engineers Without Borders](http://www.ewb-usa.org/))，這是個專注於飲用水、衛生、可再生能源等人道主義發展專案的非營利組織。


就在這個時期我首次得知開放源碼開發。航太工業孕育自 1960 與 1970 年代的智財權做法，許多創新想法迅速地取得專利，以便剝奪其競爭對手獲利的可能。我發覺我當時看著許多創新與機會，被不必要的專有設計與延伸方案所扼殺。在那種風氣下系統架構傾向以專利為考量，而不一定是最符合任務所需。對我來說這似乎有些瘋狂，就好像許多改變世界的機會，卻因為人們陷於壞掉的智財權系統中而流失。正是在這種無奈之中，我對開放源碼運動產生了共鳴。


之後，在史丹福大學我開始參與保育議題，並且從工程與開源角度看待這些問題。在海洋保育上我們面臨的挑戰，顯然有許多機會用更聰明的方式來解決。從此之後，我開始作為一名 (我認為) 保育技術專家，將新穎且低成本的適當技術，帶入保育工作當中。


**問：你最近剛從非洲奧卡萬戈三角洲原野回來，你在那裡運用開放硬體與開源軟體來量測、紀錄並存取數據資料。其中之一是 Raspberry Pi。為什麼你會選擇這些方法？**


開放源碼是奧卡萬戈原野計畫的核心。我們的國家地理探險家團隊在此專案上合作，希望徹底改變科學實地考察執行與分享的方式。過去，科學家會進行考察並收集資料，只為了守護這些資料直到他們以此發表獲得科學上的讚賞。當我們在 2014 年 8 月來到奧卡萬戈三角洲時，我們即時分享了我們收集到的所有資料，包括環境讀數、水質資料、野生動物蹤跡、生物統計資料等等。所有的資料全在 [IntoTheOkavango.org ](http://intotheokavango.org/) 上公開，透過其 API，所有研究者、公民科學家、藝術家、學生等有興趣的人，都可以取得。


我們希望這些讚賞是來自這些人，能夠運用這份資訊所做的有趣的事。我們要開源我們整個考察。在未來幾年我們連同國家地理回到奧卡萬戈三角洲，這個做法仍會持續下去，已經有一些有趣的事正在發生。你可以在 twitter 上關注我們  [@intotheokavango](https://twitter.com/intotheokavango)、[@okavangowild](https://twitter.com/okavangowild)。


**問：Raspberry Pi 可以收集有關奧卡萬戈三角洲的水質資料。這些資料也公開嗎？如何使用？**


Raspberry Pi 與 Arduino 是更大計畫的其中一部分，我們稱之為量測三角洲心跳。該三角洲的環境品質，從根本上與當地野生動植物的健康息息相關，其中有些是非洲最壯觀的大型動物。目前我們沒有辦法監測環境健康，並且在有所異動時讓我們對生態衝擊有所理解。我是奧卡萬戈原野計畫的專案技術專家，專注在水源和空氣品質測試，與以開放平台 (如 Raspberry Pi 與 Arduino) 為基礎建造原型環境監測站。


在 2014 年的考察中，我們部署了三座量測水質的監測站並透過 SMS 將資料回傳給我們 (和網站)。這是用來測試在動態的濕地棲息地的部署情況。對於 2015 的考察，我將會在深入三角洲僅有少數人得以進入的地區，建構開放監測站的網狀網路 (mesh network)。由於我們的考察領袖 Steve Boyes 在該區域有個多年的野生動植物監測專案，因此波扎那 (Botswana) 政府給了我們特別的研究許可。他 2015 年走訪整片三角洲時，客製建構於他的 mokoro (傳統的獨木舟) 中的資料站，我們也將使用 Raspberry Pi 作為核心。和 2014 年收集的所有資料一樣，這份資料也將開放給所有人使用。


**問：你是名為 FishNET 的開放平台背後的主導者。此平台用來偵測並追蹤非法捕魚。可以多說一點有關此專案的內容嗎？**


FishNET 出自於史丹福大學時期初步的保育工作，並且進展為對我們收集和管理海洋資訊方法的重新想像。目前我們針對海洋發生的一切的監測方式，著重在對於軍方和固有封閉資訊管理方法論的過度依賴。這導致了無法發展沿海社群，以便在其水域發生過度捕撈和非法捕魚時加以紀錄 (這一現象導致了索馬利亞海岸海盜危機)。我的工作著重在提供適當的開放技術給非營利機構與沿海漁民使用，給予他們在有狀況時發聲交流的工具。透過確立低成本的觀測平台 (保育無人駕駛飛機、聲學傳感器、開源傳感器、衛星圖像等)，並提供更好方法來分享與管理已收集的資料 (使用行動技術、群眾外包、網際網路)，我們可以解放海洋資訊。我們的海洋正在存亡之際，它們需要我們用更聰明的方式照料它們。這些行動讓我被國家地理學會 (National Geographic Society) 提名為他們的 2013 新興探險家之一。


直到最近，這些行動還在不同領域中獨立試行。其中一個是 ultraVMS，一個基於 Arduino 的低成本開源船舶監測系統，可以讓合法漁民參與低成本的漁業管理。另一個和開放傳感器平台 (像在奧卡萬戈) 有關的專案，使用不同的傳感器 (聲音、光學等) 作為絆索，在受保護區域裡捕獲非法活動。我也透過 MPA Guardian 軟體與應用程式，運用群眾外包，試圖讓公民報告他們在海域看到的非法行為。


還有國家地理贊助的專案 SoarOcean，運用低成本的無人飛行器技術作為沿海監測之用。這些行動目前正在整合到一個即將公開的保育技術工具箱中。我正在打造網站和 github 存儲庫來收放這些資訊，一旦完工將在 [@conservify](https://twitter.com/conservify) 這個 twitter 帳號上公開。


**問：有其他國家地理探險者正在使用開源技術嗎？他們用在哪類型的專案上？**


有少數的探險者在他們的工作上使用到開源技術。資料藝術家，Jer Thorp，是參與奧卡萬戈原野計畫的探險家之一，也是進入奧卡萬戈 (Into The Okavango) 網站背後的天才。他在該網站上使用到的幾乎所有一切，都是開放源碼，包括 Leaflet.js、Jquery、Python、SQLLite、Tornado。Jer 在他身為 The Office for Creative Research 共同創辦人，以及紐約大學 ITP計劃兼任教授的工作上，也使用到一些開源軟硬體。


危機描繪者 (Crisis Mapper) 與人道主義創新專家 Patrick Meier，同樣也在其身為 Qatar 計算研究機構 (Qatar Computing Research Institute ) 社會創新主任 (Director of Social Innovation) 的工作上，專注於開放源碼上。他之前曾待過哈佛人道主義行動 (Harvard Humanitarian Initiative) 與 Ushahidi。他的團隊所開發的平台，像是 [MicroMappers](http://micromappers.com/) 與 [AIDR](http://irevolution.net/2013/10/01/aidr-artificial-intelligence-for-disaster-response/)，都是開放源碼。由於他的 [UAViators](http://uaviators.org/) 算是 SoarOcean 保育工作的人道主義版本，因此我們也密切地從事開源無人飛行器的使用。


**問：對你來說有哪些專案即將發生？你在未來專案使用開放源碼技術的可能性為何？**


由於今天漁業管理固有的封閉方式以及軍事強制，正是許多海洋遭到危機的根本原因，因此開放性是 Conservify (和最初的 FishNET) 背後行動的不可或缺的一部分。僅依賴專有產品與昂貴的監控方案，全球社群創造出一個除了最富有國家之外，其他人全都無從插手的環境。停止盜獵不應該只看最富有國家的意志行事。我們可以創造一個機會，藉由使用適當技術與開放源碼發展，為保育與可持續發展打造出更便宜的途徑。


以 Arduino 為基礎的硬體座落於 ultraVMS 與傳感器平台原型的核心。MPA Guardian 使用 Ushahidi 和 FrontlineSMS 所打造，接下來的 (主要是改進和擴展) 版本也遵循同樣的理念。SoarOcean 透過 DIY Drones 社群與所有相關硬體、工具、課程所建構。SoarOcean 所有計畫與文件，將從 2015 年 1 月起線上免費公開。開放性存在這些行動的 DNA 之中，缺乏這些框架，將難以延展與演進以滿足保育工作的需要。


**問：你最愛的開放硬體或開源解決方案為何？**


我喜愛開放硬體世界發生的一切。人們用 Arduino 與 Raspberry Pi 打造的事物實在出色。當給予足夠工具和機會自行解決問題時，人們的創造力從未停止為我帶來驚喜。看到我在 OpenROV 與 3DRobotics 的朋友，在開放開發框架下所做的事，讓我對開放保育的未來抱持希望。
___


##[自由專欄] 我的開源生活以及帶領我的導師##


謝良奇／翻譯


**本文翻譯自 opensource.com，原作者為 Rich Bowen：[https://opensource.com/life/14/12/mentoring-open-source-and-everywhere-else](https://opensource.com/life/14/12/mentoring-open-source-and-everywhere-else)**


我投入 Apache 網路伺服器的工作幾乎已經快 20 年。我寫過 9 本和 httpd 有關的書，參與發表的會議超過 50 個以上。我是 Apache 軟體基金會 (Apache Software Foundation) 的會員，我是理事會成員也是執行副總裁。我負責 ApacheCon，包括北美與歐洲，那是 Apache 軟體基金會的官方會議。


會達成上述的每一件事，都是因為某人鼓勵我，去做一些我打從心底知道自己做不到的事，並且在我做到時，為我喝采。


直接、刻意的指導，是我今日之所以站在此處的所有原因，不論是從專業上或個人意義來說。我所擁有的一切，確確實實全因為在過去 20 年指導過我的人們。在最近 5 年，我非常用心地指導其他人，將這份善意傳遞下去。這些人是否察覺到我所做的事，這一點並不重要。 我有特別的理由相信，這是件值得去做的事。


###為什麼？


我之所以認為指導是如此重要，有三個主要理由。


####擴大你的影響力


David Pitts 在 1997 年為 Sams Publishing 寫了一本跟 Red Hat Linux 有關的書。因為我在工作上有所涉獵的緣故，他請我撰寫跟 Perl 與 CGI 有關的章節。幸好這本書已經絕版了，我那時拙劣的文筆不會因此曝光，不過這卻引領我到另一件寫作工作，而現在我寫了幾本我很自豪的書。


1998 年我抱怨了一下 Apache 網路伺服器的文件。Jim Jagielski 當時鼓勵我停止抱怨，動手做一些事。我開始提交文件修補，2000 年 9 月我成為了第一位沒送過任何程式碼修補，卻獲得 Apache 專案提交權的人。


2000 年時當新成立基金會舉行頭一次 ApacheCon，Ken Coar 鼓勵我提出演講。我那時沒有什麼東西要講，也從未進行任何公開演說，但是他不斷地說服我，最後我提交了演講。這引領我到一個又一個演說工作，現在我的辦公室貼滿了各種會議的徽章，其中有些我甚至沒辦法辨識出來。


這些是我開源生涯中最重要的導師。還有許多其他的人，特別是 Casey West、Michael Schwern、Paul Dupree、Ken Rietz、Elizabeth Naramore、Wes Morgan、Sally Khudairi、Earle Bowen，以及許多其他在我送出這篇文章時，將後悔沒有提到的人。


我提到上述成就不是因為我很棒，而是因為這些人能夠，藉著他們在我生命中的慷慨投資，擴展他們的影響力，到他們未能觸及的領域。透過我，他們做到了一些事情，在他們因為時間、資源不夠，或僅因為沒有機會，而不能夠親自完成的地方。


####給你自己退出策略


有天，你會不想再做這一件事，你會想離開這個專案去嘗試別的東西。


最近有位睿智的同事告訴我，在重要工作上，你應該做的第一件事，就是找出可以取代你的人。有一天，你會從這個位置離開，除非你積極採取措施，確保你的影響力不會因為你的離開而中斷，不然你在這個位置上的大多數投入，都將因此付諸流水。


當然，有些人試圖讓自己成為不可取代的人。他們透過隱藏資訊，確保每件事都仰賴自己，積極嚇退任何可能取代他的人，達成他們的目的。有些人是刻意這麼做，有些人則出於本能，出於保障其位置的欲望。但是藉著積極尋找你的替代人選，你能創造出一種開放文化，身在其中的人不會試圖驅逐你，因此其他的目標也能因此達成。(公開紀錄你做的每件事是另一個重要部分，改天以另篇文章討論。)


透過指導你的替代人選，你會減少把所有事務攬在自己身上的壓力。你可以開始交付事項，花更多時間思考未來，更少時間修理那些壞掉而只有你能修的東西。


那麼當離開的時間來臨時，你可以放心繼任的人將會持續你的願景。


####留下真正重要的資產


開放源碼的是程式碼。程式碼會重構、分支、刪除。當你離開該專案，你的影響力會因為你的貢獻被逐漸稀釋而式微。你花在指導人們的時間會延續下去。它會延伸到其他專案、其他產業、其他世代。你投資在其他人身上的每一刻，都將一點點將你的影響力擴展到你個人無法直接觸及之地。


###誰？


如果你身邊有很多人圍繞，選擇對誰投入你的時間可是件難事。或者，你的團隊裡有少數幾個人會是可能的被指導者。無論如何，以下討論如何選擇該指導的人。


####找出有熱情的人


尋找那些工作到凌晨兩點，只為解決他們不必要解決的問題的人。尋找那些當所有人說事情已經解決後，仍然持續投入自己的方案的人。尋找那些在你耳邊不斷滔滔不絕你毫不關心的事，闡述其中微小的不重要細節，直到你想讓他們閉嘴的人。


這些人的熱情可以被疏導。這些人值得你花時間，因為當這份熱情被鎖定、被聚焦、被培育，將成為一股勢不可擋的力量。


####找出在陰影中工作的人


在任何專案中，總有人盡力要站在聚光燈之下，熱衷成為登上頭條的人。同時也有那些在幕後做事，確保一切順利進行的人。因為他們在乎的是事情順利進行，而非他們是否能獲得讚賞。


這些不平凡的人能成為最好的領袖，因為最好的領袖正如納爾遜曼德拉在其自傳漫漫自由路 (Long Walk to Freedom) 中所描述：


一位領袖就像牧羊人，他會待在羊群之後，讓最敏捷的走在最前方，於是其他的跟隨在後，沒有察覺他們一直受到後方引導。


只關心讓事情順利完成的人，能做這樣的領導者，因為，即使身為領袖，他們還是聚焦在結果，而非贏得讚譽。


####找出傑出的人


有些人顯然很傑出，但卻從事長期來看不怎麼重要的事。他們在玩遊戲，或把時間花在爭論授權法的細節，或在郵件列表上論戰。有時候他們會做一些除了他們以外，沒人會因此受惠的個人專案。朝著正確方向的一點點鼓勵，這份傑出就能轉向造福更大的一群人。很可能小小的個人專案可以成為更大的開源社群的一部分。又或許他們在個人網站寫很棒的文章與教學，在受到鼓勵後可以讓他們的能力，成為上游文件專案的一部分，讓更多人因此獲益。


####其他每一個人


是的，其他每一個人。因為你的錯誤選擇，你投資的時間和精力可能得不到什麼效果。而且你會錯失那些能從你的投入中獲益的人。但是在最後，你投資的人越多，其中出現能夠回報你努力的人的機會也會越高。


###怎麼做？


指導是很簡單的事，每個人都能做。以下這些可以讓你推別人一把，讓他們體會自己的潛力。


####指派特殊任務


在那些試著進入開源圈子裡的人之中，你最常會聽到的就是，我想做一些事，但我不知道從哪裡開始。你可以給他們的最好答案就是一件特殊任務。


OpenHatch 的人長期以來鼓勵專案要明確標示出易解的臭蟲，並且故意地留著它們不解，讓新手有入手的機會。


我會刻意把會議計畫打散成小任務，並在 Apache 社群發展 (Apache Community Development) 郵件列表上尋找接手的人。立即的效益是，有人幫我做事，長期的效益則是，他們會更願意協助下一件任務，以及下一次活動。回顧一下上面有關培養替代人選的那一節。這就是找到這些人的方法。


這一點很重要，儘管要在你喜歡做的事上抽手，把機會讓給別人的確很困難。


####鼓勵他們開口


鼓勵人們向活動提出演講。這是個參與專案的好方式，因為會給關心專案的人立即的能見度。從鼓勵他們在當地聚會或閃電秀 (lightning talk) 上做 5 分鐘的發表。


順帶一提，ApacheCon 正在[徵求提案](http://events.linuxfoundation.org//events/apachecon-north-america/program/cfp)。


我也發現到，對我而言學習某個主題最好的方式，就是在活動上進行演講。這讓我深入了解，思考會被問到哪些問題，並學習如何解決這些問題，好讓我不會在台上出糗。


還有，給一些特定的建議是不錯的想法。如果你覺得某人會是好講者，但他們說不知道要說些什麼時，準備好建議一個主題甚至是摘要。有些人就是需要一點額外的助力，好讓他們上台，給予某些特定方向也許是他們所需要的。如果他們接受了你的建議，確認你會在他們的演講中出席，在他們說笑話時哈哈大笑，並且在他們回答不了問題時打斷提問。之後，如果他們做到的，鼓勵他們把同樣的演講改進後，提交到另一個活動上。對於如何改進他們的演講，提出特定的建議。


####鼓勵


還有，當然，就是鼓勵。


如果你看一下任何一個主要開源專案的統計數據，你會發現少數人貢獻了大多數的程式碼，還有許多人貢獻了一或兩次之後，再也沒有回來。許多情況是，因為他們遇到一個問題，然後加以修正。其他情況則是因為，他們的貢獻沒有被任何人認可。


一句簡單的，感謝你讓世界更好，也許就能鼓勵某個人持續第二次修補，接著第三次，一百次。


這是最簡單的，也是迄今為止最重要的，社群，不管是開放源碼或其他，裡面的任何一個成員，都能鼓勵社群成長。認可每個人的貢獻。說句謝謝你。在你的週報裡指導新進貢獻者，就像 Stefano 做的一樣。給他們寄一封個人郵件，感謝他們並鼓勵他們再次貢獻。


###何時？


何時你應該進行指導？當然，就是現在。


不要等到你位居你的組織頂點時，或掌握權力時。永遠有人會因為你的指導而獲益，即使他們比你年長，或經驗比你豐富。你一定知道某些可以傳遞下去的事物。


投資其他人，開始擴大你對世界的影響力，永遠不會太早 (或太遲)。
___


##[源碼新聞] 新手爸媽不用慌！雲科大「嬰語翻譯機」貼近寶貝的心##


四貓／文


每個小嬰兒都是父母的寶貝，父母都想給他們最好的照顧！但是新手爸媽常因為小嬰兒的嚎啕大哭而手忙腳亂、不知所措！是否你也遇過寶寶大哭，但是泡了牛奶卻不喝、檢查尿布也沒有濕的情況呢？為了紓解新手爸媽的焦慮，雲林科技大學開發了[「嬰語翻譯機」](https://play.google.com/store/apps/details?id=com.infantcry&hl=zh-TW)app，幫助爸媽讀懂寶貝的心。更厲害的是，開發此 app 的團隊參加創業比賽在眾多團隊中脫穎而出，成立了「宜默瑞科技」。今天我們採訪到主持醫學影像處理實驗室，同時也是產學與智財育成營運中心研發長的張傳育教授，請他分享開發「嬰語翻譯機」app 的過程，還有帶領同學投入創業的經驗。現在先來看看「嬰語翻譯機」有什麼神奇之處吧！


###這是什麼巫術？辨識率高達 92%！###


嬰語翻譯的操作方式非常直覺，當小寶寶哭泣的時候，爸爸媽媽只要拿出手機打開 app，錄製小寶寶的哭聲，app 會立即將哭聲與資料庫進行比對，判斷出小寶寶哭泣的原因為何，辨識率高達 92%，爸媽再也不用擔心找不到寶貝不開心的原因！


問起張教授開發「嬰語翻譯機」的契機為何，他說醫學影像實驗室一直都在發展情緒相關的辨識技術，情緒的表現是有許多種呈現方法，例如表情、聲音等等，目前應用情緒相關辨識技術大多皆是應用在成人上。在開發「嬰語翻譯機」之前，他們進行的專案是以自由軟體開發居家照護系統，照護目標以獨居老人為對象，用了一個異常聲音偵測的技術，希望該系統可以即時偵測、即時反應，隨時覺察獨居老人的需求。但是成年人是會四處移動的，異常聲音的偵測系統會需要架設大量的麥克風陣列，在實際應用情況上就有一些限制。不太可能在家中四處裝設麥克風，但如果收音不佳又會影響到偵測的判斷，雖然近來穿戴式裝置十分熱門，也可能成為照護的一端，但接觸性的裝置較容易造成年長者的不適。他們在一次的因緣際會下，和台大雲林分院的陳思達醫師交流後，了解到嬰兒表達情緒的方式是哭聲，也是唯一的溝通方式，因此將辨識技術延伸到嬰兒照護上，因為嬰兒的移動範圍十分有限，需求卻同樣需要獲得立即的解決。


相信一定有讀者疑惑，小朋友的哭聲可能有各種不同的變化，但是進行語音情緒辨識的相關研究並不算少數，為什麼獨獨「嬰語翻譯機」的辨識率可以這麼高？為了解答讀者的疑惑，我們當然跟張教授打聽了其中的祕密！首先，為什麼嬰語翻譯機這麼神奇可以識別小寶寶的情緒呢？這是因為他們與台大醫院（雲林分院）合作，在嬰兒室中架設攝影機，錄製嬰兒的哭聲，每天把資料從醫院端送回到實驗室，而且每一筆哭聲都有經過護理人員的專業判斷，因此可以確知嬰兒的需求為何。光是建立這龐大的聲音資料庫就耗時超過兩年，收集了十萬筆的資料以上的資料，再利用大數據與機器學習的方式，找出不同哭聲的特徵，經過多次分析與測試，再加入團隊開發的情緒辨識技術，才有辦法達到這麼高的辨識率。他們將已經經過分析的哭聲當作模型，有新的哭聲進來，就立刻進行比對，而且更棒的是，即使一開始自己寶貝的哭聲被錯誤判斷，但模型會自我學習、自動修正，隨著使用，機器會有學習的功能，自動進化成專屬於寶貝的模型，不但能提昇辨識率，未來團隊還計畫發展出獨特的個人化功能。另外我們也好奇，在開發的過程中，團隊有沒有遇過什麼困難？蕭同學則回覆說，因為嬰兒的哭聲和小動物的叫聲有相似的地方，因此他們會關心如何區別嬰兒哭聲和動物的叫聲，並把不屬於嬰兒哭聲的聲音訊號排除掉，以免造成誤判。更進一步，也希望可以結合表情的相關技術，讓整個照護系統更加全面。
    
###有了技術，下一步呢？投入創業吧！###
    
眾所期待的「嬰語翻譯機」app 在年底就會上架到 Android 和 iOs 兩種平台，而技術部份目前也有許多廠商向他們接洽合作，發展相關的應用，例如說，結合 IP CAM 成為嬰兒監視器，能將畫面傳到手機端，即使爸媽不在房間也可以隨時關心寶寶的狀況，如果寶寶哭了，更可以即時判斷寶寶的需求，在回到房間的過程中可預做準備，立刻舒緩新生兒照護的壓力。


在研發有成之後，他們開始思考這個團隊要怎麼延續下去。許多專案常在學長姐畢業之後，就面臨人員重新洗牌的問題，因此要怎麼讓團隊時時維持在最佳的營運狀態上就成為他們思考的課題。最後他們決定挑戰創業，將短暫的研發能量轉成可以永續經營的模式，但踏出第一步通常都是最艱難的。後來他們報名了科技部「創新創業激勵計劃」的競賽，這是科技部為了將傑出研究成果轉化為產業能量的一個計畫，第一階段會從 249 個隊伍中選出 40 名，接著參加創業宏圖營，與許多的業師及矽谷業師給予許多不同的意見，從這些意見中探討、檢討目前所缺乏及不足之處。經由改正缺乏及不足之處，順利的從 40 個隊伍中脫穎而出進入下一個階段，並登記公司成立。下一個階段他們與 20 個隊伍一同參加創新實踐營，相互檢討、競爭，與業師及矽谷業師相互討論及不同看法中，思考、改正營運上可能造成的錯誤及糾紛。從各個業師吸收不少創業經驗，以及經過了兩個營隊的洗禮及檢討，他們確信了公司營運的可行性及未來，同時公司也通過了審核，過關斬將地從20個隊伍中再次晉升，使信心更加堅定。最後參加媒合會，與各個投資者談論中也發現了一些不同的看法與想法。經過這麼多有經驗者分享經驗，得知成立公司需要這麼多的前置作業及可能造成的錯誤，避免往錯誤的道路前進。張教授覺得，做學術研究和投入創業的思維真的很不一樣，他們也是一邊做、一邊學，在與不同人的對話過程中不斷吸收各方經驗，並在過程中累積資源。張教授建議有心投入研發創業的同學，光是產品好還不夠，還要學會怎麼精準的「傳達」自己產品的優點。最後張教授也特別感謝了科技部提供的支持，讓他們能夠站在巨人的肩膀上前進!


**應用程式下載**
[Google play: 嬰語翻譯機](https://play.google.com/store/apps/details?id=com.infantcry&hl=zh-TW)
___


##[源碼新聞] Google 雲端硬碟支援開放格式##


四貓／編譯


![圖片：Google Drive 在 G+ 上發佈好消息](http://www.openfoundry.org/images/150127/ODF-Import.gif)
 
在 2014 年的最後一個月，Google 做了一個令人興奮的[宣佈](https://plus.google.com/+GoogleDrive/posts/f8icit6jYJK)：那就是 Google 雲端硬碟現在已經能支援開放文件格式 (OpneDocument Format, 簡稱 ODF)了！現在 Google Drive 中，文件支援 .odt 格式、試算表支援 .ods，還有簡報支援 .odp 格式，雖然開放文件格式並不只這幾種，但在辦公室文書處理中，這應該是應用範圍最廣的三項。  
 
[開放文件格式](http://en.wikipedia.org/wiki/OpenDocument)是一種基於 XML 的文件檔案格式，由於格式開放，因此不會受限於特定的廠商或是平台，創造公平、開放的環境，以避免產生「[鴉片軟體](http://user.frdm.info/ckhung/a/c020.php)」的情況。鴉片軟體是洪朝貴老師以輕鬆詼諧的筆調，暗喻軟體廠商利用封閉的格式讓使用者無法將內容攜帶至其他軟體使用，造成對特定軟體產生依賴進而壟斷市場的一種方式。雖然專有軟體有一些獨特的功能，但有可能不利於資訊的交換與長期保存讀取。  
 
致力於推動開放文件格式的 [ODF 聯盟 (The OpenDocument Format Alliance)](http://odfalliance.org/) 在 2006 年的時候成立，當年 Google 就已經加入該聯盟，但將相關格式上傳至 Google 雲端硬碟時，雖然可以下載，但卻無法像 Microsoft Office 的文件一樣進行線上預覽和編輯，用 Google 文件編輯的檔案亦無法匯出成 ODF 格式，一直到 2014 年 12 月這次的宣佈，才讓習慣使用開放文件格式的使用者歡聲叫好。    
 
世界各國政府逐漸重視開放、開源的精神，而陸續將開源解決方案納入政府部門的標準，全世界有超過 20 個國家的公務單位或地方政府採用開放文件作為標準格式，英國也在 2014 年公告全國採用，大幅節約政府採購軟體的經費，而我國也在積極推動開放文件格式的導入。Google 此次的格式支援，相信是積極跨出開放的重要一步，但是否會有更大的進展，值得大家拭目以待。    
 
**相關連結：**  
 
1. [ODF 將成為馬來西亞國家標準](http://www.openfoundry.org/index.php?option=com_content&task=view&id=395&Itemid=56)


2. [開放的里程碑：英國政府文件採用開放標準！](http://www.openfoundry.org/tw/foss-news/9287-enggov-open-standard)
 
3. [葡萄牙政府使用 ODF 格式作為唯一的文件編輯格式](http://www.openfoundry.org/tw/foss-news/8868-portugueseodf)


4. [推動 ODF 為政府文件標準格式會議記錄](https://www.loomio.org/d/cJpDHSoh/10-23-odf-cns15251?locale=ro)
 
5. [Google 加入開放文件格式聯盟](http://www.ithome.com.tw/node/38265)


6. [2012 文件自由日](http://www.openfoundry.org/tw/news/8645?task=view)
___

##[源碼新聞] 2014 年最棒的開放硬體回顧##

自由軟體鑄造場電子報／翻譯

**本文翻譯自 opensource.com，原作者為 Luis Ibáñez ：http://opensource.com/education/14/12/year-review-open-hardware**

[開放硬體](http://opensource.com/resources/what-open-hardware)是開放運動的實體基礎。透過了解、設計、製造、商業化，並採用開放的硬體，我們建立了一個運作良好且自給自足的社群基礎。而在今年，開放硬體有非常多的動態。

Opensource.com 發布了[一套新的資源](https://opensource.com/community/14/8/what-is-open-hardware-new-resource)，包括[一個可以自由閱讀的定義](http://opensource.com/resources/what-open-hardware)。今年三月，我們還玩了一個和開放硬體相關的各種主題的文章的[小遊戲](https://opensource.com/life/14/2/open-hardware-week)，持續整整一個星期。編輯人員在 "Open Hardware Day" 這一天，介紹 3D 印表機、Arduinos、quadcopters，渡過了有趣的一天。而開放軟體的新聞仍然在不同領域遍地開花。

以下就是今年的一些亮點。

###教育

[Limor Fried](http://opensource.com/users/ladyada) 持續地分享了 Adafruit 這個開源硬體公司的[新聞](https://opensource.com/life/14/1/open-hardware-ask-an-engineer)，為教育新世代的 makers 和 hackers 展開了新的一年。她也關注 "Maker Faire"、"The Open Source Hardware Summit" 這樣的大型活動，以及 Adafruit 舉辦的這些活動："[Ask an Engineer](http://www.adafruit.com/ask)"、"[Show and Tell](https://www.youtube.com/playlist?list=PL7E1FAA9E63A32FDC)"。

[Russell Dickenson](https://opensource.com/users/rdickens) 採訪了 [Jezra Johnson Lickter](http://www.jezra.net/)如何利用便宜的電子產品和大量的資訊來回復失傳的藝術作品。 Jezra 樂於這些事情，能夠專注於好奇心，釋放創造力，讓這些作品比以往更好。

[Jen Wike Huger](http://opensource.com/users/jen-wike) 採訪了 [ChickTech](http://chicktech.org/) 的 [Jennifer Davidson](http://www.oscon.com/oscon2014/public/schedule/speaker/131890)，關於他們為何想要幫助更多女孩進入技術工程領域的初衷。她特別為高中的女孩子們分享了以前唸大學的經驗，致力於開源，開放硬體的教育專案，類似在 OSCON 舉辦的 OpenHeARTware [工作坊](http://www.oscon.com/oscon2014/public/schedule/detail/34678)。

###自造者 (Makers)
[Ruth Suehle](https://opensource.com/users/suehle) 寫了 [Mark Hatch](https://twitter.com/markhatch) 所著的 [Maker Movement Manifesto](http://www.amazon.com/gp/product/0071821120/ref=as_li_ss_tl?ie=UTF8&camp=1789&creative=390957&creativeASIN=0071821120&linkCode=as2&tag=hobbyhobby-20) 一書的介紹，這本書寫到了世界各地的 maker 改變新產品構思、設計、製作原型方式的經驗。重要的是，這本書主要是要呼籲我們參與具民主經驗的產品製程。

這篇文章反而給了 [Chris Anderson](https://en.wikipedia.org/wiki/Chris_Anderson_(writer)) 靈感，促成他寫了這本書：[Makers: The New Industrial Revolution](http://www.amazon.com/Makers-The-New-Industrial-Revolution/dp/0307720950/ref=pd_sim_b_5)，回顧著 maker 運動的崛起，正有如第二次工業革命，成立一個繁榮的商業公司，與 DIY 社群的價值是一樣的。

[Maker Space](http://opensource.com/life/14/4/public-library-3d-printing) 這篇文章介紹了 Maker 運動的民主化，文中提到有間圖書館，是由志願者提供 3D 印表機和掃描器的教學，讓當地的民眾自由使用和學習。

今年在 Maker Space 中最顯著的事件，莫過於 [e-NABLE 社群](http://enablingthefuture.org/)的誕生， Jen Wike Huger 寫的 [這篇文章](https://opensource.com/life/14/3/interview-jen-owen-enable)訪問到了 Jen Owen，超過五百人的 E-NABLE 社群的核心人物。e-NABLE [社群](https://plus.google.com/u/0/communities/102497715636887179986)的志願者在網路上共同設計、製造和發布給兒童使用的 3D 列印義肢。而 [Peregrine Hawthorn](http://opensource.com/users/thegentlemanfaun) 分享了[這篇文章](https://opensource.com/life/14/3/3D-printed-hand-enable)說明他是如何在有超過 4,600 個工程師參與的 Intel 發表會上獲得滿堂喝采。這些都是科技社群的貢獻者推動社會變革最好的實例。

###3D 列印

在 3D 列印的領域仍舊有快速的成長。年初的時候我們[介紹了 Printrbot Simple 3D Printer](http://opensource.com/education/14/1/review-printrbot-simple-kit) 這台便宜且只要花數小時即可組裝完成並印製出成品的印表機。而在接近 2015 年的時候，我們也[學習](http://opensource.com/life/14/9/weekly-news-roundup-october-3)到了如何使用 [Arduino 打進 3D 列印的市場](http://arstechnica.com/information-technology/2014/09/arduino-to-sell-3d-printer-800-in-kit-form-or-1000-pre-assembled/)。

堅守自由開源的原則需要很大的奉獻和努力。[Ginny Skalski](https://opensource.com/users/ginny-skalski) 在專訪 [Aleph Objects](https://www.alephobjects.com/) 的 Jeff Moe 的[報導](https://opensource.com/life/14/3/interview-Jeff-Moe-Aleph-Objects)中，提到他們在 [LulzBot 印表機](https://www.lulzbot.com/printers)的發展，拒絕將產品專利化，轉而擁抱快速、創新的開源方式，不斷地發布他們開發設計的產品，分享給大眾，而且他們也很歡迎[社群提出貢獻](https://www.lulzbot.com/community) 。該公司還連續兩年提供了Opensource.com [假日贈品](https://opensource.com/2014-gift-guide-giveaway-announcement)的贏家一台[Lulzbot Taz 4 3D 印表機](https://www.lulzbot.com/products/lulzbot-taz-4-3d-printer)！

###電子產品

在一般的電子產品方面，我們看到 [Bryn Reeves](https://opensource.com/users/bmr) 的[開源 DIY 示波器](https://opensource.com/life/14/6/diy-open-source-oscilloscope)。他把 [OLPC 筆記型電腦](http://laptop.org/en/laptop/hardware/index.shtml)結合到一個軟體是以 GPL 授權條款來授權的[示波器](http://www.syscompdesign.com/CGR-101_ep_41-1.html)中，這讓 Bryn 得以快速地透過他所熟悉的 Vim 編輯器來將程式改寫成他所需要的功能。

[Lauren Egts](http://opensource.com/users/laurenegts) 採訪了 [Ken Burns](http://opensource.com/business/14/1/tinycircuits)，[TinyCircuits](https://tiny-circuits.com/) 的創始人。TinyCircuits 最初是透過 [Kickstarter 集資網站](https://www.kickstarter.com/projects/kenburns/tinyduino-the-tiny-arduino-compatible-platform-w-s)起頭的公司，TinyCircuits 生產與 Arduino 的平台相容的小型模組化組件，像是 [TinyDuino](https://tiny-circuits.com/products/tiny-duino.html)。Lauren 後來也接受其父 Dave Egts 和Gunnar Hellekson 的[技術播客節目](https://atechnologyjobisnoexcuse.com/2014/03/48-tiny-circuits-big-factory/)的[訪問](https://opensource.com/users/dgshow)。

我們也了解了 [LittleBits](https://opensource.com/life/14/3/six-open-hardware-littlebits-projects)，他們製造小型模組化的元件，讓我們可以很輕鬆地組合想要的電子產品。LittleBits 公開他們的設計，讓大家可以取得，並且鼓勵願意熱心分享自己的專案的社群貢獻者們。

[JR](http://opensource.com/users/jr) 分享他設計的 [pedalSHIELD](http://opensource.com/life/14/3/arduino-open-source-guitar-petal)，一個可以自行編寫程式的開放源碼和開放硬體的吉他踏板，專門為了吉他手、hackers 和工程師所製作的。它是使用開源工具 [KiCad](https://en.wikipedia.org/wiki/KiCad) 和開放硬體 Arduino 的平台所設計出來的。

###Arduino

Michael Harrison 回顧了 [Arduino for Beginners](http://opensource.com/life/14/3/build-fun-easy-electronics-projects-arduino-beginners) 這本教初學者如何使用 Arduino 微控制器製作有趣的小玩意的入門書。

我們介紹了 [Adafruit](http://www.adafruit.com/products/68) 推出的 [Arduino 的入門包](http://opensource.com/education/14/3/arduino-starter-pack) ，並從非常完整的 [Arduino 實例](http://arduino.cc/en/Tutorial/HomePage)中分享我們的經驗。我們非常推薦想進入 Arduino 世界的人參考。

[Jonathan Muckell](http://opensource.com/users/jmuckell) 分享了他的經驗，他準備在他的一門 [Physical computing 的大學課程](http://opensource.com/education/14/3/physical-computing-class-suny)中使用開放的軟體和硬體。課程結合 Arduinos，樹莓派 (Raspberry Pi) 和 3D 印表機，引起了學生們把軟體程式碼應用到硬體世界上的興趣。

[Jon Davis](http://opensource.com/users/jonpauldavis) 告訴我們，他的[高中班級](http://opensource.com/life/14/9/tools-scientific-discovery-open-hardware)，讓學生們使用 Arduino 電路板得以製造出一些科學設備。學生們從 Arduino 長期的公開貢獻獲得豐富的資源。Jon 明智地說：「教學即是開源」(Teaching is open source) 。

[Hugo Silva](http://opensource.com/users/hugoslv) 分享了在[幾個很酷的專案](http://opensource.com/life/14/11/bitalino-open-hardware-device)中使用的 BITalino 感應器。[BITalino](http://www.kickstarter.com/projects/bitalino/bitalino-revolution) 是一種低成本的硬體和軟體工具包，用途是讀取身體的信號。有了它，就可以讀取肌肉，心臟和神經信號，並對其進行處理以控制人機互動裝置，或者監看身體的機能。Hugo 分享了可以協助漸凍 (ALS) 患者調整控制器和輔助設備的應用程式。

###樹莓派 (Raspberry Pi)

這是樹莓派團隊偉大的一年！樹莓派 [B+ 主機板發布](http://opensource.com/life/14/10/reviewing-new-raspberry-pi-b-board)了，之後也回顧了[樹莓派 A+](http://opensource.com/education/14/12/open-hardware-raspberry-pi-A-plus) 。新的版本對於節電和擴充性有很大的改進，而且 B+ 還比 A+ 便宜 5 美金。這些新產品的加入帶給使用者們更多的選擇。

Ruth Suehle 分享了她最喜歡的[樹莓派專案](https://opensource.com/life/14/3/favorite-raspberry-pi-projects)，包括多種用途不同的專案：R2D2 機器人的聲音模組、家庭自動化設備、天空照相機、FM 收音機，以及在家釀造酒... 等專案。

[Lauren Egts](https://opensource.com/users/laurenegts) 大膽地應用軟體和硬體的結合，使用樹莓派當做[燈光控制器](https://opensource.com/life/14/8/how-i-lit-jugglers-performance-my-raspberry-pi)，加上 [ArchLinux](http://archlinuxarm.org/platforms/armv6/raspberry-pi)、[Pibrella](http://pibrella.com/)，來控制一組特技表演的 LED。[這段影片](https://www.youtube.com/watch?v=yvUND4iH7Oo)非常值得一看！（影片 3:40 處）

####結論

2014 年的開放硬體運動是充滿活力的，從教育到醫療，讓大家參與了許多有趣的專案，也把開源社群的關係聯繫了起來。結合了的社群是前途無量的。
___






#關於本報#
  
◎ 主編︰洪華超
 
◎ 法律專欄編輯︰葛冬梅


◎ 執行編輯：洪立穎 
  
◎ 外稿編譯︰林誠夏、黃郁文、黃湘婷、謝良奇
 
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