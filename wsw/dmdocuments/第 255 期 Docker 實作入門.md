___
 
□■□ 自由軟體鑄造場電子報第 255 期 | 2014/12/16 □■□
___
 
◎ 本期主題︰Docker 實作入門
 
◎ 訂閱網址︰[http://www.openfoundry.org/tw/news/](http://www.openfoundry.org/tw/news/)
 
◎ 下次發報時間︰2014/12/30
 
#本期內容#
___


##[技術專欄] Docker 實作入門


黃儀銘／文


### 目的
主要介紹 Docker 的實作，會提到以下幾個部分：


 1. 建立 Docker container
 2. 管理 Docker 上的 container
 3. 下載 image 、commit 建立新的 image
 4. 經由撰寫 Dockerfile 來自動建立新的 image


在進入實作前，會簡單介紹 Docker 與虛擬化的差異、Docker 上的重要元件，接下來準備的部分會需要安裝 Docker 及先登入 Docker Hub。


###簡介 Docker
**Docker** 是一個開源專案，支援多平台，從筆電到公、私有雲上能進行快速部署輕量、獨立的作業環境。**Docker** 使用 Linux 核心中的功能，Namespace 及 Control Groups (cgroups) 等，來達到建置獨立的環境及控制 CPU 、Memory 、網路等資源。


![Docker logo](http://www.openfoundry.org/images/141209/large_v.png "Docker logo")


> **專案網址：** http://www.docker.com/
 
### Docker Container 與虛擬化的不同
在前面敘述有提到，Docker 能提供建置獨立的環境，但是運作的方式與虛擬化有所差別。


#### 虛擬化
虛擬化通常都是透過在 Host OS 上安裝 hypervisor ，由 hypervisor 來管理不同虛擬主機，每個虛擬主機都需要安裝不同的作業系統。


![Virtualization diagram](http://www.openfoundry.org/images/141209/Virtualization_architecture拷貝.png "Virtualization_architecture.png")


#### Docker Container
Docker 提供應用程式在獨立的 container 中執行，這些 container 並不需要像虛擬化一樣額外依附在 [hypervisor](http://en.wikipedia.org/wiki/Hypervisor) 或 guest OS 上，是透過 Docker Engine 來進行管理。


![Docker container daigram](http://www.openfoundry.org/images/141209/Container_architecture拷貝.png "Container_architecture.png")


### Docker 重要元件
在進入如何操作 Docker 前，先介紹 Docker 中的三個主要部分：


 - **Docker Images**
image 能開啟 Docker container，但是 images 是唯讀的，也就是直接 結束 container 後，在 container 變更的資料並不會儲存在 image 內，但是 Docker 能對變更後的 container 建立 image。
 - **Docker Containers**
**Docker Containers** 提供獨立、安全的環境給應用程式執行，container 是從 Docker image 建立，運行在主機上。
 - **Docker Registries**
將 **Docker images** 上傳、下載到公開或私有的 **Docker Registries** 上，與其他人分享，公開的像 **Docker Hub** 提供了許多不同的 images ，如：Ubuntu 或 Ubuntu 環境下安裝 Ruby on Rails 的 images ，只要下載來，就能直接開啟成 container。


### 操作 Docker 方法
Docker 主機上會運行 Docker daemon，也能開啟許多 container。
要對 Docker 進行操作，使用 Docker client，也就是 Docker 指令 (例如：`docker pull`, `docker images` ...) ，分別可以藉由：


 1. [UNIX sockets](http://en.wikipedia.org/wiki/Unix_domain_socket)
 2. 網路 ([RESTful API](http://en.wikipedia.org/wiki/Representational_state_transfer))
 
對主機上的 Docker daemon 進行控制，當然 Docker client 與 Docker daemon 可以是同一台或不同主機上 。


![Docker client & Docker daemon](http://www.openfoundry.org/images/141209/docker-server-client拷貝.png "docker-server-client.png")


> **參考 Docker Remote API :**
>
> Docker Remote API - Docker Documentation
> https://docs.docker.com/reference/api/docker_remote_api/


###準備


本篇文章實作版本：**Docker 1.3.2**




#### 1. 安裝


接下來我們先在主機上安裝 Docker：


**Ubuntu**


安裝：
```sh
$ sudo apt-get update
$ sudo apt-get install docker.io
```


測試一下是否安裝成功：
```sh
$ sudo docker info
Containers: 0
Images: 0
Storage Driver: aufs
 Root Dir: /var/lib/docker/aufs
 Dirs: 3
 ...
```




**Mac OS X, Windows**


在 Mac OS X 或 Windows 上需要安裝 **Boot2Docker** ，因為 **Docker Engine** 有用到 Linux 的特定功能，所以 **Boot2Docker** 會用 Virtualbox 建立 Linux VM ，在 Linux VM 上開啟 **Docker** daemon 由在 Mac OS X 或 Windows 的 **Docker** client 去操作Linux VM 上 **Docker** daemon *(後面會在詳述)*。


> **Boot2Docker 安裝參考：**
>
> Mac OS X : https://docs.docker.com/installation/mac/<br>
> Windows : https://docs.docker.com/installation/windows/


備註：在 Mac OS X 與 Windows 執行 `docker` 指令不用加上 `sudo`


####2. 註冊及登入 Docker Hub 帳號


在前面有提到 **Docker Hub** 上提供了許多 images 可以使用，先註冊 **Docker Hub** 帳號，網址：https://hub.docker.com/account/signup/


接著可以利用 `docker login` 來登入 **Docker Hub** ：
```sh
$ sudo docker login
```


> Username: [ENTER YOUR USERNAME]
> Password:  
> Email:  [ENTER YOUR EMAIL]
> Login Succeeded


### 一、操作 Docker Container


#### 1. 建立一個新的 Container
先來暖身一下，啟動一個 *CentOS 6* container，希望能執行指令來顯示今天的日期與時間。
使用 `docker run` 開啟一個新的 container：
```sh
$ sudo docker run centos:centos6 /bin/date
```


> Unable to find image 'centos:centos6' locally
> centos:centos6: The image you are pulling has been verified
> 511136ea3c5a: Pull complete
> 5b12ef8fd570: Pull complete  
> Status: Downloaded newer image for centos:centos6
> Mon Dec  1 03:25:41 GMT 2014


輸出結果的第 1 行到第 5 行是，因為 docker 主機上原來並沒有 centos6 的 image 檔案，所以會先從 Docker Hub 下載。


輸出結果的最後一行就是執行的 `date` 指令。另外可以發現，如果扣除下載 image 時間，開啟一個 container 只要非常短的時間。


 - `docker run` 啟動一個新的 container
 - `centos:centos6` CentOS 6.X (目前 CentOS 6 最新版為 6.6)。
`centos` 是 repo 名稱，`centos6` 是 repo 內 tags。
到 [Docker Hub 網站](https://hub.docker.com/)搜尋 *centos* 後，在 *centos* repo 頁面上就會呈現有哪些 tags 。


![Docker client](http://www.openfoundry.org/images/141209/docker-server-client拷貝.png "centos_Repository___Docker_Hub_Registry_-_Repositories_of_Docker_Images.png")


 - `/bin/date` 開啟 container 後執行的指令


`docker run` 還有其他參數可以進入 container 的終端機指令互動模式下：
```sh
$ sudo docker run -t -i centos:centos6 bash
```


*[進入 container...]*


```sh
[root@ea27583b1dba /]# whoami
root
```


 - -t 開啟 tty 進入 container
 - -i 透過 STDIN 與 container 進行互動


該如何離開 container 的終端機？


 1. 輸入 `exit` 或按 `control/Ctrl` + `D`，目前使用的這個 container 就會結束，而下次在開啟的 container 又是一個全新的。
 2.  `control/Ctrl` + `P`，再按 `control/Ctrl` + `Q` ，就可以跳離開這個 container 的 tty。




#### 2. 管理 Container
如果只是離開了 container 終端機， container 並沒有關閉或停止執行，所以接下來說明如何來管理 container。


**(1) Container ID**


每一個 container 都有一個唯一的 *CONTAINER ID*，在上面的部分，執行 `sudo docker run -t -i centos:centos6 bash` 開啟新的 container 後，會進入 container 的終端機內：
```sh
[root@0f83f1728262 /]# whoami
root
```
`0f83f1728262` 就是 *CONTAINER ID*，之後都是利用此 id 來分別不同的 container。


**(2) 列出 Container**


Docker client 提供了 `docker ps` 可以查看目前開啟且正在執行的 container：
```sh
$ sudo docker ps
```
![docke ps commnad](http://www.openfoundry.org/images/141209/docker_ps.png "docker_ps.png")


可以看到 CONTAINER ID 及用哪一個 image 建立。


**(3) 在 Container 中執行指令**


離開了 container 的終端機後，並沒有將 container 關掉，可以用 `docker exec` 在 container 中執行指令，例如下面範例就是再回到`0f83f1728262` container 的終端機：
```sh
$ sudo docker exec -t -i 0f83f1728262 bash
```


*[進入container...]*


```sh
[root@0f83f1728262 /]#
```


**(4) 停止 Container**


想要讓在執行中的 container 停止，用 `docker stop` 停止執行中的 container ：
```sh
$ sudo docker stop 0f83f1728262
0f83f1728262
```
查看 container 狀態：
```sh
$ sudo docker ps -a
```
![docker ps -a](http://www.openfoundry.org/images/141209/docker_ps_a.png "docker_ps_a.png")




備註： `docker ps -a`，可以看到所有沒被刪除的 container。


**(5) 開啟停止的 Container**


開啟停止的 container `docker start`：
```sh
$ sudo docker start 0f83f1728262
```


開啟後會執行一開始建立這個 container 的指令及參數，所以如果建立的時候，並沒有開啟終端機與互動模式，執行完指令後，container 又結束了。


**(6) 刪除 Container**
透過 `docker ps -a` 可以列出所有建立過且沒被刪除的 container：
`docker rm` 刪除不需要的 container ：
```sh
$ sudo docker rm 0f83f1728262
0f83f1728262
```


**(7) Container 內建立額外的掛載點**


在 container 建立時，可以再建自訂的掛載點：
```sh
$ docker run -t -i -v /myData centos:centos6 bash
```


*[進入 container...]*


```sh
[root@20d24e944789 /]# df -h
Filesystem           Size  Used Avail Use% Mounted on
rootfs                  19G  459M   17G   3% /
...
/dev/sda1            19G  459M   17G   3% /myData
...
```


 - -v 在 container 內的掛載點


**(8) 共享主機與 Container 資料**
(這個部分可以等到 **下載 Image** 再回頭來看)
Docker 也提供了可以與主機目錄共享的資料的功能，這在開發的時候蠻好用的，只要把專案目錄掛載到 container 內，就能直接在 container 測試、執行。


我們將主機上的 */home/aming/Docker/tutorial/* 目錄掛到 container 內的 */app* 目錄：
```sh
$ sudo docker run -t -i -v \   
> /home/aming/Docker/tutorial/:/app \
> tutum/apache-php bash
```


 - -v *[HOST_DIR]:[CONTAINER_DIR]* 將 host OS 上的目錄掛載到 container 內的掛載點


![共享主機與 Container 資料](http://www.openfoundry.org/images/141209/host_os_container_volume_cc.png "host_os_container_volume_cc.png")


### 二、管理 Docker Image


**建立一個新的 Container** 內有提到，使用 `docker run` 建立新的 container 時，如果 Docker 發現沒有符合的 image 預設會去 Docker Hub 下載，那我們該如何知道目前有哪些可用的 images ？


`docker images` 可以列出主機內已經存在的 image：
```
$ sudo docker images
REPOSITORY  TAG          IMAGE ID          CREATED          VIRTUAL SIZE
centos          centos6  70441cac1ed5  3 weeks ago  215.8 M
```
 
 可以看到前面所提到的 image 的「repo 名稱」、「tag 名稱」等資訊。


#### 1. 搜尋 Images


搜尋 *php* 關鍵字：
```sh
$ sudo docker search php
```
![docker seach php result](http://www.openfoundry.org/images/141209/docker_search_php.png "docker_search_php.png")


#### 2. 下載 Image


我們下載搜尋到的 *tutum/apache-php* ：
```sh
$ sudo docker pull tutum/apache-php
Pulling repository tutum/apache-php
...
```


想知道目前主機上有哪些 images 可以使用 `docker images` ，會列出主機內所有的 image：
```sh
$ sudo docker images
```
![enter image description here](http://www.openfoundry.org/images/141209/docker_images_after_pull.png "docker_images_after_pull.png")


#### 3. 製作新的 Image


把剛才下載下來的 tutum/apache-php 已經有 Apache 及 PHP 環境，直接再利用這個 image，安裝 PHPUnit，製作成新的 image：


開啟一個新的 Container：
```sh
$ sudo docker run -t -i tutum/apache-php bash
```


*[進入 container...]*


Container 內 PHPUnit 安裝（示範用）：
```sh
root@aeeb1980c96e:/app# apt-get update
root@aeeb1980c96e:/app# apt-get install wget php5-xdebug
root@aeeb1980c96e:/app# cd /usr/local/bin ; \
> wget https://phar.phpunit.de/phpunit.phar
root@aeeb1980c96e:/usr/local/bin# chmod +x phpunit.phar
root@aeeb1980c96e:/usr/local/bin# mv phpunit.phar \
> phpunit
root@aeeb1980c96e:/usr/local/bin# exit
```


*[離開 container...]*


目前，我們已經建立一個新的 container，container ID 為 *aeeb1980c96e* 。




使用 `docker commit` 將 container 製作成新的 image：
```sh
$ sudo docker commit -m="Add PHPUnit and xdebug" \
> -a="Huang Yi-Ming" aeeb1980c96e \
> ymhuang0808/phpunit-testing:php5.5.9
```
```sh
$ sudo docker images
```
![製作新的 image](http://www.openfoundry.org/images/141209/docke_images_commit.png "docke_images_commit.png")


在 container 內建立好需要的環境後，把修改的 container 建立成一個新 image 檔案，這個 image 已經有增加 PHPUnit 測試環境。


 - `-m`：製作這個 image 的訊息
 - `-a`：image 的作者
 - *aeeb1980c96e*：則為上面有提到的 container ID
 - *ymhuang0808/phpunit-testing*：repo 名稱，通常斜線（ / ）前面為在 Docker Hub 的帳號名稱*（前面部分有註冊 Docker Hub 帳號）*，後面則是 repo 名稱
 - *php5.5.9*：tag 名稱，因為 repo 內可能會有不版本的 image ，就可以利用 tag 來區分


#### 4. 上傳至 Docker Hub


我們做了一個新的 image 後，可以上傳到 Docker Hub 或私有的 registry 將 image 分享出去。


首先，我們需要到 Docker Hub 網站建立一個自己的 repo：


1. 點選「Add Repository」，選擇「Respository」
![點選新增 repo](http://www.openfoundry.org/images/141209/View_Public_Profile___Docker_Hub_Registry_-_Repositories_of_Docker_Images.png "View_Public_Profile___Docker_Hub_Registry_-_Repositories_of_Docker_Images.png")


2. 填寫 Repo 名稱（注意要小寫）與描述，接著點選「Add Repository」
![填寫 repo 資訊](http://www.openfoundry.org/images/141209/Add_Repository___Docker_Hub_Registry_-_Repositories_of_Docker_Images.png "Add_Repository___Docker_Hub_Registry_-_Repositories_of_Docker_Images.png")


3. 成功在 Docker Hub 上建立 repo
![Repo 頁面](http://www.openfoundry.org/images/141209/ymhuang0808_phpunit-testing_Repository___Docker_Hub_Registry_-_Repositories_of_Docker_Images.png "Successfully create Docker Hub repo")


在 Docker Hub 建立好 repo 後，就可以將 image 使用 `docker push` 上傳至 Docker Hub：
```sh
$ sudo docker push ymhuang0808/phpunit-testing
```
```
The push refers to a repository [ymhuang0808/phpunit-testing] (len: 1)
Sending image list
Pushing repository ymhuang0808/phpunit-testing (1 tags)
511136ea3c5a: Image already pushed, skipping
...
Pushing tag for rev [be964598c221] on {https://cdn-registry-1.docker.io/v1/repositories/ymhuang0808/phpunit-testing/tags/php5.5.9}
```


#### 5. 移除 Image
```sh
$ sudo docker rmi \
> ymhuang0808/phpunit-testing:php5.5.9
```


如果無法刪除可能是有 container 使用了這個 image ，所以要先用 `docker rm` 移除使用的 container，才能順利移除 image。


### 三、撰寫 Dockerfile


在上面了解到能自己製作 image ，並且透過 Docker 分享出去。


除了可以利用做好的 image 方便建立一個新的 container 外，也可以撰寫好 Dockerfile 來建立 image 的腳本檔案，再使用 `docker build` 就能幫我們建立一個 image，一樣可以上傳到 Docker Hub 分享出去！


下面要示範如何使用 Dockerfile 來自動建立 image。跟上面一樣，我們利用 *tutum/apache-php* 來建 PHPUnit 的環境。


#### 1. 建立目錄與 Dockerfile
```sh
$ mkdir ~/dockerfile-demo && cd ~/dockerfile-demo
$ touch Dockerfile
```


#### 2. 編輯 Dockerfile
```sh
$ vi Dockerfile
```


加入以下內容：
```
FROM tutum/apache-php:latest
MAINTAINER Huang AMing <ymhuang@citi.sinica.edu.tw>
RUN sed -i 's/archive.ubuntu.com/free.nchc.org.tw/g' \
  /etc/apt/sources.list
RUN apt-get update \
  && apt-get install -y php5-xdebug
ADD https://phar.phpunit.de/phpunit.phar /usr/local/bin/
RUN cd /usr/local/bin \
  && chmod +x phpunit.phar \
  && mv phpunit.phar phpunit
```


 - `FROM `：以什麼 image 為基底
 - `MAINTAINER`：維護 image 的人
 - `RUN`：在 image 內執行的指令
 - `ADD`：將本機的檔案或遠端的檔案加入到 image 內的目錄，如果是壓縮檔會自動解壓縮。想將本機檔案或目錄複製到 image 可以使用 `COPY`


#### 3. 透過 Dockerfile 建立 Image


Dockerfile 就像一個腳本檔案，用 `docker build` 會根據 Dockerfile 內容來建立新的 image：
```sh
$ sudo docker build \
> -t="ymhuang0808/phpunit-testing:php5.5.9" .
```
```
Sending build context to Docker daemon  2.56 kB
Sending build context to Docker daemon
Step 0 : FROM tutum/apache-php:latest
 ---> 7e6d00854917
Step 1 : MAINTAINER Huang AMing <ymhuang@citi.sinica.edu.tw>
 ---> Running in 22412a8891e1
...
Successfully built 5f466619af2d
```


 - `-t`：repo 名稱加上 tag ，以冒號（ : ）區隔
 - . 依據當下目錄下的`Dockerfile`




###參考資料


 - Docker Documentation http://docs.docker.com/<!--se_discussion_list:{"6IpNKSBiKoEi0ginSuhmQE8C":{"selectionStart":9193,"selectionEnd":9088,"commentList":[{"content":"改成圖片"}],"discussionIndex":"6IpNKSBiKoEi0ginSuhmQE8C"}}-->


**作者簡介**
黃儀銘 (YMHuang) ，目前任職於自由軟體鑄造場。
部落格: http://blog.fmbase.tw/
___


##[源碼新聞] Microsoft 開源 .NET 的意涵


謝良奇／翻譯


**本文翻譯自 life hacker，原作者為 David Glance：http://www.lifehacker.com.au/2014/11/what-microsofts-shift-to-open-source-for-net-means/**


換作是幾年前，外界根本無法想像 Microsoft 會走這一步，該公司居然將它的開發平台免費公開，更準備在 Windows 之外，提供 Macs, Linux、Apple、Google 行動手機平台的支援。在沒有 Microsoft 直接支援的情況下，Xamarin 等組織長久以來，為不同行動作業系統提供上述平台。Microsoft 接下來將和這些組織進行合作。


Microsoft 的 dot Net 環境開源化，和該公司早在 2001 年即對開源運動展現出的厭惡，形成鮮明對比，該公司當時宣稱那是對智財權的威脅，並且是網絡泡沫後許多公司失敗的基本原因。


前 Microsoft 執行長 Bill Gates 甚至曾經指稱，開放源碼要為失業負責。他認為人們自願花時間開發的軟體，是可以交給 Microsoft 的受薪僱員來做的。當然在此時，Microsoft 只是感受到 Linux 的崛起，對於他們透過 Windows 所掌握的霸權，已經成為了一項商業威脅。


但是之後發生了許多事情。其中最重要的，要算是 Apple 與 Google 在行動手機領域的崛起，以及 Microsoft 在此領域的完全邊緣化。Microsoft 僅佔全球 2.5% 的智慧型手機出貨量。儘管有自己的智慧型手機平台，Microsoft 了解到現況是它的軟體必須在不同平台上運行才能確保其生存，而它必須接受這樣的世界。Microsoft 在 Apple 與 Android 手機和平板上，免費提供其 Office 軟體給非商業用途使用。今年稍早，Microsoft 讓手機和小型平板上免費使用 Windows。該公司承認它是要和 Google 的 Android 一拼，該平台在很大程度上是免費讓各公司在其硬體上使用的。


技術圈裡的其他重大改變，就是雲端應用的興起，特別是雲端上的非 Windows 平台。過去曾經有段時間，你只能在 Windows 的機器上開發與運行企業系統。在 IBM 等公司從大型主機移往運行 Microsoft Windows 的伺服器之前，已經為此爭論多年。Amazon 這些公司證明事實上你可以跳脫出來，並且一舉成為了供應商業服務的領導者，要設定這些服務，只需幾下滑鼠的點選加上信用卡。設定與運行電腦系統不僅成為小事一樁，更讓在 Linux 伺服器上運行開源軟體變得極為簡單。


Microsoft 為了因應 Amazon 領先的雲端風潮而推出了自己的 Azure 平台。和行動平台不同，Microsoft 在此要成功許多，某些證據顯示該公司甚至開始超越 Amazon。Microsoft 在此的持續成功，要歸功於接受並支持開源開發，以及在非 Windows  機器上運行軟體。


Microsoft 這些動作雖然要付出代價，但這卻是在一個 Windows PC 不再佔有主導地位的世界中，不可避免的成本。在 Microsoft 股價創新高的同時，Microsoft 目前採取的方向顯然讓投資者感到放心，也使得該公司成為落在 Apple 後，全球第二大最有價值的公司。


或許更重要的是，對於改變 Microsoft 被視為封閉且保守企業，只對維持 Windows 與 Office 控制權感興趣的消費者認知，這些動作可能有更大的影響。或許這反映了開源開發方式的成功，彰顯開放性與協同合作在商業實踐上，也和在發展高品質軟體上一樣可靠。
___


##[源碼新聞] Microsoft 開源 .Net 仍無法追趕上開源 Java


謝良奇／翻譯


**本文翻譯自 info world，原作者為 Paul Krill：http://www.infoworld.com/article/2850050/microsoft-net/microsoft-open-source-net-cant-match-open-source-java.html/**


Microsoft 伺服器端 .Net 技術的開源，對於這家私有桌面軟體長期以來的霸主是一大步。然而，這個動作本身的影響有限，觀察家認為，要追上開源 Java，.Net 還有很長的路要走。


在說明 .Net 開源計畫時，Microsoft 副總裁 S. Somasegar 談到 .Net 可以取代 Java 開發。當然，.Net 一直都是 Java 的替代方案，不過 Microsoft 正打算透過開源其部分的 Windows 技術，建構更廣大的開發者基礎。為此，該公司更為 Linux 與 Mac OS 提供了 Net Core 的官方散佈套件，將 .Net 開發延伸至這些平台，以便和透過 Java 虛擬機器可運行於多種平台的 Java 相媲美。此外，Microsoft 將提供有限的專利保護作為其策略的一部分。


但是 Java 和 .Net 領域的技術專家們對此並不買單。負責推廣 JBoss Java 中介軟體的 Red Hat 開發者宣傳主任 Arun Gupta 表示，只是開放源碼這項技術本身，並不表示他們就會獲得關注與建構出相應的生態圈。在此之前，Gupta 是 Java 創始者 Sun Microsystems 的 Java 傳教士。


Directions on Microsoft 的分析師 Rob Sanfilippo 相信開源 .Net 元件收到的效果有限。Sanfilippo 認為，.Net 核心的開源對於特定群眾是有幫助，像是目前的 .Net 開發者、跨平台解決方案的開發者、一些獨立軟體供應商，但是不會實質地改變 Microsoft 的營收動力或策略產出。Sanfilippo 指出，Microsoft 作為 Windows 一部分的付費 .Net 產品，始終會是該框架最穩定且最受支援的版本。


Gupta 表示，為開源 .Net 建構生態圈非一日可及。他們的立意是不錯，不過等到真的能替代 Java 或成為其威脅時，就我看來，還需要好幾年的時間。


資料管理軟體商 Hazelcast 行銷與開發者關係副總裁 Miko Matsumura，同意這個看法。Matsumura 表示，相當大量的開源專案是用 Java 所撰寫。以開放的基礎作為開始，Java 社群的整體規模和其開源程式庫與元件的多樣化，使得 .Net 相形見絀。因此，對 Microsoft 這雖然是正確方向的第一步，從開源社群支援的角度看來，還有很長的路要走。Java 早在 8 年前便已開放源碼。


JVM 軟體商 Azul Systems 執行長 Scott Sellers 認為，整體而言社群在 .Net 扮演何種角色仍有待觀察。他們真的需要提升到下一個階段。社群會和 Microsoft 一同參與制定 .Net 的發展，或者事實上仍只有 Microsoft？他說，Java 的發展是許多人共同參與的結果。


Gupta 點出，Microsoft 的開源行動只限於伺服器。該公司應該開放像 Windows Presentation Foundation 這類的用戶端技術。這是 Microsoft 建構豐富介面的程式設計模式。Gupta 補充說，Microsoft 真正擅長之處是工具，這部分並未開放源碼。反觀 Java 的工具像是 Eclipse 與 NetBeans，都是開放源碼的。


Matsumura 說，一個開源的 .Net 無疑會成為 Java 之外的替代選擇，並拉抬 Microsoft 的 Windows Azure 雲端。Microsoft 持續地拉攏大量的專門開發者，而透過提供 .Net 開發者基於開放源碼的跨平台執行時期策略，將持續地助長該平台的聲勢。此舉有助推廣 .Net API，也對 Azure 有所幫助。


IDC 分析師 Al Hilwa 認為，Microsoft 對開放源碼態度的改變還在持續進行。該公司擁抱開放源碼的舉動，可以追溯到若干年前了，不過直到最近他們才願意在開放源碼上下重注。在方向上，他們走在正確的軌道，加快腳步是值得歡迎，但仍有許多不足之處。在開發者社群中，開放源碼已經勢不可擋。這是 Microsoft 所無法忽視的。
___


##[源碼新聞] 用開源授權奉送你寶貴技術的三個絕佳理由


謝良奇／翻譯


**本文翻譯自 VB News：http://venturebeat.com/2014/11/08/3-great-reasons-to-give-away-your-precious-tech-under-an-open-source-license/**


本週稍早，雲端供應商 Joyent 的驚人之舉：將其調教過的雲端軟體 SmartDataCenter，以開源授權對外分享。


雖然看起來該公司像是在 Amazon、Google、Microsoft 使公有雲市場競爭變得異常激烈的同時，免費奉送其高價值的智財權，該公司的技術長 Bryan Cantrill 對於此舉，倒是在這篇[部落格](https://www.joyent.com/blog/sdc-and-manta-are-now-open-source)裡，提出了許多相當漂亮的理由。


Cantrill 認為，公開揭露核心技術的這種方式，會對三個關鍵項目造成直接影響：銷售、行銷、人才。因為每一家科技公司都免不了涉及這些企業功能，他的論述格外值得一聽。


Cantrill 對開放源碼開發的理解頗深。他在 Joyent 花了相當多的時間在開源的 Node.js JavaScript 框架上打造產品。 該公司正是該框架的贊助者。在此之前，Cantrill 作為傑出的工程師，在 Sun 參與開源 Solaris 作業系統的工作。因此他知道自己在說什麼。


### 銷售與行銷


他解釋 Joyent 將其 SmartDataCenter 軟體，以及物件儲存雲端服務的 Joyent Manta 軟體，加以開放源碼的決定：


10 年前，我寫下開放源碼是種犧牲打產品，當然，其中並無犧牲可言。在歷經 10 年開源商業模式的經驗後，我想補充的是，開放源碼還可以是無需電話推銷的銷售推廣、沒有保證金損失的通路、無需廣告的行銷活動。


但好處不止於此。


### 人才


藉由釋出 SmartDataCenter 與 Manta，Joyent 能發現優秀的工程師，其中有些可能是他們未來會聘請的人。Cantrill 表示：


基於過去的經驗，我們知道這些新技術人才中的一小部分，因為他們對這些專案的關注與貢獻，有一天會加入成為 Joyent 的工程師。說白了，開放源碼就是我們的人才養成所，而在一個對軟體人才需求孔急的市場裡，擴充我們的聘僱管道，對於我們在此的決定起了不小的作用。簡單來說，這並非利他主義的行為，而是一項商業決定，是一個多面向且好處不僅限於資產負債表的決定。


問題是，剛獲資金挹注的 Joyent，其業務將因本週的動作而有多少發展。
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