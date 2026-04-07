# Assets

## 目的

このプロジェクトでは、ブランド表現に関わる静的文字素材を可能な限り `SVG` で管理します。  
特に Flutter Web / WebAssembly では、PNG の拡大縮小よりも SVG の方が破綻しにくく、レスポンシブ調整とも相性が良いためです。

対象は主に次の素材です。

- `title.svg`
- `subtitle.svg`
- `navbar-logo.svg`
- `favicon.svg`

本文テキストや将来の多言語化対象まで画像化する方針ではありません。  
ブランドロックアップや固定見出しのように「常に同じ字形で見せたいもの」を SVG 化しています。
たとえば Footer ではコピーライト文字列はテキストのままにして、屋号だけをワードマーク SVG で表示します。

## 方針

### 1. 編集元と配信用を分ける

- `assets/original/`
  フォント情報を残した編集元 SVG
- `assets/`
  Web 配信用の path 化済み SVG

編集は `assets/original/` を正とします。  
`assets/` はブラウザ配信用の成果物であり、手編集より再生成を優先します。

### 2. キャンバスは文字実体に合わせる

タイトルやサブタイトルは、`高さをほぼ一定` にしつつ `幅は文字列に応じて変える` 方針です。  
フォントサイズを小さくして広いキャンバスに置くのではなく、文字がキャンバスをしっかり使うように source SVG を作ります。

そのうえで、実際の見た目の大きさは Flutter 側で制御します。

### 3. 表示サイズは Dart 側で調整する

`lib/res/asset_*.dart` が各 SVG の表示サイズと縦横比を持ちます。

- SVG 側
  文字形状と実体比率を定義する
- Dart 側
  ブレークポイントや UI 文脈に応じた描画サイズを決める

この分担により、source SVG を作り直しても UI ロジックを大きく変えずに済みます。

## Header 関連

ヒーローヘッダでは次の役割分担を取ります。

- `favicon.svg`
  ブランドシンボル。expanded 時も collapsed 時も使う
- `title.svg`
  `CREATE&CREATIVE` のワードマーク
- `subtitle.svg`
  `Architecture Design / Implementation`
- `header-bg.png`
  背景写真

`HeaderView` は表示担当、`HeaderMotion` は位置・サイズ・opacity の補間担当です。  
背景写真のトリミングは `HeaderMotion` に含めず、狭い幅では `HeaderBackgroundStyle` でズーム量と見せる位置を調整します。  
スクロール時の挙動は概ね次の通りです。

- `favicon` は中央付近から左上の AppBar 位置へ移動しつつ縮小する
- `title` は後半でフェードアウトする
- `subtitle` は早い段階で縮小しながらフェードアウトする
- `header-bg.png` は `xs / sm` では少し拡大して、人物側をやや残す構図に寄せる

## Footer 関連

Footer では、テキストとして保持したい情報とブランド字形を固定したい情報を分けます。

- `copyrightPrefix`
  locale ごとの文言としてテキスト表示する
- `title.svg`
  `CREATE&CREATIVE` のワードマークとして小さく再利用する

このため、Footer 行全体を 1 枚の画像にはせず、コピーライトは検索可能テキストのまま残します。

## 実装上のルール

### `assets/original/` を更新するとき

- フォントが正しく解決される環境で編集する
- ブランド文字はキャンバスを十分使うサイズで配置する
- `title` / `subtitle` は高さ 30 前後の比率を目安にする
- 文字列の見た目調整は、まず source SVG 側で行う

### `assets/` を再生成するとき

- `Inkscape` で path 化した plain SVG を出力する
- Web 配信用 SVG に `<text>` を残さない
- 配信用 SVG の字体は source SVG と同一になるよう、必要フォントを導入した環境で出力する

### `lib/res/asset_*.dart` を更新するとき

- `width` / `height` は source SVG の実際の比率に合わせる
- `image` の表示幅は UI 都合で決める
- 見た目の大小調整は原則ここで行う

### `header-bg.png` の見せ方を更新するとき

- 元画像の比率は維持し、レイアウト都合のトリミングは Dart 側で行う
- `xs / sm` の補正は `HeaderBackgroundStyle` に閉じ込める
- タイトルやロゴの補間と、背景のトリミング責務を混ぜない

## 現在のワークフロー

1. `assets/original/*.svg` を編集する
2. フォント解決が正しいことを確認する
3. `Inkscape` で path 化して `assets/*.svg` を再生成する
4. `lib/res/asset_*.dart` の縦横比を必要に応じて更新する
5. Flutter Web 上で実表示を確認する

## 注意点

- WSL 上で対象フォントが解決できないと、path 化した字形が意図とずれます
- その場合は Windows 側フォントを WSL に登録してから再生成します
- `navbar-logo.svg` のようなシンボル系は、既存 path を流用した方が安全な場合があります
- 文字列変更のたびに PNG 化する必要はありませんが、Web 実表示確認は必須です
