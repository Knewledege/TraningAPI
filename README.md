# TraningAPI
コロナ感染情報を表示するiOSアプリ  
  Xcodeバージョン: 11.0  
  Simulators           : iPhone11  
  iOSバージョン    : 13.5  
## 主な機能  
下記WebAPIよりコロナ感染情報を取得  
https://github.com/ryo-ma/covid19-japan-web-api/blob/master/README.ja.md  
都道府県ごとに、感染情報の詳細を表示  
  
## 画面説明  
### 画面構成
画面は下記の5画面となる
- 都道府県一覧表示画面
- コロナ感染情報詳細表示画面  
- メニュー画面
- ライセンス一覧画面
- ライセンス表記画面

#### 都道府県一覧表示画面  
<img src="https://user-images.githubusercontent.com/24288482/117606632-43c29080-b195-11eb-99cf-0ca7fc7ebe9b.png" alt="都道府県一覧画面" title="都道府県一覧画面" width="400" height="600">  
  
- 画面表示項目  
    - 上記APIより取得した都道府県の名前一覧    
    - API取得最終更新日時表示  

また、都道府県名を選択するとコロナ感染情報画面を表示する  
右上の更新ボタンを押すと、最新情報を取得しコロナ感染情報を更新する。
  
#### コロナ感染情報表示画面
<img src="https://user-images.githubusercontent.com/24288482/117592999-a0ae4e80-b175-11eb-8ba5-cc4a33fdf50e.png" alt="コロナ感染情報表示画面" title="コロナ感染情報表示画面" width="400" height="600">  
  
都道府県一覧画面で選択された都道府県の詳細を表示  
- 画面表示項目  
    - 人口  
    - 感染者数  
    - 死者数  
    - PCR検査数  
    - 入院者数  
    - 重傷者数  
    - 退院者数  
    - 自覚症状者数  
* 2021/04/23 時点  
また、上記項目における情報の最終更新日を表示
  
  ### メニュー画面
  <img src="https://user-images.githubusercontent.com/24288482/117593002-a441d580-b175-11eb-9224-a3ebebdc8ea5.png" alt="メニュー画面" title="メニュー画面" width="400" height="600">  
    
左上のメニューボタンを押すことで、メニューがスライドして表示される。  
ボタンを押すことで開閉ができ、スワイプをすることでもメニューを閉じることができる。  
#### スライド左右対応  
下記コードを変更することで、メニュー画面がスライドする方向を変えることができる。  
##### /*左スライド用*/  
```RootViewController.swift  

private var menuView: UIView = UIView(frame: CGRect(x: 0,  
                                                    y: 0,  
                                                    width: (UIScreen.main.bounds.width / 3) * 2,  
                                                    height: UIScreen.main.bounds.height))  
menuHiddenPosition = -self.menuView.frame.width  
swipe.direction = .left  
```
##### /*右スライド用*/
```RootViewController.swift  
private var menuView: UIView = UIView(frame: CGRect(x: (UIScreen.main.bounds.width / 3),  
                                                    y: 0,  
                                                    width: (UIScreen.main.bounds.width / 3) * 2,  
                                                    height: UIScreen.main.bounds.height))  
menuHiddenPosition = self.menuView.frame.width*2  
swipe.direction = .right  
```
### ライセンス一覧画面  
 <img src="https://user-images.githubusercontent.com/24288482/117593009-a6a42f80-b175-11eb-987c-b381138483f4.png" width="400" height="600">  
 メニュー画面よりライセンス項目を選択すると、上記ライセンス一覧画面がプッシュ遷移で表示される。
 backボタンで戻ると都道府県一覧画面に戻ることができる。
 一覧には、本アプリで使用しているライブラリを表示。
 
 ### ライセンス画面
 <img src="https://user-images.githubusercontent.com/24288482/117593011-a99f2000-b175-11eb-9132-415daedb3a99.png" width="400" height="600">  
 上記ライセンス一覧画面で選択されたライブラリのライセンスを明記する。
 backボタンを押すと、ライセンス一覧画面に戻ることができる。
