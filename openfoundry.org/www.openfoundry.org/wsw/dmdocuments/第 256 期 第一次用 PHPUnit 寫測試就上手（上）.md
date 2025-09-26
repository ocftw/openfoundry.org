___
 
□■□ 自由軟體鑄造場電子報第 256 期 | 2014/12/30 □■□
___
 
◎ 本期主題︰第一次用 PHPUnit 寫測試就上手（上）
 
◎ 訂閱網址︰[http://www.openfoundry.org/tw/news/](http://www.openfoundry.org/tw/news/)
 
◎ 下次發報時間︰2015/1/13
 
#本期內容#
___


##[技術專欄] 第一次用 PHPUnit 寫測試就上手（上）##

黃儀銘／文

### 一、什麼是測試？測試的重要性？

開發者在撰寫程式的時候，程式不大可能會沒有問題，所以通常就需要驗證程式的執行是不是符合預期。測試程式能用來驗證程式程式的運作是不是正常的，並發現程式中的錯誤，以增加軟體品質。

下面是一個活動報名的系統：

![測試活動報名系統](http://www.openfoundry.org/images/141230/PHP-1_resized.jpg)

這一個活動報名系統主要提供使用者報名活動，在報名活動內還有一些子功能，像是「限制活動報名人數」，如果是這一個子功能，該如何測試呢？

直覺想到可能就需要有 20 個以上的使用者，然後讓這個些使用者分別來報名活動，如果沒超過限制的人數，使用者就能繼續報名，反之，超過了限制人數的話，使用者就無法繼續報名了。說到這裡，會覺得這是什麼測試！

先分析一下，照上面的方法進行測試會有什麼問題：

1. **測試案例一多，會花太多時間**

   *  這時候，如果再增加報名截止日期的測試，這樣又需要再對報名功能測試一次。
  
2. **改了程式碼之後，需要再做一次測試**

   *  日後維護時，會需要再次修改程式碼，但是，改了程式碼之後，該如何驗證修改後的程式運作上是沒問題的？所以，可能又要再次從頭做一次測試。

3. **與其他程式混在一起測試**

   *  要執行報名功能的程式碼，要透過 view 的程式去呼叫。但是，這樣做測試的時候，如果測試失敗，就必須花時間去找出是報名的程式出問題，還是 view 程式。

那該如何解決這些問題呢？針對開發者來說，需要一個可以自動化、重複的、獨立的測試。

### 二、單元測試

單元測試是分別對程式的單元，例如：函示 (function)、方法 (method)，進行測試，測試時會判斷單元的執行結果是不是有符合預期。

![Event &amp; EventTest](http://www.openfoundry.org/images/141230/PHP-2_resized.jpg)

從上圖可以看到，撰寫了`Event` 類別提供了兩個方法，`reserve()`、`unreserve()`，也就是目標程式。
接著透過 `EventTest` 的兩個測試案例，`testReserve()` 與 `testUnreserve()` 分別來對 `Event` 類別中的兩個類別方法執行測試，測試的結果會在測試案例中驗證，如果驗證通過，表示測試就成功了！

#### 單元測試能協助開發者什麼？

1. **確保單元的執行結果**
*  這一點蠻覺得就可以了解到，單元測試能協助驗證目標程式的執行結果。

2. **儘早發現程式中的錯誤**
*  因為單元測試是在開發的時候就進行的，所以能發現程式中存在的問題。
*  沒使用單元測試的時候，寫好了一份程式，但是，這份程式碼需要與其他程式碼整合才有辦法運作。所以就需要等整個程式開發的差不多的時候，才能對程式進行測試，在測試出現問題的時候，會花許多時間來釐清是那一份程式導致的問題。
*  如果使用單元測試，就能在寫好了一份程式之後進行單元測試，而不用等到之後才對程式測試。

3. **修改程式，更加有信心**

*  程式寫好了，需要維護、修 bug，如果修改了程式碼後，能確定修改後的程式與之前的正常運作是一樣的嗎？單元測試能協助修改程式後，對程式執行測試，如果測試過了，表示程式的運作是正常的，測試失敗的話，可能需要再回頭修改程式。

4. **測試即文件**

*  在撰寫測試的時候，會對單元所提供的功能進行驗證，所以，除了能透過程式來瞭解單元的運作外，也能用所撰寫的單元測試來知道，被測試的單元有哪些運作及功能。
*  在開發的時候，會撰寫一些文件來作為軟體的文件，在實際上，有時候那些文件並不一定會隨著程式變更而修改，到後來會變成之前所做的文件跟程式是不同步的。
*  因為，單元測試的程式會對目標程式進行驗證，所以，測試能避免掉傳統文件所造成的程式與文件不同步的問題。

### 三、簡介 PHPUnit

PHPUnit 是 PHP 程式語言中最常見的單元測試 (unit testing) 框架，PHPUnit 是參考 xUnit 架構利用 PHP 實作出來。

為什麼要使用 PHPUnit 來測試呢？雖然，要做單元測試可以自己寫程式來測試， 但是 PHPUnit 提供了一些測試時常用的 library 及解決測試時會遇到問題的方法，所以我們會使用 PHPUnit 來做單元測試。

### 四、撰寫 PHPUnit 測試

#### 說明

在進入正題前，先說明範例程式，之後的程式，會利用一個小專案，活動報名系統來示範撰寫單元測試。
  
活動報名系統主要的功能是提供報名及取消報名。

示範流程：
1. 撰寫目標程式的介面及實作
2. 撰寫單元測試程式碼
3. 執行測試
4. 如果測試失敗，回頭看是實作還是測試程式碼的問題

活動報名系統目錄結構：
```
. 
|-- src     
|  '-- PHPUnitEventDemo
|     '-- Event.php
|     '-- User.php
|     
|-- tests        
    '-- EventTest.php
```

上面是範例程式的目錄架構

- PHPUnitEventDemo - 底下都是目標程式碼
- Event.php - Event 類別
- User.php - User 類別
- tests - 單元測試目錄
 - EventTest.php - 測試 Event 類別的單元測試

#### 1. Assertions（斷言）

Assertions 為 PHPUnit 的主要功能，用來驗證單元的執行結果是不是預期值。

小範例：
```php
assertTrue(true);   # SUCCESSFUL
assertEquals('orz', 'oxz', 'The string is not equal with orz');   #UNSUCCESSFUL
assertCount(1, array('Monday'));   # SUCCESSFUL
assertContains('PHP', array('PHP', 'Java', 'Ruby'));   # SUCCESSFUL
```

- `assertTrue()`：判斷實際值是否為 `true`。
- `assertEquals()`：預期值是 `orz`，實際值是 `oxz`，因為兩個值不相等，所以這一個斷言失敗，會顯示 `The string is not equal with orz` 的字串。
- `assertCount()`：預期陣列大小為 1。
- `assertContains()`：預期陣列內有一個 `PHP` 字串的元素存在。

從上面的後三個 assertions 可以發現，預期值都是在第一個參數，而後面則是實際值。

**● 測試 1 - 提供使用者報名**

預期結果：

1. 符合的報名人數。
2. 報名的名單中有已經報名的使用者。

接下來開始撰寫 `User` 及 `Event` 類別。

**src/PHPUnitEventDemo/User.php**
```
<?php
namespace PHPUnitEventDemo;

class User
{
   public $id;
   public $name;
   public $email;

   public function __construct($id, $name, $email)
   {
       $this->id = $id;
       $this->name = $name;
       $this->email = $email;
   }
}
```
`User` 類別很單純，主要就是建立 `User` 物件用。

**src/PHPUnitEventDemo/Event.php**
```php
<?php
namespace PHPUnitEventDemo;

class Event
{
   public $id;
   public $name;
   public $start_date;
   public $end_date;
   public $deadline;
   public $attendee_limit;
   public $attendees = array();

   public function __construct($id, $name, $start_date, 
       $end_date, $deadline, $attendee_limit)
   {
       $this->id = $id;
       $this->name = $name;
       $this->start_date = $start_date;
       $this->end_date = $end_date;
       $this->deadline = $deadline;
       $this->attendee_limit = $attendee_limit;
   }

   public function reserve($user)
   {
       // 使用者報名
       $this->attendees[$user->id] = $user;
   }

   public function getAttendeeNumber()
   {
       return sizeof($this->attendees);
   }
}
```
`Event` 類別有兩個要說明的變數，`$attendee_limit`、`$attendees`：

- `$attendee_limit` : 活動限制的報名人數。
- `$attendees` : 陣列型態，每一個元素為一個 `User` 物件。

另外 `Event` 類別內還主有兩個方法，`reserve()` 及 `getAttendeeNumber()`： 

- `reserve()` : 提供使用者報名，將報名的使用者存在陣列中，陣列的索引值就是使用者的 id。
- `getAttendeeNumber()` : 取得目前報名人數。

最後，我們需要撰寫 `EventTest` 來測試 `Event` 的單元結果是不是符合預期。

**tests/EventTest.php**
```php
<?php

class EventTest extends PHPUnit_Framework_TestCase
{
   public function testReserve()
   {
       // 測試活動報名功能
       $eventId = 1; 
       $eventName = '活動1';
       $eventStartDate = '2014-12-24 18:00:00';
       $eventEndDate = '2014-12-24 20:00:00';
       $eventDeadline = '2014-12-23 23:59:59';
       $eventAttendeeLimit = 10;
       $event = new \PHPUnitEventDemo\Event($eventId, 
           $eventName, $eventStartDate, $eventEndDate, 
           $eventDeadline, $eventAttendeeLimit);
       
       $userId = 1;
       $userName = 'User1';
       $userEmail = 'user1@openfoundry.org';
       $user = new \PHPUnitEventDemo\User($userId, $userName, $userEmail);
       // 使用者報名活動
       $event->reserve($user);
       
       $expectedNumber = 1;
       // 預期報名人數
       $this->assertEquals($expectedNumber, $event->getAttendeeNumber());
       // 報名清單中有已經報名的人
       $this->assertContains($user, $event->attendees);
   }
}
```

- `EventTest` 會繼承了 PHPUnit 的類別 `PHPUnit_Framework_TestCase。`
- `EventTest` 內有一個測試案例 `testReserve()`。
- `testReserve()` 內主要會建立一個 `User` 及 `Event` 物件，使用者再去報名一個活動，所以活動已經有一個人報名了。
- 接下來的斷言，`assertEquals()` 會預期活動報名人數有 1 個人。
- `assertContains()` 預期在活動報名清單內，已經有已報名的使用者。

**執行測試**
```sh
$ phpunit --bootstrap vendor/autoload.php tests/EventTest
PHPUnit 4.4.0 by Sebastian Bergmann.

.

Time: 56 ms, Memory: 3.25Mb

OK (1 test, 2 assertions)
```

. 表示測試了一個測試案例，且通過測試。

**● 測試 2 - 提供使用者取消報名**

活動除了可以讓使用者報名外，也能取消報名，但是要測試取消報名需要有人報名才能取消。

實作取消報名

**src/PHPUnitEventDemo/Event.php**
```php
<?php

namespace PHPUnitEventDemo;

class Event
{
   // ignore ...
   
   public function unreserve($user)
   {
       unset($this->attendees[$user->id]);
   }
}
```
取消報名的實作很簡單，因為 `Event` 物件的 `$attendees` 陣列索引值為使用者的 id，所以使用者要取消報名時，只要將 `$attendees` 對應到使用者 id 陣列索引值的元素給刪掉。

**tests/EventTest.php**

```php
<?php

class EventTest extends PHPUnit_Framework_TestCase
{
   /**
   *   不應該把兩個不同的測試放在一起
   */
   public function testReserveAndUnreserve()
   {
       $eventId = 1; 
       $eventName = '活動1';
       $eventStartDate = '2014-12-24 18:00:00';
       $eventEndDate = '2014-12-24 20:00:00';
       $eventDeadline = '2014-12-23 23:59:59';
       $eventAttendeeLimit = 10;
       $event = new \PHPUnitEventDemo\Event($eventId, 
           $eventName, $eventStartDate, $eventEndDate, 
           $eventDeadline, $eventAttendeeLimit);

       $userId = 1;
       $userName = 'User1';
       $userEmail = 'user1@openfoundry.org';
       $user = new \PHPUnitEventDemo\User($userId, $userName, $userEmail);

       // 使用者報名活動
       $event->reserve($user);
       
       $expectedNumber = 1;
       // 預期報名人數
       $this->assertEquals($expectedNumber, $event->getAttendeeNumber());
       // 報名清單中有已經報名的人
       $this->assertContains($user, $event->attendees);

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
把報名與取消報名的功能放在同一個測試案例內，這樣是不好的做法，因為，單元測試是分別對每一個單元做驗證，所以需要把報名與取消報名的功能分開測試，寫成不同的測試案例。

該如何將報名與取消報名測試分開呢？往下一個部分 Test Dependencies 看下去。

#### 2. Test Dependencies（相依測試）

相依測試，如果有兩個測試案例，具有相依關係，就可以使用 test dependencies 在兩個測試案例建立相依關係。

承接上面要把報名與取消報名測試分開的問題，可以將報名與取消報名分成兩個測試案例，讓取消報名的測試相依於報名的測試。

**tests/EventTest.php**
```php
<?php

class EventTest extends PHPUnit_Framework_TestCase
{
   public function testReserve()
   {
       $eventId = 1; 
       $eventName = '活動1';
       $eventStartDate = '2014-12-24 18:00:00';
       $eventEndDate = '2014-12-24 20:00:00';
       $eventDeadline = '2014-12-23 23:59:59';
       $eventAttendeeLimit = 10;
       $event = new \PHPUnitEventDemo\Event($eventId,  
           $eventName, $eventStartDate, $eventEndDate, 
           $eventDeadline, $eventAttendeeLimit);

       $userId = 1;
       $userName = 'User1';
       $userEmail = 'user1@openfoundry.org';
       $user = new \PHPUnitEventDemo\User($userId, $userName, $userEmail);

       // 使用者報名活動
       $event->reserve($user);
       
       $expectedNumber = 1;
       // 預期報名人數
       $this->assertEquals($expectedNumber, $event->getAttendeeNumber());
       // 報名清單中有已經報名的人
       $this->assertContains($user, $event->attendees);

       return [$event, $user];
   }

   /**
    *  @depends testReserve
    */
   public function testUnreserve($objs)
   {
       $event = $objs[0];
       $user = $objs[1];
       
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
把原本的`testReserveAndUnreserve()` 拆成兩個測試：

- `testReserve()` : 測試報名功能
- `testUnreserve()` : 測試取消報名

**Producer 與 Consumer**

`testUnreserve()` 在註解內有利用 `@depends testReserve()` 標註相依於 `testReserve()` 測試，而被相依的測試可以當作 producer，將值傳給相依的測試 `testUnreserve()` 為 consumer，透過引數接收。

這樣就能將報名 `testReserve()` 與取消報名 `testUnreserve()` 測試分開，`testUnreserve()` 會接收來自 `testReserve()` 的回傳值，為一個兩個元素的陣列，陣列的第一個元素為，已經有人報名的 `Event` 物件，第二個元素為 `User` 物件，是已經報名的使用者。

如果 `testReserve()` 執行失敗，`testUnreserve()` 會執行嗎？
是不會的，當被相依的測試案例如果測試失敗，那相依的測試就會忽略執行。

我們可以試著將 `testReserve()` 故意測試失敗，只要將針對 `Event` 物件的 `getAttendeeNumber()` 斷言的預期值，從 1 改成 0 就可以讓 `testReserve()` 測試失敗，接著再執行測試：

```sh
$ phpunit --bootstrap vendor/autoload.php tests/EventTest
PHPUnit 4.4.0 by Sebastian Bergmann.

FS

Time: 73 ms, Memory: 3.50Mb

There was 1 failure:

1) EventTest::testReserve
Failed asserting that 1 matches expected 0.

/Users/aming/git/Hands-On-Writing-Unit-Testing-With-PHPUnit/tests/EventTest.php:15

FAILURES!
Tests: 1, Assertions: 2, Failures: 1, Skipped: 1.
```

（待續...）
___


##[法律專欄] 自由開源商用產品面對第三人專利問題的應對之方##


葛冬梅、林誠夏／文


在自由開源軟體的商業應用過程中，軟體專利侵權的潛在風險一直是個受到矚目的議題，因為依各國著作權法及電腦程式保護專法的規定，著作權性質的保謢標的多是限定在著作的表現形式上，故而重新撰寫且完全不抄襲他人的程式碼，將有機會主張新創作的程式，是一個全新的創作，而不受到他人既定程式的著作權利拘束，這也是 GNU 計畫 (GNU Project: GNU is Not Unix) 當初設立起步的主要思維：透過群策群力的方式，不加抄襲但重新創作具 Unix 系統所有功能的全新電腦作業系統，來讓後續的應用不受到既定 Unix 作業系統的拘束；然而在專利權的領域裡，因為其保護的標的多為抽象，且可實施在不同載體的技術方法和步驟，故第三人專利的議題在自由開源商用領域可能引發的效應，往往讓商業使用者憂心，畢竟，自由開源軟體專案允許多人共工的模式，一方面確實是加速了軟體專案的開發效率與期程，然而，開發流程裡是不是有開發者誤用或因疏忽寫入第三人既存，且受軟體專利保護的演算法，而讓整體專案後續曝露在專利侵權的風險下，這方面的推論，理論上亦有可能成真。


不過，自由開源軟體專案，在經過了這二十多年的商業化發展之後，全球利用它來進行商業營利的公司，亦已經發展出了不同的措施，可以一定程度面對這些可能產生的第三人專利侵權問題，這些不同措施所能產生的影響各有不同，其有效性也待實務驗證，不過其中有的措施，甚至可能對於全球專利制度產生重大而長遠的影響，這是此篇文章想要進行基礎討論和說明的要點。


###【技術方法的抽象特性是引發第三人專利侵權疑慮的主因】###


首先要說明的是，著作權保護的標的主要是既成著作的表現形式，故而透過重新創作的流程，即有機會避免侵犯到他人的著作權利，然而專利制度保護的客體與著作權不同，其保護的客體是相對無形的技術方法、設計與工法程序等等，所以一項專利技術可能透過不同的材料或媒介實作出來，例如同一項軟體專利技術可以透過電腦程式語言 α 撰寫實作，但也可能透過 β 或 γ 程式語言撰寫實作出來。因此當甲公司採用程式語言 α 開發出軟體 A，並在 A 中應用到甲公司本身所擁有的專利技術 A' 的時候，若另外一間公司乙後來採用 β 來撰寫另外一套功能相近的軟體 B，並且也在軟體 B 應用實作專利技術 A'，由於兩個軟體是甲、乙分別採用不同程式語言獨立撰寫開發出來，因此即使功能相近、甚至功能上完全相同，但是因為彼此程式碼並沒有參照、承襲的過程，故亦不會產生著作權法上抄襲、侵權的問題，但是因為兩套軟體都實作了專利技術 A'，這時候乙仍然應該要取得專利權人甲的同意，否則在未經取得授權同意的狀況下，乙若直接實作 A' 並將成果進行商品化利用的話，就會有專利侵權的風險產生，即使乙本身是在未知的情況下利用到 A'，若是這個「未知、無辜」的狀況沒有辦法被客觀的證明的話，那未來發生專利司法訴訟時，其亦非常難以完全免除應負的專利侵權責任，因為專利申請到被核可的過程中，它必然會經過公告審驗的程序，故而既成專利其技術方法的實踐流程，已經是公開資訊，故而乙公司就算是力言其產品的開發流程中並未設意去參考甲公司的既成專利，除了自己的聲明之外，也必須續行提出更多客觀的事證，才能夠讓承審法官同意採信。


###【自由開源軟體進入商業應用的領域導致侵害第三人專利權的風險上升】###


自由開源軟體的開發模式是奠基在志願參與開發的基礎上，許多專案的初始開發目的，並不是在於商業利用，而是以不收取授權金的方式自由散布給他人自由利用，故而其開發流程裡程式碼的吸納對象非常多元，從實來說，也不會就參與者貢獻的程式碼進行是否內含專利技術審驗的流程，這樣的開發態度因為海納百川，故而實踐起來非常具有效率，而過往這些自由開源軟體專案在近似學術研究、興趣分享的立場上，亦不會引發第三人專利的爭訟問題，因為專利是一種商用權利的保護，一項技術方法、設計或是工法若不俱備可以被產業利用的特性（註一），其便不符合專利申請的適格要件，而專利權利的實踐上，也主要是限制那些會影響到專利權人商業營利權利的行為，若是實作軟體專利技術的目的是為了學術研究，或者單純為了個人興趣，由於這樣的行為對於專利權人的經濟收益幾乎不會產生任何影響，因此就算使用者沒有事前取得專利權人的同意，也鮮少會有權利人針對這類的應用行為，透過司法制度進行索賠或提起訴訟（註二）。不過一旦自由開源軟體被實際應用在商業產品中，或者成為商業服務的基礎軟體系統的話，代表這項專利技術的應用，將讓商用的公司因而賺取商業利潤，這樣的商業應用行為便屬於專利權利發揮效力的範圍內，因此當自由開源軟體進入到商業應用的領域時，其第三人專利侵權的風險自然而然地隨之升高。


此種第三人專利保護的抽象與不可確定性的風險，在一般傳統的商業合作關係裡，上下游的兩間公司常常會透過專利侵權責任分擔協議，來進行一定程度的處理，這樣的分擔協議大致是上游廠商需允諾下游廠商，其在程式碼撰寫上，不得參照他人程式或專利技術方法，且須全程紀錄開發流程，以證明該程式專利自行撰寫的純粹性，如此一來，當日後商用產品產生內含第三人專利侵權的爭議時，下游廠商當可以引證上游廠商提供的開發紀錄，以證實其並沒有侵害他人專利權利的故意惡性，從而才不致為承審法院判處惡意侵權的加倍式損害賠償金 (punitive damages)。然而，此種傳統的上下游專利侵權責任分擔協議，本質上並不能完全適用於內嵌自由開源軟體專案的產品！因為從本質來說，自由開源軟體專案在開發上，必然是廣為吸納志工撰寫的參與，而基於這些參與者是在無償的基礎上進行程式碼的貢獻，因此即使在其貢獻裡有誤用，或在全然未知的前提下導入到第三人的軟體專利技術，該自由開源軟體專案的商用者，勢必無法援引或依循傳統上下游式的專利侵權責任分擔協議，來向這些自由開源軟體的開發者或散布者主張損害賠償或提起訴訟，因為就自由開源軟體的授權鏈裡，社群開發者與商用者之間並不具有產業鍵式的對價關係。


[LC_201412_img1.png]
▲ 圖1：FFmpeg 官網上面針對專利議題的說明內容（註三）。


實際的例子，可以參考近年來被廣泛利用的多媒體處理框架專案 FFmpeg 專案來說明。在影音串流領域當中有許多被既成專利保護的演算法，因此 FFmpeg 這套自由開源軟體也無可避免地，在軟體實作上會撰寫出與這些既成專利近似的技術方法來。許多 FFmpeg 的使用者想要商用這個開源專利到商業產品裡時，亦常會疑惑這樣的問題，並去信詢問開發團隊：利用 FFmpeg 是否會讓自己面臨專利侵權的相關糾紛？為此，FFmpeg 官方網頁上有一段簡短卻非常清楚的 FAQ 說明（註三），在這段說明中，FFmpeg 專案的開發團隊明確表示：其並無法確切得知 FFmpeg 中是否有利用到第三人專利演算法 (patented algorithms)，因為在軟體實際的開發流程裡，開發者們也並沒有閱讀過這些專利演算法的內容，不過開發團隊也承認，的確有些模糊的跡象 (vague hints) 顯示，若干實作可能落在一些既有專利演算法的主張範圍內，不過即使如此，使用者是否真的會面臨專利糾紛，除了要看身處的司法管轄區的專利規定外，還必須要看使用目的，因為若使用者僅是為了個人目的而利用 FFmpeg 的話，那麼幾乎是沒有理由擔心會面臨專利訴訟，然而，若是為了商業目的來利用的話，那麼商用使用者確實應該嚴肅的看待專利侵權的疑惑問題，因為過往有些將 FFmpeg 應用到商業產品中的公司，實務上確實就因此而被專利權人追索、要求支付專利技術的授權費用，例如擁有 H.264 編碼專利技術的 MPEGLA，就是一個會發動這類專利訴訟的著名者。


###【當前全球商業公司所採取的應對措施】###


從實而論，善用自由開源軟體來節省開發成本並加速開發效率，已經是全球資通訊產業裡無可逆轉的大勢，故面對上述這些，將自由開源軟體置入商用產品所可能產生的第三人專利侵權風險，許多的商業公司、商業聯盟也在近年陸續發展出了不同的因應措施，來減緩可能發生的智慧財產權衝擊。從內部來說，有調整公司內部的開發流程，與強化提供侵權擔保的應變方案；從外部來看，有些公司則是向外尋求合作與加入全球性的專利合作結盟組織。以下便就這四項應對措施，進行綱要式的說明。


####1、建置標準開發流程的自動紀錄以降低主觀侵權責任####


在專利侵權糾紛發生時，若侵權人被證實是明知而故意侵權的話 (willful infringement)，各國法院皆得以依其專利法或相關特別法令，酌情將損害賠償金額提高到三倍或更高的幅度（註四），反過來說，受控方若是可以降低被判定為故意侵權的風險，便可以降低公司在專利司法訴訟上支出的金錢損失，因為若是不被承審法院認定是惡意侵權，則專利費用的支付原則上是依專利權人所受損失與所失利益的幅度來估算，以這樣的衡量標準，在專利侵權訴訟上，被訴方若不受到主觀侵權責任的加乘，則賠償金額的估算幾乎完全等同事前取得商用授權的授權金額度。而這邊所謂的標準開發流程，主要是指將產品研發過程的資料與進度內容都紀錄下來的標準化流程，在公司內部有這樣一套基本的標準化流程，將可以顯示公司本身對於智慧財產權的管理與運用有盡到相當程度的努力，進而降低主觀侵權責任。


此種標準開發流程實施的時間愈長、紀錄與保存資料的間隔期間愈短、可修改內容的權限範圍愈窄，都是可以強化這套系統的可信度，例如規定研發人員每週至少進行二次的研發內容與進度紀錄，紀錄內容可採用數位化形式，寫入過程自動化，但讀取權限僅限一定層級的主管人員，而資料一旦寫入後要進行修改，必須齊集二至三位跨部門或是外部合作律師事務所的金鑰，並錄影存證調取過程。此種密集、長期、權限特定的流程下，所保存的內容就具有相當的可信度。而因為自由開源軟體的取用，是屬於向外部取得授權，故開發流程無法擴張去控管至該外部自由開源軟體專案的開發審慎度，故上述的管理流程，多還會針對自由開源軟體的商業應用來進行補強處理，例如：取用開發歷程上較為長遠的顯名開源專案、詳實紀錄來源其託管平台與授權狀態，以及初步判斷是否涉及可能產生的專利議題等等，凡此種種作為，於事涉專利侵權司法爭訟時，都可以據以向承審法院陳報，以之證明已盡相當注意義務，防止侵權利用到他人軟體專利，進而減少可能擴大的侵權損害賠償數額。


####2、提前揭示先前技術以阻卻他人軟體專利的申請####


一項技術方法之所以能通過專利主管機關的核可，除了本文前面所提及的「產業利用性」之外，還必須要具備「創新性」（註五）。所謂創新性，白話來說，是指申請專利之人是這項技術方法在這個世界上的第一位發明人，若是這世界上已經存在有這項技術方法，並已在該專門領域受眾人熟知的話，則該項技術方法就不具備創新性，也就連帶不符合專利的申請要件，並進而無法得到專利制度的保護。這些已經存在於世界上的技術方法，被稱為「先前技術 (Prior Art)」，當公司在產品研發過程中，發崛到可以符合專利申請要件的技術方法，但經過評估和經濟效益的分析後，評價並沒有必要以此來申請專利，此時，就可以將這項技術方法透過網站披露、期刊發表等手段來公諸於世，使其成為先前技術，這樣的作為，固然是捐棄了己方本來可以申請的專利標的，但從長遠來看，亦同時阻卻了他人將此技術方法在未來申請為其專利標的之可能性，如此一來，當可避免競爭公司將相同的技術方法申請為專利保護，並進而影響到己方對此技術的商用範圍，也就是說，同時減少掉第三人專利糾紛的產生風險。


要完成這樣的揭示，除了個別公司自設網站或投稿期刊來公開技術之外，也可以透過像 "IP.com" 或 "Defensive Publications" 這樣的計畫網站來公布。與 ip.com 主要的合作對象包括 IBM 等跨國性的資服產業，而 Defensive Publication 則是 Linux Defender 計畫下的一項子計畫，由 Open Invention Network (OIN)、Linux Foundation 以及許多跨國企業所合作成立，這些網站的運作目的主要在於宣導、鼓勵各界將已知的先前技術提供出來，讓其公開於網站上，供社會大眾查閱之用，其亦與各國的專利審查機構，例如美國的專利商標局有提報與資訊查找上的合作關係，透過這樣的技術揭露網站，讓自由開源軟體專案的開發者了解到，哪些技術方法是可以安心實作到軟體中的，而在面臨專利訴訟惡棍時，也可以在資料庫中搜尋相關的先前技術，用之作為撤銷爭端專利的基礎（註六）。因此若是一間公司想要將相關的技術方法公諸於世，透過 IP.com 與 Defensive Publication 這樣的網站來進行，都是一個相當不錯的可行方案。


####3、透過保險機制向商業服務客戶提供軟體專利擔保契約並量化侵權損益範圍####


前述二種措施，主要是從內部管理的觀點，來處理並降低第三人專利可能引發的侵權風險，然而，第三人專利之所謂為第三人專利，就是因為該專利的誤用是來自外部，故而全然內部的管理，確實無法完全防堵掉所有相關的疑慮。故實務上，不少的跨國企業，是兼採外部合作的方式，以組織一個更大範圍的合作聯盟，來處理第三人專利的問題。例如，Red Hat 是自由開源軟體領域裡長期受到關注，且具有穩定獲利歷史的重要指標性公司，其主要是提供商用客製化 Linux 作業系統的技術服務來獲取價金，然而自第三人專利侵權風險問題升高之後，不少客戶也會向 Red Hat 反應：是否能有某些具體可信的措施，能讓其商業服務的客戶免除被專利侵權風險所及的險地？


因應這樣的詢問和需求，Red Hat 提出了商業客戶安心方案（Open Source Assurance，註七），基本上，該方案透過兩個要點來降低自由開源專案在商用服務上的侵權風險，第一個手段是保單的購置，Red Hat 將其商業服務可能涉及的專利侵權風險進行了總量的分析與評估，並就合理的額度與保險公司洽談相應的保險機制，並以這樣的保險機制來回應其客戶的擔憂和疑惑，也就是說，當客戶是透過商業契約來與 Red Hat 建立技術服務關係時，此一商用客戶就自動進入了 Red Hat 安心方案的保護範圍內，若是此客戶因為專利侵權的風險而涉訴並進而負擔賠償責任，則 Red Hat 即可先行墊付此商用客戶被課予的賠償金額，並啟動其保險機制來向保險公司進行保險金的後續理賠申請；而第二個手段，則是 Red Hat 在商業契約裡，和其服務客戶明訂專利侵權損害負擔的金額範圍，例如一個 500 萬元的資服建置或服務案，其個別契約可能明訂 Red Hat 對客戶負擔的安心金額為 300 萬元至 800 萬元不等的幅度，透過這些侵權分擔責任的量化設定，自由開源軟體應用在各個商用環結的責任分擔，也就更形具體而明確。


####4、預屯專利透過合作組成軟體專利防禦聯盟####


另外一個對當前全球專利制度，有機會產生更深遠影響的舉措，即是 OIN 這樣的公益公司，所屯建的自由開源軟體專利防禦聯盟。其實，專利池 (patent pool) 的概念與實踐自來有之，其運作的方式就是促使有商業合作關係，在產業鍵具上下游分工關係的公司，能夠在簽訂專利共享契約的基礎上，去構築一個聯盟式、夥伴式的專利防禦網。當此專利防禦網的任一家公司，受到專利防禦網之外的商業公司，進行專利侵權訴訟時，此聯盟成員便可以援引其他合作夥伴手上已擁有的專利，對控訴方進行反訴，其運作方式就如同二次大戰之後的冷戰時期，美蘇兩方各屯聚了為數不少的洲際飛彈，讓敵對方知道一旦爆發戰爭，則可能引發玉石俱焚或彼此皆傷的後果，故而降低專利戰爭發生的可能性與風險，或者說，就算發生專利爭議，受控方也比較有機會援引聯盟夥伴裡所屯聚的專利資源，轉而透過私下商議的途徑，得到一個較佳的和解處置方案。而這樣的概念，也是可以比附援引至自由開源軟體的商用領域裡的，不過，因應自由開源軟體在商業使用上不受時間、對象、地域限制的特性所影響，目前由 OIN 主導的 Linux 系統軟體專利防禦聯盟，其實踐方式是將傳統的專利池概念，進行了更廣域的應用與解釋，首先，其在名詞運用上，淡化了專利池這般的傳統語彙，因「池 (pool)」這個字詞在演繹上，有一種入我山門方受蔽護的私有圈意涵在內，故而 OIN 向外強調的是一個飛航禁行區 (No Fly Zone) 的革新概念，意指在 Linux 系統與其他自由開源軟體專案的基礎下，個別受國家權責機構審核後同意的軟體專利仍然是成立與有效的，然而，商用圈所欲逐步建立的共識是，若是使用者依循個別自由開源軟體授權條款的規則來使用這些軟體專利，則可合法使用，僅在使用者不依循授權條款的規則時，才備位產生侵權式的拘束效力（註八），而進一步來說，這些商用使用者，只要願意遵守 OIN 與其合作夥伴，所擘劃的軟體專利防禦共享規則，則進入防禦圈的對象，並不去設入門門檻，亦即沒有進入的資金、所持專利方面的門檻，而更是一種就 Linux 相關產品的商用發展上，不互相進行軟體專利侵權互訴的承諾和互助。


###【結語】###


以上，大致為近十年自由開源軟體商用領域，依據實務可行性所發展出來，面對第三人專利問題的應對之方。就如同本文一開始所揭示的，這些措施所能產生的影響各有不同，其有效性也仍有待後續時間的驗證，不過從大方向來看，其所施行的步驟和各國立法與行政機構，所在進行的專利制度調整與修正，確實具有相當程度異曲同工之妙！例如在專利侵權的訴訟上，愈來愈多國家就專利蟑螂 (patent troll) 的吊餌行為，開始調高了訴訟法上的惡意侵權歸責，也就是說，從傳統上概由受訴方自證無辜與非故意，慢慢導向控訴方也必須分擔必要的舉證協力，此一改革方向，與前述建置標準開發流程的自動紀錄以降低主觀侵權責任，以及提前揭示先前技術以阻卻他人軟體專利的申請，可說都是朝著同樣的方針來進行處理，也就是說在專利侵權的司法審判上，除了客觀的利用行為外，仍需兼論主觀的侵權犯意；再者，除了透過外部保險制度與組建軟體專利共享聯盟外，許多商用自由開源軟體專案的跨國性機構，例如 Google、IBM 等，也不斷透過公共政策的建言，以引導未來的專利制度能更容納自由開源軟體專案的應用框架。可以合理預期的是，軟體專利的核可機制，在可見的未來並不會遽以消失，然而其運轉方式，必然會因為自由開源軟體的發展趨勢，而得到一定程度的調整與疏解，目前，我們無法鐵律一般的定言，上述這些方案哪一個是對緩解商用自由開源軟體的專利風險最具效力的良方，然而，若是商用企業能夠行有餘力而兼容採之，必然是可以相當程度為自己構築起更安穩的專利風險防禦牆。


----


註一：這項特性一般稱為「產業利用性」或「商用性」。


註二：以我國專利法第 59 條為例，該條第 1 項規定了七款發明專利權無法發揮效力的狀況，其中前兩款分別是：非出於商業目的之未公開行為、以研究或實驗為目的實施發明之必要行為。由於這兩款行為對於專利權收益所造成的損失是微乎其微，所以在權衡專利制度也同時要鼓勵研究與創作新發明的目的下，我國專利法規定發明專利權的效力不並及於這兩種行為。因此個人在家中利用閒暇時間，應用他人軟體專利來撰寫開發程式以自用，並不會產生侵害他人專利權的效果；單純應用他人專利技術來進行學術研究，並且將結果加以發表出來，也不會引發專利侵權的後果。


註三：[http://ffmpeg.org/legal.html](http://ffmpeg.org/legal.html)。


註四：以我國專利法第 97 條第 2 項規定為例：「依前項規定，侵害行為如屬故意，法院得因被害人之請求，依侵害情節，酌定損害額以上之賠償。但不得超過已證明損害額之三倍。」


註五：一項技術方法必須符合基本的三項要件，才算是具備專利適格性 (Subject Matter Eligibility)，可以用來向國家權責機構申請專利保護，此三項要件為：技術性、新穎性，以及商業利用性。


註六：Linux Defender網站：[http://www.linuxdefenders.org/](http://www.linuxdefenders.org/)。


註七：Open Source Assurance 官方頁面連結如右：[http://www.redhat.com/en/about/open-source-assurance](http://www.redhat.com/en/about/open-source-assurance)。


註八：更多相關的評論與觀點，可參照，林誠夏，備位啟動的自由開源專案軟體專利：[http://www.openfoundry.org/tw/legal-column-list/8498-standby-software-patent-free-and-open-source](http://www.openfoundry.org/tw/legal-column-list/8498-standby-software-patent-free-and-open-source)。
___


##[源碼新聞] 來自開放糧食開發者的古老訊息


四貓／翻譯  
   
**本文翻譯自 Opensource.com，原作者是 [Sumana Harihareswara
Feed](http://opensource.com/users/brainwane) 和 [Alex Bayley](http://infotrope.net/) 合著而成：http://opensource.com/life/14/11/growstuff-open-source-food**  
  
  
![圖片來源：opensource.com](http://www.openfoundry.org/images/141230/EDUCATION_jadud_make-things-better.png)  


**[Growstuff](http://growstuff.org/) 是一個開源的作物資料庫專案，資料來自於種植者的知識，由群眾外包提供下列資訊，包含誰種了什麼樣的作物、種植的時間與地點，以及他們打算怎麼樣收穫。你可以在  [Github](https://github.com/Growstuff/growstuff) 上找到專案頁面。**  


先不要去想開放源碼要如何改變糧食的世界。讓我們一起想想，開放源碼會如何改變我們接觸科技的途徑。  


農業不僅是人類所建立世界上最古老的科技之一，也是最古老的開放文化。  


近數十年間農業在西方國家變得封閉。工業化之後，特別是二十世紀中期，人造肥料更強化了這樣的封閉性，把食物從土地送上餐桌的科技將我們之間的距離拉遠了。只有少數人知道雞肉變成麥克雞塊的步驟，或是該怎麼將蕃茄做成蕃茄醬——跟知道如何編寫自己的軟體，或是和關心是否有編寫軟體自由的人數一樣少。  


然而，農業在世界上許多國家仍遵循著傳統的方式一脈相承。即使是已開發國家，傳統的農業模式仍在小規模的種植者、遺傳育種者、還有像是植物銀行、社群花園、慢食團體等組織或社群中開放地分享關於食物的知識。開源社群可以從現有的食物運動中學習，它們是世界上持續最久的開放社群，有一定程度的多樣性，還有草根的組織經驗，應該會讓許多開源專案羨慕不已。  
    
![圖片來源：opensource.com](http://www.openfoundry.org/images/141230/growstuff_lettuce.png)   
    
    
###來自世界各地糧食種植者的開放資料 


2012年的時候，[Alex Bayley](http://infotrope.net/) 在專題演講中提到開放源碼可以向其他開放社群學習什麼，學習的對象也包括了大部分時候都沒有連上網路的種子銀行和社群農場。另一位演講者，GNOME 的創立者 [Federico Mena Quintero](http://blog.growstuff.org/2014/10/09/we-interview-federico-mena-quintero-the-permaculturist-and-open-source-developer-who-inspired-growstuff/) 表示他也在思考類似的事情，他已經試圖在社群中建立開放源碼與同儕生產 ([peer production](http://en.wikipedia.org/wiki/Peer_production)) 之間的連結，像是[樸門 (Permaculture)](http://permacultureprinciples.com/) （註1）和傳統森林景觀一樣。Federico 生活在墨西哥，他在尋找適合當地氣候的種植建議時遇到了困難，於是找上 Alex 詢問哪裡可以找到有關作物的開放資料。不幸地，大部分可以取得的資料不是針對美國，就是目標大規模農業，或是針對科學家；幾乎沒有能夠連結到資料群是在後院耕種的小農可以使用的。   
  
來自於政府或是其他大型組織「從上到下」式的開放資料，鮮少為了小農或是其他沒辦法傳達需求的糧食社群服務。如果我們想要一份實用的開放糧食資料，我們會需要群眾外包、同伴對同伴的網路還有分散式的管道。開放糧食計畫需要「由下而上」的努力，應反映出如食物系統一般的多樣性——聯合國承認比起大規模、中央型的發展，多樣性更可以帶領大家進入[更永續的未來](http://www.fao.org/family-farming-2014/home/main-messages/en/)。  
    
這些認知讓 Alex 決定建立 [Growstuff](http://growstuff.org/)，這是一個開源專案一個開源的作物資料庫專案，資料來自於種植者的知識：由群眾外包提供誰種了什麼樣的作物、種植的時間與地點，以及他們打算怎麼樣收穫。Growstuff 認知到種植時間、微氣候的適合作物、害蟲辨識等與植物生長的相關知識周已經存在於全世界種植者的腦中。除非你已經和當地的農作社群建立了良好的社交關係，否則這些知識非常難以取得。Growstuff 幫忙匯集當地種植資訊，也幫忙在種植者之間建立連結，全世界性地支持小規模農業。
       
            
###歡迎多樣化的糧食社群
    
開源的糧食專案必須要和規模較大、非科技背景的開放糧食界建立連結。糧食界的人和組織共享著一個巨大的主流知識體，這些知識是藉著細心實作以及長期觀察聚集而成的。我們需要去到他們所在的地方、去熟悉他們的語言、操作方法還有概念架構，並以成熟的尊重和合作成為兩個不同世界的橋樑。開源社群有可能會不夠友善、精英主義、講話充滿術語，但我們必須去反抗這些情況，並讓我們的糧食專案不管對擁有糧食技能的人或擁有科技技能的人都同樣包容、友善。
  
當[女性生產了世界一半以上的糧食](http://www.fao.org/docrep/x0262e/x0262e16.htm)，開源的性別議題在這裡特別的要緊，Growstuff 認為有很多可以和現有的糧食社群學習的地方。從第一天開始，這個專案就設計成要把開發者和種植者一起納入，並聚焦於透明的溝通，如同開源的程式碼一樣。 結果就是這個專案有了差異顯著的貢獻者，成員分佈橫跨六個大陸，並反映出幅員廣大的食物文化。對科技人來說，對食物應有的方式做出假設很容易，但食物其實和科技一樣是一種文化。科學家看作物的時候，看見的是品種，但是對種植者或廚師來說，羽衣甘藍、球芽甘藍、和花椰菜即使分享了同樣的學名，他們還是不同的蔬菜。   
    
     
###開放生態系統
  
我們的專案一樣需要內部運作 (interoperate) 。當開放糧食版圖中的所有片段互相連結在一起的時候，它才會是最強大的。像[開放糧食基金會 (Open Food Foundation)](http://openfoodfoundation.org/) 這樣的團體幫助糧食專案的成員間彼此聯繫，討論我們在程式、資料和策略上可以如何協同工作。在這個當下，單純的識別出正在活躍的專案並了解他們在生態系之中的位置是我們最重要的任務。我們有部份的工作室鼓勵開放糧食專案提供開放的 API 和資料，並使用被廣泛接納的授權，並在幾個關鍵的面向上共工溝通，例如：連結不同專案中作物與產品的資料。如果我們可以結合為了種植作物而開發的 Growstuff 、為了糧食分配
而開發的 [Open Food Network](https://openfoodnetwork.org.au/)，和為了營養開發的 [OpenFoodFacts](http://openfoodfacts.org/) …等應用程式，而[追蹤食物從產地到消費端](http://talk.growstuff.org/t/open-food-interoperability-entities-unique-ids-and-semantic-equivalence/93)的整個過程，那麼便可以算是成功了！  
  
    
###賦權、而非分裂
  
身為科技人，我們曾極力主張現有的產業可以「賦權」(disrupt)，但糧食界曾被迫賦權給高密度經濟農作，而種種問題隨之而來。開源社群已經建立了網路上分散合作的經驗，讓我們先用觀察代替使用科技，授權給糧食生產者和消費者，並鞏固糧食社群現有的工作成果。當我們成為其中一份子的時候，讓我們自己也開放吧，看看人類歷史中最長壽的開放社群可以帶給開源界什麼樣的進步！
    
    
**註解**  
註 1：根據維基百科上的介紹，[樸門](http://zh.wikipedia.org/wiki/%E6%A8%B8%E9%96%80)是把原生態、園藝和農業及許多不同領域知識相結合，透過結合各種元素設計而成的准自然系統。
___


##[源碼新聞] 自由軟體校園演講 - 103 學年度第 2 學期申請##


OSSF 電子報團隊／整理


雖然寫了很多程式，但還是常常覺得自己的程式碼很髒？本學年自由軟體鑄造場帶來「提升程式碼品質」的系列課程，加速同學在開發上的進步！另外還有身為軟體開發者一定要了解的開源軟體法規、授權議題也一併推薦給您！
除此之外，還有精彩的 Maker 自造工作坊，以及開放知識時代一定要會的維基百科編輯術等著大家來發掘！
 
配合學校新學期的開始 (2015/02 ~ 2015/06)，自由軟體鑄造場針對大專院校設計了一系列與自由、開放軟體有關的演講主題與教學推廣課程，領域包含技術開發、資訊安全、科技法律、企業應用、社群推廣等主題。希望能夠進一步推廣自由軟體概念給大專院校，並提昇國內大專院校校園自由軟體的應用及發展。


想要了解更多，請到我們的[校園推廣申請網頁](https://www.openfoundry.org/application/2-foss-on-campus-promotion-application)看看吧！
___


##[源碼新聞] SITCON HACKGEN 2015 is Coming !##


SITCON 學生計算機年會／文


在求學的過程中，可曾否想過課堂所上的一切，究竟能在哪發揮？


SITCON（Students' Information Technology Conference, 學生計算機年會）是自 2013 年由一群學生自主性地發起，以在學學生為主體的學生社群。秉持 Open Source、創新與實作的理念，以自發性的學習為基礎，延續 SITCON 學生計算機年會的理念，展開了一系列的活動。


![](http://www.openfoundry.org/images/141230/1_resized.jpg)
▲圖一：SITCON 的系列活動之一，SITCON Workshop 2014，透過免費的課程，讓有興趣的學生生可以快速
上手一項新的技能。


不管是為了推廣交流的定期聚會、開源社群，培養創新學習科技人並更深入低年級的 Summer Camp，還有免費讓學生學習那些學校通常無法學到內容的 Worshop，亦或是即將舉辦的黑客松，都可以見到 SITCON 全力投入的足跡。


黑客松（Hackathon）本身是一個合成詞，由程式設計（Hack）加上馬拉松（Marathon）兩部分所組成，在活動當中，程式設計師以及其他領域的人員，相聚在一起，互相合作、共同設計、腦力激盪，去進行某項專案，並且創造出很棒的作品。


Hackathon 透過有限的時間與資源，在最短的時間內讓腦海中的創意雛形，實作出一個軟體專案的 prototype，這不只是考驗團隊的溝通默契以及解決問題的方式，還有專案管理能力，以及要能夠有效率的去做一些取捨，才能在規定時間內上台展示 (Demo)。


學生透過 HackGen，希望能夠體會寫程式的樂趣，並且促進跨校、跨領域不同專長之間的認識以及交流；甚至藉由作品分享，讓每位參加的學生，都能見識先前可能從未接觸的技術，加深對自己學校的認識，以及未來可以選擇的道路。也期望能推動安全、有互動、更加便利、有效率、而且環保的校園，並且在面對目前教育體制下的一些困境，主動克服，自主學習，在互相交流當中學以致用、教學相長。


![](http://www.openfoundry.org/images/141230/2_resized.jpg)
▲圖二：SITCON x Hour Of Code：SITCON 所舉辦的 Hour Of Code，活動中年紀最小的參與者，三歲半的小女孩都會寫程式了！


HackGen 駭客世代黑客松提供了絕佳的機會，只要你有興趣、想實際參與多人設計和開發，都可以來參加，透過實際的程式撰寫，創意的激發，熱情的展現，讓身為學生的自己得以發揮所學，為彼此的校園盡一份心力，讓校園更進步，生活更開放，點亮更多的驚嘆號！


現在就報名 HACKGEN！http://sitcon.kktix.cc/events/hackgen2015/


___


##[源碼新聞] 2015 年一月份社群活動列表

OSSF 電子報團隊／整理

祝各位新的一年事事如意！明年一月份的活動列表出爐囉！有興趣的朋友們請多多邀請您的朋友們一同前往參與！另外，由於活動列表出來的時間比較早，若後續有活動希望也能一起做宣傳的朋友們，請記得來信告訴我們喔！信箱： ossfepaper@openfoundry.org 。

###@北部

####Hacking Thursday（每週四，1/8、1/15、1/22、1/29）
- 時間：19:30~22:30
- 地點：台北市大安區建國南路一段 166 號 2 樓（伯朗咖啡館建國店）
- 活動資訊：[http://www.hackingthursday.org/](http://www.hackingthursday.org/)

####JS Girls Taiwan（每週三，1/7、1/14、1/21、1/28） 
- 時間：19:00~22:00
- 地點：台北市大安區安和路二段23巷11號B1（卡市達創業加油站）
- 活動資訊：http://jsgirlstw.kktix.cc/events/jsgirls

####MozTW Lab @ 基隆（每週三，1/7、1/14、1/21、1/28） 
- 時間：19:00~21:00
- 地點：基隆市仁愛區港西街 4 號 1 樓（1915 海洋咖啡館）
- 社群網址：[https://groups.google.com/group/moztw-general](https://groups.google.com/group/moztw-general)

####MozTW Lab @ TP（每週五，1/2、1/9、1/16、1/23、1/30）
- 時間：19:30~22:00
- 地點：台北市中山區德惠街 23 號地下一樓（摩茲工寮）
- 活動資訊：[https://groups.google.com/group/moztw-general](https://groups.google.com/group/moztw-general)

####Taipei Wikipedian Weekly Meetup: Community Operation 維基台北定期聚—社群經營工作雙週聚（每週五，1/2、1/9、1/16、1/23、1/30）
- 時間：19:00~21:00
- 地點：台北市中山區德惠街 23 號地下一樓（摩茲工寮）
- 活動資訊：[http://zh.wikipedia.org/zh-tw/WP:WPTP-S](http://zh.wikipedia.org/zh-tw/WP:WPTP-S)

####TOSSUG BoF（每週二，1/6、1/13、1/20、1/27）
- 時間：18:00~22:30
- 地點：台北市中正區羅斯福路三段 284 巷 5 號 2 樓（Ville Cafe）
- 活動資訊：[http://www.tossug.org/](http://www.tossug.org/)

####WoFOSS 1 月第 53 次聚會（1/15）
- 時間：19:00~21:00
- 地點：台北市信義區信義路五段7號73樓（台北101 的 Google Cafe 75 ）
- 活動資訊：http://www.accupass.com/go/AnitaBorgBD 

###@南部

####Cocoaheads - Kaohsiung（1/8）
- 時間：19:00~21:00
- 地點：高雄市前鎮區復興四路 2 號 7 樓之 5（高雄軟體園區 B 棟 708 室）
- 社群網址：[https://www.facebook.com/groups/cocoaheads.kaohsiung/](https://www.facebook.com/groups/cocoaheads.kaohsiung/)

####KSDG 高雄開發者社群 (Kaohsiung Software Developer Group) meetup（1/1）
- 時間：19:00~21:00
- 地點：高雄軟體園區 B 棟 708 室（高雄市前鎮區復興四路 2 號 7 樓之 5）
- 社群網址：[https://www.facebook.com/groups/KSDGroup](https://www.facebook.com/groups/KSDGroup)

####KSDG web course（1/17）
- 地點：高雄軟體園區 B 棟 708 室（高雄市前鎮區復興四路 2 號 7 樓之 5）
- 社群網址：[https://www.facebook.com/groups/KSDGroup](https://www.facebook.com/groups/KSDGroup)
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