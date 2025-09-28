___

□■□ 自由軟體鑄造場電子報第 240 期 | 2014/04/29 □■□
___

◎ 本期主題︰AngularJS - 指令

◎ 訂閱網址︰[http://www.openfoundry.org/tw/news/](http://www.openfoundry.org/tw/news/)

◎ 下次發報時間︰2014/05/13

#本期內容#
___

##[技術專欄]AngularJS - 指令

###首先要了解 AngularJS 的入門指令，Code 的作用。例如：

####1、新增宣告語法 ng-app ：

宣告應用程式作用域（Application Scope），在 Document Object Model（DOM）載入後，AngularJS 就會開始尋找 `ng-app` 這個字，找到的話，就會把這頁面當成是 AngularJS 應用程式。

 - 宣告方式：**一份 HTML 只能宣告一個應用程式作用域（ng-app）**
 
    `<html ng-app>`

    `<html ng-app="appName">`

 - ng-app 用法：
	 - 全站使用 AngularJS ：放在 html（或 body）裡面。
        - `<html ng-app> </html> `或 `<body ng-app> </body>` <p>

	 - 局部使用 AngularJS ：可以把這個字放在某個應用到 AngularJS 的 div 中（例如：div）。
        - `<div ng-app ></div>`

####2、{{ }} 雙大括號綁定表達式：
這行代碼演示了 AngularJS 模板的核心功能：绑定。

    <p>Nothing here {{'yet' + '!'}}</p>

這個绑定由雙大括號 ` {{}} ` 和表達式 ` 'yet' + '!' ` 组成。它告诉 AngularJS 需要運算其中的表達式並將结果插入 DOM 中，接下来我們可以看到 DOM 隨著表達式運算结果的改變而更新。

AngularJS 表達式 Angular Expression 是一種類似於 JavaScript 的代碼片段，AngularJS 表達式僅在 AngularJS 的作用域中運行，而不是在整個 DOM 中運行。

####3、’$’ 字首命名規則：
作為一個 AngularJS 的內建服務，作用域方法和其他 AngularJS 的 API 都會在名稱前面加上一個`’$’`的字首。

為了避免衝突，在 Services 和 Models 的命名上最好避免有 `’$’` 的開頭。

####4、ng-controller：
是 AngularJS 的語法，主要用來綁定 View（HTML）和 Model（JS）的連結，以建立 View 和 Model 的關係。其遵循 MVC（Model–View–Controller）框架，可以透過 Controller 來處理 Model 和 View 之間的綁定。若在 Controller 中進行修改，異動也會反應到 View 中，達到 AngularJS 的雙向資料綁定（Two Way Data-Binding）。

例如：_（指定名稱為 " fun " 的 controller，必須與 controllers.js 裡的主 function 名稱相同。）_

`<body ng-controller=" fun ">`

####5、$scope：
是 AngularJS 在建立（Controller）應用程式時產生的一個物件，用來代表應用程式的 Model。所以我們透過 ` $scope. ` 變數，才能得到變數的（值）位址。

在 Model 裡面指定變數 name 的方式為 ` $scope.name` ，View 再透過 `{{name}}` 顯示。我們在名稱為 fun 的 Controller 裡面，宣告一個名稱為 name 的變數，並將變數值指定為 “sunny”。

    `function fun($scope)`
    ` {$scope.name = "sunny";}`

接著只要在 HTML 裡面指定 `ng-controller` 名稱，並輸入 `{{name}}` ，即可。

		<p ng-controller=" fun">My name is {{ name }}!</p>

####6、如何在 AngularJS 中使用 HTML input 事件：
 - 事件 ／ 屬性
	 - `name`  ／ 名稱
	 - `ng-model` ／ 綁定的資料
	 - `required` ／ 限制是否必填
	 - `ng-required` ／ 限制是否必填
	 - `ng-minlength` ／ 限制最小長度
	 - `ng-maxlength` ／ 限制最大長度
	 - `ng-pattern` ／ 限制 RegExp 格式
	 - `ng-change` ／ 當 input 的值發生變化的時候執行
<P>
 - Input 包含了以下類型
	 - type="checkbox"
	 - type="email"
	 - type="number"
	 - type="radio"
	 - type="text"
	 - type="url"

#####其中 checkbox 的使用方法？#####

1.  `ng-controller` ，處理 Model 和 View 的雙向連結
2.  `ng-model` ，綁定 checkbox 的資料和 value1 的值，一有變動，就會隨時更新。
3.  可以透過 ` ng-true-value ` 和 ` ng-false-value`，修改 value2 的內容。

**HTML：** 

    		<form name="myForm" ng-controller="Ctrl">
			Value1: <input type="checkbox" ng-model="value1"> <br/>
			Value2: <input type="checkbox" ng-model="value2"
				ng-true-value="YES" ng-false-value="NO"> <br/>
			<tt>value1 = {{value1}}</tt><br/>
			<tt>value2 = {{value2}}</tt><br/>
		</form>

**JS：**

		function Ctrl($scope) {
			$scope.value1 = true;
			$scope.value2 = 'YES';
		}

####7、指令的特性：

AngularJS 的 HTML 編譯器能讓瀏覽器識別新的 HTML 語法。它能讓你將行為關聯到 HTML 元素或者屬性上，甚至能讓你創造具有自定義行為的新元素。AngularJS 稱這種擴展行為為「指令」。

指令是指「當關連的 HTML 結構進入編譯階段時應該執行的操作」。指令可以寫在元素的名稱裡、屬性裡、CSS 類名裡和注釋裡。指令的特性非常有用，它擴展了 HTML 的表現能力，使用這個特性能夠以更少的代碼建立更簡潔的頁面結構。

- AngularJS 本身內建了一些指令，來看個例子，其使用了內建的 `ng-repeat` ，首先通過 `ng-init` 指令創建了一個 students 的對象數組，然後使用 `ng-repeat` 指令打印出所有學生的名字和年齡。
	
		<div ng-init="students = [
				{name:'John', age:25, gender:'boy'},
				{name:'Joy', age:15, gender:'girl'},
				{name:'Mary', age:28, gender:'girl'},
			]">
		<div data-ng-repeat="student in students">
				<h3>{{student.name}}:{{student.age}}</h3>
			</div>
		</div>
另外，還可以使用 ` ng-show ` 過濾重複值，只顯示 boy： 

		<div data-ng-repeat="student in students" data-ng-show="student.gender=='boy'">
			<h3>{{student.name}}:{{student.age}}</h3>
		</div> 
或者使用 `ng-switch` 做一些更複雜的控制，如：年滿 18 歲打印 ADULT。

		<div data-ng-repeat="student in students" data-ng-show="student.gender=='boy'"
			data-ng-switch="student.age >18">
			<h3>{{student.name}}:{{student.age}}</h3>
			<p data-ng-switch-when="true">ADULT</p>
		</div>

- 其特性為開發人員省了很多代碼，對定義 Web Page Structure 來說非常有幫助。而且除了本身自帶的 Directives 滿足大部分群眾的需要外，還支持定制 Directive 來滿足使用者的特別需求。<p>除此之外，AngularJS 指令可以用來創建自定義的標籤，它們可以用來裝飾元素或者操作 DOM 屬性。以下是監聽一個事件並且針對更新它的 `$scope` 例子：

		myModule.directive('myComponent', function(mySharedService) {
			return {
				restrict: 'E',
				controller: function($scope, $attrs, mySharedService) {
					$scope.$on('handleBroadcast', function() {
						$scope.message = 'Directive: ' + mySharedService.message;
					});
				},
				replace: true,
				template: '<input>'
			};
		});
你可以使用這個自定義的 Directive ：

		<my-component ng-model="message"></my-component>
使用一系列的組件來創建自己的應用，將使你更方便的添加、刪除和更新功能。

####8、指令的用途：
一種 DOM 物件的標記（可以是 HTML 屬性／標記名稱／CSS Class），ng 會透過一組 HTML 編譯器（$compile）將功能外掛上去。

- 常用指令
	- ng-app
	- ng-init
	- ng-bind
	- ng-non-bindable
	- ng-bind-html
	- ng-bind-template
	- ng-repeat
	- ng-list
	- ng-controller
<p>
- 事件處理
	- ng-blur
	- ng-focus
	- ng-copy
	- ng-paste
	- ng-cut
	- ng-change
	- ng-checked
	- ng-click
	- ng-dbclick
	- ng-keydown
	- ng-keypress
	- ng-keyup
	- ng-mousedown
	- ng-mouseenter
	- ng-mouseleave
	- ng-mousemove
	- ng-mouseover
	- ng-mouseup
<p>
- 外觀與樣式
	- ng-show
	- ng-hide
	- ng-style
	- ng-class
	- ng-class-even
	- ng-class-odd
<p>
- HTML 增強／表單
	- a
		- ng-href
	- select
		- ng-option
		- ng-selected
		- ng-multiple
	- ng-open（ details ／ summary ）
	- img
		- ng-src
		- ng-srcset
	- form
		- ng-form （允許巢狀表單）
		- ng-submit
	- input
		- ng-disabled
		- ng-readonly
	- input[email]
	- input[number]
	- input[text]
	- input[url]
	- input[checkbox] , input[radio]
		- ng-checked
		- ng-value
<p>
- 範本引擎
	- ng-include src
	- ng-script
<p>
- 其它
	- ng-if
	- ng-switch
	- ng-pluralize
	- ng-transclude
	- ng-csp


<br><br><br><br><br>
*參考資料：*

*[AngularJS 官網](http://angularjs.org)、*

*[AngularJS 維基百科](http://zh.wikipedia.org/wiki/AngularJS)、*

*[AngularJS 入門簡介](http://www.slideshare.net/kurotanshi/angularjs-31606698)*

*[Day1-Day30：入門AngularJS筆記與前端領域的學習筆記分享介紹](http://ithelp.ithome.com.tw/question/10132196)、*
___

##[法律專欄]簡論自由開源軟體的著作權適格及其態樣##

林誠夏、葛冬梅／文

自由開源軟體專案 (Free and Open Source Software Project, FOSS Project)，其在著作權法上的保護地位，與一般電腦程式無異，因電腦程式受法律保護所必須具有的創意性與科學性，在 FOSS Project 上一項也不缺少，然而，FOSS Project 的撰寫與創作過程，卻迥異於一般傳統的私有軟體 (proprietary software)，以至國際間許多與自由開源軟體相關的司法訴訟，其在進行初始法律關係的分析時，亦不乏從其著作權類型如何歸屬討論起，例如 2011 年德國柏林地方法院 AVM vs Cybits 一案的判決，便曾在言詞辯論時，就嵌入式韌體裝置上各元件應歸類於哪一種著作類型而展開討論（註一）。

那麼就國內現行的著作權法規範，應如何給予自由開源軟體定性，以最適切的方式來解決 FOSS Project 實務上可能涉及的繁複著作權利分配問題，而若現行法律有所不足處，未來在增修上應如何調整，便為本文主要的探討主題。

![德國柏林地方法院 AVM vs Cybits 一案之二審確定判決書](http://www.openfoundry.org/images/140429/lg-urteil-20111118.pdf_001.png)  
▲ 圖1：德國柏林地方法院 AVM vs Cybits 一案之二審確定判決書

###【電腦程式在國內法律的保護適格】###

電腦程式在台灣的保護，主要是以著作權法 (Copyright Act) 為其基礎法律 (general law)，其並沒有獨立設立軟體保護的特別法 (special law) 來規範，而是在著作權法中設置予電腦程式適用的專門條款來進行規範。而一般來說，在台灣電腦程式要受到著作權法保護的門檻並不高（註二），主要是：

1. 必須能夠證明該電腦程式的寫作過程，並非是機械化、純數理過程的推展與呈現；其次是，
2. 此一電腦程式的創作過程仍具有創作人智慧的投入，則已足。

故絕大多數的電腦程式創作，都是受到著作權保護的，並且依照著作權法第 10 條預設的「創作保護主義」：「著作人於著作完成時享有著作權。」一個電腦程式只要是著作人的智慧結晶，便自動可以取得著作權法下的保護適格，著作人毋須透過任何額外程序的登記，或是申請來取得著作權利，且無論這個電腦程式是以自由開源軟體的授權方式，亦或是採私有軟體的授權方式進行後續的應用。

###【當前著作權法無法完全適切對自由開源軟體授權程式進行型態分類】###

然而，FOSS Project 對於當前著作權法的挑戰在於，其之編撰方式與流程，為一個多人共工、聚沙成塔，且不斷吸納參與者智慧貢獻的著作權客體，這和當前既定著作權法對於電腦程式創作所想像的預設過程有著相當大的落差。一般來說，現行台灣著作權法第 8 條的共同著作 (joint work) 與第 6 條的衍生著作 (derivative work)，是二個最有可能被拿來比附援引、了解 FOSS Project 權利分配狀況的著作型態，然而這二個著作權法預設的著作類型，與自由開源軟體的實際開發狀態，在對比上亦各有各自的欠缺與不同。此外，著作權法第 7 條的編輯著作 (compilation work) 規定，著作經選編之後，視為獨立的著作權利客體，因此編輯著作也可能是另外一個用來比附援引 FOSS Project 的著作型態。然此編輯著作的編輯過程須有選編上的創意性，並且權利保護期間另行起算；但程式元件彼此間常見的集合型態 (aggregation)，有時選編上並未具創意性，而僅是功能上的結合，若僅因為純粹功能性的搭配，就讓結合後的專案取得編輯著作獨立的保護地位，並f另行起算完整的權利保護期間，恐怕更不是一個合乎法律論理的分類方式。

###【將自由開源軟體以共同著作的方式解讀】###

依著作權法第 8 條規定：「二人以上共同完成之著作，其各人之創作，不能分離利用者，為共同著作。」所以原生的 FOSS Project，創作人彼此間若具有充份共同創作意思的聯繫與互動，則該專案便會被認定為共同著作，而能夠適用共同著作在著作權法裡，預先設定的各項機制。然而該 FOSS Project 如繼續被其他參與者進行修改，其後的著作權利如何進行分配，就是一個饒富趣味且值得討論的問題。因為其後此一 FOSS Project 的接力參與者，可能僅依循授權規則與開發風格 (coding style)，便以程式碼撰寫接力的方式來繼續進行電腦程式的協作，這是一種「未必經過溝通協調的合作模式 (cooperation without coordination)」，此點與現行著作權法對於共同著作的定義，似乎並不能說是完全相合。因傳統上對於共同著作的解釋，旬認為共同著作人之間，對於共同著作應具有共同創作意思之溝通與聯繫，此一認知和多數 FOSS Project 的運作狀態，便有了相當的落差。

###【將自由開源軟體以衍生著作的方式解讀】###

FOSS Project 經過一定程度的增補與改作之後，將有機會形成著作權法第 6 條所定義之衍生著作，並依法得以獨立著作之地位保護之。因為依著作權法第 28 條規定，著作的改作權專有於原著作的著作財產權人，然而只要是 FOSS Project，其皆透過授權條款的預先聲明，將原專案的改作權授權予後續專案的改作者，所以在自由開源軟體的開發歷程裡，後續專案被認定為前手專案的衍生著作，此一模式可說高度符合著作權法在衍生關係上建立的法律架構。然而傳統上對於衍生著作的解釋，亦要求衍生程式與原生程式之間必須要有相當創意性的改作，方才能夠成為一個具獨立著作權保護地位的衍生著作，此一標準和多數自由開源軟體專案的持續開發歷程或有相當落差，因為在相當期間裡，許多 FOSS Project 的參與者，是就原生程式漏洞進行修補與小功能的改寫，這些微量的程式碼貢獻單筆單筆區分來看，其創意性皆不足以獨自成為著作權保護的客體，但經歷一段時間與數量的累積後，卻可能統合為一個更新版本的電腦程式專案，這是一種透過眾人持續貢獻累積程式碼所造成的改作模式，此點與現行著作權法對於衍生著作的定義亦不完全相同。

###【試將共同著作與衍生著作型態依自由開源軟體的開發實務套用之】###

從上所述，可以發現，要單純以個別共同著作或是衍生著作的分類與型態，套用到 FOSS Project 的開發上，都各自有所欠缺。然而，若是依著 FOSS Project 的開發實務，以分時序與參與序的階段化方式，再配合成熟的 FOSS Project 皆會定期改版釋出的特性來解釋，則共同著作與衍生著作的型態，便可以合法合份的套用到 FOSS Project 這種特殊型態的軟體著作上：

1. 原生的 FOSS Project，創作人彼此間若具有充份共同創作意思的聯繫與互動，則該專案便可先被認定為共同著作；而或者雖然創作人彼此之間，可能沒有直接聯繫討論的關係，但卻可以援引自由開源軟體授權條款的預先公示性，解釋此些條款的預先揭示與認同，即已充足「共同創作意思聯繫與互動」之條件，因創作人在加入 FOSS Project 的開發之際，必然已經對授權條款的預訂內容有所認定，再者，個別專案亦有相應的參考文件，可讓其依循其他共同創作者認同之開發風格與除錯回報流程，故此時便可擴大解釋，將此 FOSS Project 初始版本的 version 1.0 認定為所有共工編寫者之共同著作。
2. 其後此一 FOSS Project 接續被後續參與者提報 bug 與除錯，並不斷的被加寫新的功能與元件，在創作過程中，如果僅是針對原生程式漏洞進行修補與小功能的改寫，這些微量的程式碼貢獻單筆單筆區分來看，皆毋須獨自認定為受著作權保護的獨立客體，因此時創意性與完整性並不成熟，然而，在經歷一段時間與數量的累積後，該 FOSS Project 正式釋出更新版本的 version 2.0 時，再將 version 2.0 視為著作權法第 6 條所定義之衍生著作，而原先第一版本 version A 中的程式碼，若有未經改寫予以保留的部份，則在 version A 裡這些程式碼的創作人，則與 version B 開發歷程中的參與者與投注者，一起列名為 version B 這個衍生程式的共同著作人；而若是 version A 版本的創作人，亦一起參與 version B 之實作時亦同。也就是說，該 FOSS Project，於 version B 的釋出階段時，相對於 version A 是既衍生又共同的著作型態。

###【在編輯著作之外另行設立結合著作的類型以充實自由開源軟體的組成態樣】###

以上的運作模式，已幾乎可以善加處理 FOSS Project，在當前實務上涉及的繁複著作權利分配問題。然而，有時候 FOSS Project 的後續更新版本，僅是原封不動取用前一版本中部份的元件，例如函式庫 (library) 性質的電腦程式，並讓專案裡的其他元件，透過公開的應用程式介面 (application program interface, API) 來和這些函式庫互動，此一對原元件／函式庫的取用行為，能不能構成著作權法上的改作行為，則是迭有許多不同的法律見解，有些論者將這樣的利用狀態定義為德國著作權法第 9 條的結合著作 (Compound Work)，或可能是美國著作權法第 101 條項下的編輯著作（Collective Work，註三）。但基於目前國內的著作權法，並沒有如同德國著作權法有明定 Compound Work 的型態，也沒有美國著作權法 Collective Work 的設計，故此種狀況在台灣司法實務上，最有可能的認定方式，便是將其認定為著作權法第 7 條編輯著作的型態，而後再依編輯著作的相關規定進行利用。然而，進一步探究現行編輯著作的立法原則，是要求素材在選編過程之中必須具有創意性，才能在選編之後視為獨立的著作權客體來進行保護，而實務上，多數 FOSS Project 項下的各獨立元件，僅是具有功能性取向的結合，例如許多自由開源性質的「內容管理軟體系統 (Content Management System, CMS)」，其在資料庫系統的配合與使用上，可使用 GPL-2.0 授權的 MySQL 資料庫，亦可使用其衍生的分支版本 MariaDB，除此之外，還有 BSD-like 授權的 PostgreSQL 資料庫，以及被權利人拋棄權利到公眾領域 (Public Domain) 的 SQLite 資料庫可以使用，這些 CMS 與資料庫軟體之間的結合運作，常常是不具有選擇上的創意性，單純僅就功能、運作效益與硬體資源限制的考量，若將此種結合型態視為一般的編輯著作，便讓結合後專案的權利保護期間另行起算，並取得著作權法上獨立的保護地位，恐怕亦非合乎法理邏輯的處置方式。

故建議是可以參酌德國著作權法第 9 條的規定（註四），將 FOSS Project 專案裡獨立運作元件彼此間的結合關係，視為一不同於編輯著作型態的結合著作 (Compound Work)。此時此結合著作並不會獨立取得一個著作權的保護地位，而是被視為不同的著作客體因共同利用的目的，而進行功能性或互補性地位的結合。原則上結合著作裡的個別著作人，要對結合著作進行公開發表、經濟利用，以及內容的修改時，仍然需要得到其他結合著作權利人的同意方可為之，但其他結合著作權利人沒有正當理由者，亦不得拒絕之。可以說，德國著作權法此一結合著作的型態，核心要處理的是這些因功能性結合的著作，其個別著作權利人的內部關係，而不是另行創生另一個統合的著作權客體，所以從 FOSS Project 的實際編撰模式與社群運作典範來看，確實此種著作類型，會更符合自由開源軟體的開發模式，亦不會與現行著作權法的其他機制產生嚴重的衝突。

大體來說，就國內著作權法目前的現行規定，依 FOSS Project 在開發期程上的歷程與階段，可將其類推為共同著作或原生專案的衍生著作來看，在法律架構上並不會產生本質上的衝突。原則上，多人同時同期分工創作且不可分別利用者，其成品可被歸類為共同著作，而若多人前後不同時期接力創作，其後的改作作品經不同版本的釋出後，可被歸類為衍生著作。故實務應用上，應先查驗特定 FOSS Project 在運作上的狀態，若是該專案的參與成員彼此在撰寫分工上具有高度合意與互動，則可依民法第 1 條類推適用的法理，優先讓其比附援引共同著作的相關規定，而若該專案為其他 FOSS Project 的後續版本，則可優先讓其類推適用於衍生著作的相關規定。然而，現行台灣著作權法對著作物型態的預設分類，並不能完全契合自由開源軟體的運作特性，主要就是在結合著作的類型上有所欠缺，所以實務上還必須輔以授權條款個別內容的解釋，與著作權法相關條款的類推適用 (mutatis mutandis)，才能運作順暢，而日後著作權法在修改上，亦可參酌德國著作權法關於結合著作的運作型態，來充實此一缺漏，並補充現行法律在著作型態界定上的不足（註五）。

----

註一：就本案進行訴訟參與的歐洲自由軟體基金會成員，德國執業律師 Till Jaeger 博士於言詞辯論指出，嵌入式韌體裝置中與 GPL 授權元件相融合在一起的程式元件，應為 GPL 授權元件之衍生著作，而其他可分割出來獨立運作的元件，則與 GPL 授權的衍生著作合併為德國著作權法第 9 條之結合著作 (Compound Work)。此判決進一步的相關資訊，可見歐洲自由軟體基金會整理的案件報導：[http://fsfe.org/activities/ftf/avm-gpl-violation.en.html](http://fsfe.org/activities/ftf/avm-gpl-violation.en.html)，以及確定的第二審德文判決書：[http://fsfe.org/activities/ftf/lg-urteil-20111118.pdf](http://fsfe.org/activities/ftf/lg-urteil-20111118.pdf)。

註二：依據現行著作權法第 5 條第 1 項第 10 款，以及第 3 條，第 10-1 條，關於著作定義與例示分類之規定。

註三：美國著作權法就 Collective Work 之外，亦同時對 Compilation Work 進行定義，其規範 Compilation 為 Collective Work 的上位概念，故某著作被分類為 Collective Work 時，其在美國法的認定上也必定為一 Compilation。部份譯者是將 Collective Work 語譯為「集合著作」，但因我國著作權法並沒有集合著作的用語，只有編輯著作的概念，故雖然著作權法是將編輯著作翻譯為 Compilation Work，此處還是將 Collective Work 一併譯為「編輯著作」，以表彰此種著作型態其在著作權法上受獨立保護的地位。

註四：德國著作權法第 9 條，其官方提供的正式英文譯文為，"Article 9 Authors of compound works: Where several authors have combined their works for the purpose of joint exploitation, each may require the consent of the others to the publication, exploitation or alteration of the compound works if the consent of the others may be reasonably expected in good faith."。該條德文原文內容為，"§ 9 Urheber verbundener Werke: Haben mehrere Urheber ihre Werke zu gemeinsamer Verwertung miteinander verbunden, so kann jeder vom anderen die Einwilligung zur Veröffentlichung, Verwertung und Änderung der verbundenen Werke verlangen, wenn die Einwilligung dem anderen nach Treu und Glauben zuzumuten ist."

註五：更多關於自由開源軟體在台灣著作權法架構上的相關分析，可參閱拙撰，國際自由開源軟體法律參考書台灣專章：[http://lucien.cc/doku/doku.php?id=essays_and_articles:the_international_free_and_open_source_software_law_book-taiwan_chapter:translation_version](http://lucien.cc/doku/doku.php?id=essays_and_articles:the_international_free_and_open_source_software_law_book-taiwan_chapter:translation_version)。而關於電腦程式在德國著作權法上所示用的態樣及相關分析，可參閱：Tim Engelhardt/Till Jaeger, *Germany* Chapter in: The International Free and Open Source Software Law Book (IFOSS Law Book), available at: [http://ifosslawbook.org/germany/](http://ifosslawbook.org/germany/) (Retrived April 29, 2014)。

___

##[源碼專案]PourOver 與 Tamper 簡介##

謝良奇／翻譯

◎本文翻譯自 The New York Times，原作者為 Erik Hinton 與 Ben Koski︰[http://open.blogs.nytimes.com/2014/04/16/introducing-pourover-and-tamper/](http://open.blogs.nytimes.com/2014/04/16/introducing-pourover-and-tamper/)

這一年多來，我們投入於  PourOver.js 與 Tamper 的研發。它們是運用在 Red Carpet 專案、乳癌面貌 (Faces of Breast Cancer) 與高層建築讀者故事 (High-Rise reader stories) 背後的內部程式庫。

現在，你可以在 [GitHub](https://github.com/nytimes) 上找到它們：

* PourOver.js：一套在瀏覽器中過濾、分頁、更新、排序資料集合的程式庫。

* Tamper：一套序列化 (serializing) 與壓縮分類資料 (categorical data) 的協定。

兩套專案都有完整文件，PourOver 更提供涵蓋基本功能的一系列範例。在 OpenNews Source 部落格上也有一篇[協同報導](https://source.opennews.org/en-US/articles/introducing-tamper-and-pourover)，詳述專案的演進。

我們在此想用一些很酷的例子，來展示上述專案能做到的事：

1.  你可以用 Boolean 操作串接過濾器。此種組合不需從頭到尾重複計算，只需花時間在找出過濾器索引的聯集、交集、差異即可。你可以拿顏色、尺寸大小、形狀過濾器，用它們找出紅或藍且不是方形的大號形狀：
	<pre><code>color_match_r = collection.filters.color.getFn("red") 
color_match_b = collection.filters.color.getFn("blue") 
size_match = collection.filters.size.getFn("big") 
shape_match = collection.filters.shape.getFn("square") 
big_red_non_squares = color_match_r 
.or(color_match_b) 
.and(size_match) 
.not(shape_match)</code></pre>

2. PourOver 允許混合單純的查詢與具有狀態的查詢。假如你需要的是一般的查詢，沒問題，過濾器不會記得上次 getFn 的結果。
	
	<pre><code>color_match = collection.filters.color.getFn("red")
    color_match.current_query // >> undefined</pre></code>如果你想要的是具有狀態的查詢，過濾器會記得你上次的 query 內容。
    <pre><code>collection.filters.color.query(“red”)
    collection.filters.color.current_query // >> [和紅色東西有關的 MatchSet]</pre></code>
    
3. 你可以輕鬆利用 PourOver 建立 view，儲存你目前的頁面以及上次的查詢。當資料集合中的項目有所更動、新增或刪除，這個 view 都會自動更新。

    <pre><code>view = new PourOver.view(“my_view”,collection,{page_size: 1})
    view.page(1) // 向右 1 頁
collection.addItems(new_items) 
// view 會持續分頁在之前的項目上，有必要的話會更新頁面。還有如果有新的項目合乎目前選擇的過濾器，就會自動加進 view 目前的項目當中。</pre></code>

4. 僅用 1KB ，Tamper 就能表達 1 萬張照片的分類資料：
[gist.github.com/bkoski/10779733#file-gistfile1-json](https://gist.github.com/bkoski/10779733#file-gistfile1-json)

我們期望這些程式庫能對你有所幫助。歡迎在 GitHub 上提出問題 (issue) 或提交 pull request。你也可以直接寫信到 erik.hinton@nytimes.com 或 bkoski@nytimes.com。不論內部或外界，這些程式庫都正受到積極的採用，它們可望持續演進：我們會在此發佈更新訊息或重大釋出。
___

##[源碼新聞] 電影也要開源創作：The Gooseberry Project 現正火熱進行群眾募資！##

黃郁文、林誠夏／編譯

魏德聖導演所監製的知名電影《[海角七號](http://zh.wikipedia.org/wiki/%E6%B5%B7%E8%A7%92%E4%B8%83%E8%99%9F)》中，錄有一段這樣的經典台詞：「**土地也要 BOT，山也 BOT，連海也要給我 BOT！**」現在，我們可以依樣造句的改為：「**軟體也要 Open Source，教材也要 Open Source，現在，連電影和藝術創作也要給我 Open Source！**」因為，現在正有一部電影，打算以開源工具與群眾募資 (crowdfunding) 的基礎來打造，並且在商業播放週期結束之後，還會進一步採創用CC 的方式對外散布，它就是 [Gooseberry Project](http://gooseberry.blender.org/wp-content/themes/gooseberry/)！


![圖1：Gooseberry Project](https://www.openfoundry.org/images/140429/Gooseberry_Cloudfunding_Campaign.jpg)  <br/><br/>
圖1：Gooseberry Project 募款首頁：[http://gooseberry.blender.org/wp-content/themes/gooseberry/](http://gooseberry.blender.org/wp-content/themes/gooseberry/)

Gooseberry Project 的幕後推手是 Blender Institute，而該組織的源頭，則是為了專職維護與持續開發[自由開源 3D 繪圖軟體 Blender](http://www.blender.org/download/)，而成立的非營利組織 Blender Foundation。相較於 Blender Foundation，Blender Institute 於 2007 年被另行成立的主要目的，是要以更具效率與組織化的手法，來促進開源 3D 電影、遊戲或特效的各項推展目標，而不再僅是將目光與心力聚焦於自由開源軟體專案的程式碼創作。

而此次的 Gooseberry Project 與 Blender Institute 先前數個小品電影作品不同之處在於，這將是一部完整的長篇劇情片, 並會有超過 12 組世界各地的獨立電影工作室參與製作，共工式地為影片注入多元風格與文化融合的特色！這些動畫工作室包含 Autour de Minuit、The Blender Institute、Character Mill、CG Cookie、David Revoy、Gecko Animation、Ideas Fijeas、Kampoong Monster、Studio Lumikuu、Mad Entertainment、Ovni VFX、Poked Studio、Pataz Studio，以及 Pitchi Poy、Vivify 等。

本片電影執導者為 Mathieu Auvray，劇情則由 Esther Wouda 以及 Mathieu Auvray 所共同撰寫。影片劇本與相關腳本的編寫目前仍在進行中，預計將於 8 月底定。主線劇情是由一隻追尋生活意義，名字叫作 Michel 的綿羊作為主角來擔綱演出，故事的預定架構，將會充滿歡笑，並以荒誕不經與歌頌冒險與愛的方式展開！

Gooseberry Project 預計約需耗時 18 個月完成，由於影片規模及幕後工作量之龐大均有別以往，故財政資源需求量也高，當前影片總預算粗估約需 3.5 – 6 百萬歐元。Blender Institute 除了以補助款及相關贊助經費來支應外，現亦正透過群眾募資的方式來向外進行資金籌措，預估需募集 10,000 位朋友的支持，並藉此充實 500,000 歐元的資金，來穩定電影製作後續的支出。

對 Gooseberry Project 有興趣的支持者與付款者，可透過此次的群眾募資，一併訂購 Blender Cloud 上的相關服務，以後續享有存取所有 Blender Institute 數位資源的回饋，這些資源包含 Blender 工具程式的訓練教材，以及先前所有開放電影的相關資料。此外，在 Gooseberry 製作期間，Blender Cloud 也會不斷同步更新電影的最新狀態，讓訂購者能隨時掌握影片動態，享受如同戲院貴賓席的特別禮遇！

最後，Gooseberry Project 所完成的電影作品，其著作權利將 100% 由電影製作者所擁有，然而影片收益，則會在支付完電影製作期間的各項必要支出之後，轉由所有協助完成電影的參與者所共享，其後，在電影熱銷期結束之後，所有影片後續的發行與散布，將會依照「[創用CC-姓名標示授權條款 (Attribution 4.0 International)](http://creativecommons.org/licenses/by/4.0/)」的規範與模式來進行，轉而將這些素材正式開源化，並讓後續的創作者可以取用，在此基礎上建立自己的衍生作品！

想成為 Gooseberry 貢獻者一員的話，可以至 [Blender Cloud 募款專頁](https://cloud.blender.org/gooseberry/)，選擇適合您的支持方案貢獻己力，以共同推動開源電影的嶄新創作風潮！




### 參考網址：

1. Project Gooseberry
    * [http://gooseberry.blender.org/wp-content/themes/gooseberry/](http://gooseberry.blender.org/wp-content/themes/gooseberry/)

2. Blender Open Movie－Gooseberry Project 預告片
    * [http://www.gemhorn.com/web/index.php/incg-shorts/item/484-gooseberry-project](http://www.gemhorn.com/web/index.php/incg-shorts/item/484-gooseberry-project)

3. Project Gooseberry 啟動, 尋求 10,000 支持者共同紀錄影片歷史
    * [http://www.blendernation.com/2014/03/09/project-gooseberry-launches-seeks-10000-supporters-to-write-film-history/](http://www.blendernation.com/2014/03/09/project-gooseberry-launches-seeks-10000-supporters-to-write-film-history/)

4. Blender Institute
    * [http://www.blender.org/institute/](http://www.blender.org/institute/)

5. Project Gooseberry 募款專頁–截止日 2014 年 5 月 8 日、格林威治標準時 17:00
    * [https://cloud.blender.org/gooseberry/](https://cloud.blender.org/gooseberry/)

6. Prject Gooseberry–預定以「[創用CC-姓名標示](http://creativecommons.org/licenses/by/4.0/)」方式釋出的開源動畫長片
    * [https://creativecommons.org/weblog/entry/42518](https://creativecommons.org/weblog/entry/42518)
___

##[源碼新聞]美政府開放資料政策推動太空總署釋出千個開源軟體

編譯／四貓

NASA 日前宣佈建立開放原始碼的[NASA技轉資料庫](http://technology.nasa.gov/)，該網站在四月十日正式上線，目前已公開了超過一千個應用程式的原始碼，不論是企業、學界、政府機關或是普羅大眾皆可取用。NASA 的副首席科學家 Jim Adams 表示目前在機構的知識資產集中，軟體的重要性日漸提高，也對能將軟體開放給大眾取得而感到興奮。這些釋出的軟體中，分成了很多不同的目錄，包括專案管理系統、設計工具、資料處理…等等，每個項目都是 NASA 執行複雜任務的最佳方案。不過這些原始碼也並非全無限制的開放所有人任意取得，經過專家評估之後，有的原始碼限制美國公民才可取得，有的則是只有聯邦政府機關才可取得。

Adams表示，提交這些原始碼是遵循[開放政府](http://www.whitehouse.gov/open)的政策，希望透過讓大眾取得原始碼的方式來鼓勵創新與創業，並讓這些研究成果不只用於太空探索，也讓地球上的人民同樣獲益。美國政府近幾年在推動政府的開放資料上成效卓著，最早是 2008 年開始，美國聯邦政府推動開放政府資料，其後歐巴馬總統於 2009 年上任之時簽署了《透明與開放政府備忘錄》（Memorandum on Transparency and Open Government），其中提到政府的開放資料行動應符合「透明」（transparency）、「參與」（participation）和「合作」（collaboration）三項方針，期待政府的運作可以更加公開透明，帶起公眾參與和協同合作的風氣。除了推出開放資料網站之外，更在  Github 上建立了名為 Project Open Data 的專案，將專案的內容與經營由政府獨力編撰逐漸導入為社群成員的共同參與，這樣的行動不但具有多人共工、協同合作的開源精神，而且高度的互動性也更深化了民主政體的發展。

除了開放政府資料外，白宮方面還有一些相關的改變，說明美國政府擁抱開源的行動，包括白宮網站改採開放源碼技術，不但降低了網站成本，更增添了網站的彈性和安全性我不知道欸  回去研究看看；以及倡議讓政府出資的研究成果可被開放存取（Open Access），不過該草案目前仍在審查當中。

另外，美國政府在開放資料的執行實務面，除了單純釋出資料之外，亦要求開放資料應為可供機器閱讀的開放格式，並且採用公開授權，不但方便民眾利用與檢索，也促進民間對資料的應用發展。



參考資料：

* [NASA's Tech Transfer program](http://technology.nasa.gov/)

* [New Catalog Brings NASA Software Down to Earth](http://www.nasa.gov/centers/marshall/news/news/releases/2014/14-057.html#.U0tW1FSSylg)

* [美國白宮網站翻新 改採開放源碼技術](http://www.openfoundry.org/tw/foss-news/2198)

* [美國總統歐巴馬發布行政命令支持開放資料](http://www.openfoundry.org/tw/foss-news/9017-2013-07-03-06-01-29)

* [讓NASA科技回到地球、成為現實](http://www.nasa.gov/centers/marshall/news/news/releases/2014/14-057.html#.U0tW1FSSylg)

* [美國白宮開放政府推動網頁](http://www.whitehouse.gov/open)
___

##[源碼新聞]分支 LibreSSL 創造者宣稱，OpenSSL 程式碼沒法修了##

謝良奇／編譯

◎本文翻譯自 ars technica，原作者為 Jon brodkin︰[http://arstechnica.com/information-technology/2014/04/openssl-code-beyond-repair-claims-creator-of-libressl-fork/](http://arstechnica.com/information-technology/2014/04/openssl-code-beyond-repair-claims-creator-of-libressl-fork/)

OpenBSD 創辦人 Theo de Raadt 建立了 OpenSSL 的分支，OpenSSL 就是包含眾所皆知 Heartbleed 安全漏洞的知名開源加密軟體程式庫。儘管被許多世界上最大且最富有公司運用在網站與產品中，OpenSSL 卻飽受缺少資金與程式碼貢獻之苦。

鑑於 OpenSSL 早已運用在數十萬網站伺服器中，分支 OpenSSL 的決定勢必引發爭議。被問到為何要重頭開始，而不協助改善 OpenSSL，de Raadt 表示現存的程式實在太亂了。

在電郵中，de Raadt 對媒體表示，他們的團隊在一周內移除了大半的 OpenSSL 源碼樹。留下的就像剩菜一般。開源模式有賴於能夠讀懂程式碼的人們。清楚明白是一大關鍵。而這並不是一份清晰的程式碼基礎，因為他們的社群顯然不關心清晰度。這個決定並不是我下的，它是自然而然出現的。

LibreSSL 程式碼基礎位於 OpenBSD.org，專案由 OpenBSD 基金會與 OpenBSD 專案提供金援。LibreSSL 有個陽春的網站，而且顯然是故意弄的一點都不吸引人。

該網站表示，這個網頁是費心地設計來惹怒網頁時尚人士，請捐款以停止 Comic Sans 字體與閃爍標籤。在解釋分支決定時，該網站連接到 Twisted Sister 歌曲「絕不忍耐」 (We're not gonna take it) 的 YouTube 影片。

LibreSSL 最初是為 OpenBSD 所建立，在程式碼與資金穩定之後，將支援多種作業系統。OpenBSD 作業系統本身即為在 1995 年創造的 NetBSD 分支。

被問到說 OpenSSL 包含留下的剩菜是什麼意思時，de Raadt 表示有數千行的 VMS 支援。數千行的古老 WIN32 支援。今天，Windows 已經有類似 POSIX 的 API，不再需要針對 sockets 有特別的處置。數千行的 FIPS 支援，更是會幾乎自動地調降密碼。

De Raadt 說，這裡有數千行 API，OpenSSL 團隊早在 12 年前就想揚棄，不過卻依然存在。他說，他的團隊移除了 9 萬行程式碼。即使歷經這些更動，該程式碼依然具備 API 相容性。我們整個 ports tree （有 8700 個應用程式）在這些更動後，還是可以編譯並且運作。

OpenBSD 團隊是在一周前開始投入 LibreSSL。OpenSSL 軟體基金會總裁 Steve Marquess 拒絕對 LibreSSL 表示意見。Marquess 表示還沒有機會了解他們的工作，因此不希望加以評論。

在一篇部落格文章中，Marquess 描述了 OpenSSL 在取得金援與程式碼貢獻上的困境。Marquess 寫到，我在看著你，Fortune 一千大企業。那些把 OpenSSL 納入你的防火牆、應用設備、雲端、財務、安全產品，加以販售獲利或使用來保障你內部架構與通訊的人。那些不必花錢設置自家團隊來撰寫加密程式，只想在不知道如何使用時，向我們索求免費顧問服務的人。以及那些從未動過一根手指貢獻開源社群的人。你自己知道我在講你。

對於 Heartbleed，Marquess 表示，神奇的不是少數過勞自願者看漏了這個臭蟲，而是為何這種錯誤並非經常發生。

可能暴露用戶密碼與保障網站之用的私有加密金鑰的 Heartbleed 漏洞，被一名自願貢獻者意外地加入程式碼中，並且在 2 年內都沒被發現。
___

##[源碼新聞]想學如何貢獻 Linux 核心，參加 Eudyptula 挑戰吧##

謝良奇／編譯

◎本文翻譯自 Linux.com，原作者為 Libby Clark︰[http://www.linux.com/news/featured-blogs/200-libby-clark/770112-learn-how-to-contribute-to-the-linux-kernel-take-the-eudyptula-challenge/](http://www.linux.com/news/featured-blogs/200-libby-clark/770112-learn-how-to-contribute-to-the-linux-kernel-take-the-eudyptula-challenge/)	

想貢獻 Linux 核心卻不知如何開始？Eudyptula 挑戰是測試你程式設計技巧，並且學習如何參與核心社群的好方法。

約一個月前出現在線上的這個[挑戰](http://eudyptula-challenge.org/)，是由以小企鵝為名的某匿名黑客 (或一群黑客) 所創造的，希望讓更多開發者參與 Linux 核心。該挑戰以 Matasano Crypto 挑戰為藍本，Matasano Crypto 挑戰共有 48 道習題，教導參與者加密系統如何建構與如何受到攻擊。Little Penguin 表示，Eudyptula 挑戰並非教學，但是透過完成該挑戰，你可以對整個核心貢獻過程的運作獲得理解。

挑戰的參與者透過發電郵給 Little Penguin 來註冊，Little Penguin 會回覆參加者一系列 Linux 核心開發者經常會碰到的程式設計任務。參加者一次會收到一個任務，必須完成之後 Little Penguin 才會再送下一個。挑戰本身沒有獲勝者，但成功完成 20 項任務人，代表已經準備好作為 Linux 核心貢獻者。

我們最近透過電郵跟 Little Penguin 聯繫，了解更多有關該挑戰的內容。你可以發送一封非 HTML 的電郵到 little at eudyptula-challenge.org，來註冊該挑戰。


**Eudyptula 挑戰是什麼？**

Eudyptula 挑戰是有關 Linux 核心的一系列程式開發習題。這些習題從非常基本的「Hello world」 核心模組開始，然後一步步越來越複雜。


**為何創立此挑戰？**

這個點子是我們喝了一整晚之後想到的，很確定的是如果 Linux 核心要繼續存續，就需要新的程式設計者來修這些喝了一整晚之後加入的臭蟲。


**挑戰何時開始，會持續多久？**

你想要開始的時候就開始。只要遵照網站的指示，你的第一個任務就會電郵給你。目前有 20 個不同任務要完成。如果你可以全部完成，已經有一組新的任務正在設計中，可以滿足那些做完後要求更多任務的人。


**全都透過電郵嗎？不是有網站表單可用？**

是的。核心開發全都透過電郵，因此設定能好好發送 Linux 核心修補的電郵用戶程式，可說是所有核心開發者必學的技能。還有，透過電郵提交修補與程式以及回應評論，這樣來來回回的過程，對所有核心開發者都一樣。這項挑戰試圖盡可能地複製 Linux 核心開發者的經驗。


**誰應該參與挑戰？**

所有有興趣解決各種與 Linux 核心相關的程式設計任務的人。


**在參與之前我要準備什麼？**

你需要對 C 有堅實的理解。還有，這個挑戰並非教學。雖然會有完成任務的提示，以及哪裏可以找到更多資訊的指引，但是你自己必須做許多功課。


**如果我完全不懂 Linux 核心開發，這個挑戰會教我如何貢獻嗎？**

是的。有一些任務和送修補到 Linux 核心樹有關。結束挑戰之後，你會有足夠技能並且了解如何貢獻核心。


**有獲勝者嗎？完成挑戰之後我會有獎品嗎？**

因為這並不是同時起跑並限定時間的任務，因此也沒有獲勝者。有些人已經完成目前的任務集，而且每天都有新參加的人。

傳聞 Linux 基金會或許會提供獎品給完成這個挑戰的所有人。你只需要完成挑戰，親自看看究竟獎品是什麼。


**完成挑戰是不是代表我有資格當核心維護者？**

你會有資格指出你喜愛的維護者造成的核心開發上的問題。這通常比起當核心子系統維護者要有趣得多。


**這對我的履歷有加分嗎？我可以因此拿到工作嗎？**

把這放在你的履歷上應該不會有害，但我懷疑看的人會不會知道這是什麼。談到工作，有許多 Linux 核心開發者的工作。如果你完成所有任務，沒有理由你沒辦法輕鬆找到一個全職做這件事的職位。


**你認為為何會收到如此廣大的迴響？聽說已經有 2000 人參加了。**

這個挑戰收到很大的迴響，遠比我想像的多。目前有超過 2400 人參與挑戰，每天都在增加。

很多時候，人們在談到核心程式設計時，只是不知道他們要做些什麼。這些任務強迫他們在龐大的核心源碼樹到處摸索。如果沒有特別的任務，多數人不會想看這些核心的各領域如何運作。


我們還聽說，有個大學的程式設計小組舉辦了一個黑客活動，讓他們所有成員在週末全都參與這個挑戰，結果如何？

這個挑戰是以個人為基礎，所以該大學小組還是必須個人解決自己的任務。他們的團隊大約 10 人，在同一個地方工作。雖然其中沒有人能在一個週末完成所有任務，不過聽起來他們蠻享受其中過程。
___

##[源碼新聞]2014 年五月份社群活動列表##

OSSF 電子報團隊／整理

涼風徐徐的吹來，舒服地打在臉上~各位朋友是否感受到夏天即將到來了呢？五月份的活動謝表出爐囉！有興趣的朋友們請多多邀請您的朋友們一同前往參與！另外，由於活動列表出來的時間比較早，若後續有活動希望也能一起做宣傳的朋友們，記得來信告訴我們喔！信箱： ossfepaper@openfoundry.org 。


###KSDG 高雄開發者社群 (Kaohsiung Software Developer Group) meetup（5/1）
###

- 時間：19:00~21:00
- 地點：高雄軟體園區 B 棟 708 室（高雄市前鎮區復興四路 2 號 7 樓之 5）
- 社群網址：[https://www.facebook.com/groups/KSDGroup](https://www.facebook.com/groups/KSDGroup)
###Hacking Thursday（每週四，5/1、5/8、5/15、5/22、5/29） 

- 時間：19:30~22:30
- 地點：台北市大安區建國南路一段 166 號 2 樓 (伯朗咖啡館建國店)
- 活動資訊：[http://www.hackingthursday.org/](http://www.hackingthursday.org/)

###MozTW Lab @ TP（每週五，5/2、5/9、5/16、5/23、5/30）###

- 時間：19:00~23:00
- 地點：台北市大安區八德路二段 3 號（蛙蛙書店）
- 活動資訊：[https://groups.google.com/group/moztw-general](https://groups.google.com/group/moztw-general)

###Taipei Wikipedian Weekly Meetup: Community Operation 維基台北定期聚—社群經營工作雙週聚（每週五，5/2、5/9、5/16、5/23、5/30）

- 時間：19:00~21:00
- 地點：台北市大安區八德路二段 3 號（蛙蛙書店）
- 活動資訊：[http://zh.wikipedia.org/zh-tw/WP:WPTP-S](http://zh.wikipedia.org/zh-tw/WP:WPTP-S)


###TOSSUG BoF（每週二，5/6、5/13、5/20、5/27）

- 時間：18:00~22:30
- 地點：台北市中正區羅斯福路三段 284 巷 5 號 2 樓（Ville Cafe）
- 活動資訊：[http://www.tossug.org/](http://www.tossug.org/)


###MozTW Lab @ 基隆（每週三，5/7、5/14、5/21、5/28） 

- 時間：19:00~21:00
- 地點：基隆市仁愛區港西街 4 號 1 樓（1915 海洋咖啡館）
- 社群網址：[https://groups.google.com/group/moztw-general](https://groups.google.com/group/moztw-general)


###Cocoaheads - Kaohsiung（5/8）

- 時間：19:00~21:00
- 地點：高雄市前鎮區復興四路 2 號 7 樓之 5（高雄軟體園區 B 棟 708 室）
- 社群網址：[https://www.facebook.com/groups/cocoaheads.kaohsiung/](https://www.facebook.com/groups/cocoaheads.kaohsiung/)


###Taipei Wikipedia Moonthly Meetup: Writing Day 維基台北定期聚—假日寫作月聚（5/10）

- 時間：14:00~16:00
- 地點：台北市松山區南京東路二段一號（伯朗咖啡 南京二店二樓）
- 活動資訊：[http://zhwp.org/zh-tw/WP:WPTP-W](http://zhwp.org/zh-tw/WP:WPTP-W)


###玉里維基寫作（5/10）

- 時間：19:30~21:00
- 地點：台灣花蓮縣玉里鎮民權街58巷6號（酸柑咖啡）
- 活動資訊：[https://www.facebook.com/events/258313251013823/](https://www.facebook.com/events/258313251013823/)


###WoFOSS 第 43 次聚會（5/15）

- 時間：19:30~22:00
- 地點：台北市松山區民生東路三段 140 巷 11 號（果子咖啡）
- 活動資訊：[http://wofoss.kktix.cc/events/wofoss044-201404](http://wofoss.kktix.cc/events/wofoss044-201404)


###KSDG web course（5/17）

- 地點：高雄軟體園區 B 棟 708 室（高雄市前鎮區復興四路 2 號 7 樓之 5）
- 社群網址：[https://www.facebook.com/groups/KSDGroup](https://www.facebook.com/groups/KSDGroup)


###PyCon APAC（5/17、5/18）

- 時間：8:00~17:00
- 地點：台北市南港區研究院路 2 段 128 號（人文社會科學館）
- 活動資訊：[http://tw.pycon.org/2014apac/zh/](http://tw.pycon.org/2014apac/zh/) 


###CTLUG (Central Taiwan Linux User Group) meetup（5/17）

- 時間:14:00~16:30
- 地點:台中市北區錦新街 42 號 2 樓（HexBase）
- 活動資訊：[https://ctlug.hackpad.com/](https://ctlug.hackpad.com/)
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