# Bootstrapの導入を学習

## 公式サイト（サンプル）
- Bootstrap
    - https://getbootstrap.com/docs/4.5/components/alerts/
- Font Awesome
    - https://fontawesome.com/icons?d=gallery

## 参考動画（youtube）
- https://www.youtube.com/watch?v=Q-PY5QQj80E&list=PLlU466PzciHETofHub5rMVDvFPjkb2DhP&index=10

## 手順（基本、動画参照）

- rails _6.0.0_ new bootstrap-app3 -d mysql

- config/database.yml
    - utf8mb4 => utf8

- rails db:create

- rails g controller home top

- yarn add bootstrap@4.3.1 jquery popper.js

- yarn add @fortawesome/fontawesome-free

- app/javascript/packs/application.js
    - import 'bootstrap'
    - import '../src/application.scss'
    - import '@fortawesome/fontawesome-free/js/all'

- app/javascript/src/application.scss
    - @import '~bootstrap/scss/bootstrap';
    - @import '~@fortawesome/fontawesome-free/scss/fontawesome';

- app/views/layouts/application.html.erb
    - link_tag => pack_tag

- app/views/home/top.html.erb
    - templateのHTMLをコピー

- app/assets/stylesheets/home.scss
    - templateのCSSをコピー

- top.html.erbにCSSを適用
    - app/views/home/top.html.erb
    - link style='stylesheet' href='/assets/home.scss'

## 何かテストしたい時は

- home#testのビューでテスト
    - URI: "/test"
    - view: app/views/home/test.html.erb
    - css: app/assets/stylesheets/home/test/scss