# TraningAPI
コロナ感染情報を表示するiOSアプリ  
  
## 主な機能  
下記WebAPIよりコロナ感染情報を取得  
https://github.com/ryo-ma/covid19-japan-web-api/blob/master/README.ja.md  
都道府県ごとに、感染情報の詳細を表示  
  
## 画面説明  
### 画面構成
画面は下記の２画面となる
-都道府県一覧表示画面
-コロナ感染情報詳細表示画面  

#### 都道府県一覧表示画面  
<img src="https://user-images.githubusercontent.com/24288482/115819973-e1e6f480-a43a-11eb-8b57-ed17f1b91c24.png" alt="都道府県一覧画面" title="都道府県一覧画面" width="400" height="600">  
-画面表示項目  
    -上記APIより取得した都道府県の名前一覧    
    -API取得最終更新日時表示  

また、都道府県名を選択するとコロナ感染情報画面を表示する  
  
#### コロナ感染情報表示画面
<img src="https://user-images.githubusercontent.com/24288482/115819994-ef03e380-a43a-11eb-9f06-be59fbda05b7.png" alt="コロナ感染情報表示画面" title="コロナ感染情報表示画面" width="400" height="600">  
都道府県一覧画面で選択された都道府県の詳細を表示  
-画面表示項目  
    -人口  
    -感染者数  
    -死者数  
    -PCR検査数  
    -入院者数  
    -重傷者数  
    -退院者数  
    -自覚症状者数  
*2021/04/23 時点  
また、上記項目における情報の最終更新日を表示
  
