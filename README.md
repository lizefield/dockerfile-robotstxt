# ROBOTSTXT

robots.txt を用いた URL 検証を行います。  
事前に robots.txt の準備が必要です。

[Google の robots.txt パーサー](https://developers.google.com/search/blog/2019/07/repp-oss)を利用しています。

## 使い方

- 事前準備された robots.txt をコンテナ内の/usr/local/src/robots.txt としてマウント

```
docker run -v <robots.txtのpath>:/usr/local/src/robots.txt ghcr.io/lizefield/robotstxt:latest robots robots.txt <UserAgent> <URL>
```

### 出力サンプル

```
user-agent 'UserAgent' with URI 'https://hoge.hoge/hoge.html': ALLOWED
```
