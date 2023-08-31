# FlutterでJWT認証を実装する
Node.jsで作成した認証用のAPI

https://github.com/sakurakotubaki/ExpressJWT

## やること
1. ユーザーは予め登録しておく。POSTMANを使っても良いし、SQLを使っても良い。
2. 認証に必要なJWTトークンを取得して、Flutter側で保持する。
3. 保持したトークンを使って、APIを叩く。
4. トークンの有効期限が切れたら、再度トークンを取得する。
5. トークンの有効期限が切れたら、ログイン画面に遷移する。
6. トークンを使いログインを維持する。