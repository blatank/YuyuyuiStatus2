# README

HTMLとCSVで管理していた[初代](https://github.com/blatank/YuyuyuiStatus/)のRails運用版

## サーバ稼働方法
```
$ rails db:migrate
$ rails db:seed # CSVファイルからDBにインポートしています
$ rails server
```

### CSVファイル
CSVは[こちら](https://github.com/blatank/YuyuyuiStatusCsv)で管理。
このプロジェクトとしてはgit subtreeを用いて管理している。

## Herokuで運用中
https://yuyuyui-status.herokuapp.com/
