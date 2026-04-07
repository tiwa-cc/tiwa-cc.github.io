# Decisions

## 概要

コードから読み取れる主要な設計判断を、ADR 風に簡潔に整理します。  
意図がコード上に明示されていない箇所もありますが、ここでは実装から妥当と判断できるものだけを扱います。

## D-001 Flutter Web を中心に据える

### 判断

ポートフォリオの実装基盤として Flutter Web を採用する。

### 根拠

- `flutter build web --wasm` を前提にした `build_web.sh` がある
- `web/` 配下にエントリがある
- UI が Material / Flutter Widget 中心で構成されている

### 利点

- モバイル寄りの表現力をそのまま Web に持ち込める
- レスポンシブ UI を Dart で統一管理できる

### 欠点

- 初期表示コストや検索性の面で静的サイトより不利になりやすい
- 単純なポートフォリオとしては実装コストが高い

## D-002 画面を単一ページ + セクション分割で構成する

### 判断

ルーティングを増やさず、1 ページの中でセクション移動する構成を採用する。

### 根拠

- `Section` enum が中心識別子になっている
- `ScrollJumper` によりセクションスクロールを提供している
- `TopView` 配下に全セクションを集約している

### 利点

- ポートフォリオとして閲覧導線が単純
- レイアウトの自由度が高い

### 欠点

- 各セクションの状態を URL と同期しにくい
- コンテンツ増加時に 1 画面へ責務が集中しやすい

## D-003 依存注入に Riverpod を使う

### 判断

状態管理よりも、まず依存差し替えのために Riverpod を採用する。

### 根拠

- `serverApiProvider` と `storageAccessProvider` の差し替えが明確
- `ProviderScope(overrides: ...)` で開発用実装に切り替えている

### 利点

- `develop` と `production` の切り替えが単純
- UI と実装詳細を疎結合にできる

### 欠点

- 現状は Provider の恩恵が依存注入中心で、状態機械としては薄い
- 非同期処理やエラー状態は十分に整理されていない

## D-004 About / Contents / CoreSkill / SoftwareSkill / Experience はアセット JSON を経由して先に UI を固める

### 判断

本番 API 完成前でも UI を進めるため、開発時はアセット JSON を疑似 API として扱う。

### 根拠

- `RawClient` が `assets/mock/about.{ja,en}.json`、`assets/mock/content_showcase.{ja,en}.json`、`assets/mock/core_skill.{ja,en}.json`、`assets/mock/software_skill.json`、`assets/mock/experience.{ja,en}.json` を読む
- `main.dart` の既定 `FLAVOR` が `develop`

### 利点

- バックエンド未完成でも概要、公開コンテンツ、スキル、職歴の UI を検証できる
- デモ用途として再現性が高い

### 欠点

- `RawClient` がストレージ更新を直接行っており責務が混ざる
- 本番 API との差分が広がると移行コストが増える

## D-005 画面幅ごとに専用 Widget を分ける

### 判断

レイアウト分岐を条件分岐の乱立ではなく、`TopViewXs` から `TopViewXl` に分割する。

### 根拠

- `lib/app/responsive/` にサイズ別 Widget が分かれている

### 利点

- 各レイアウトの意図が追いやすい
- デザイン変更時にブレークポイント単位で調整しやすい

### 欠点

- セクション追加時に複数ファイルを同時修正する必要がある
- 共通化が弱いと重複が増える

## D-006 ローカライズは独自 `L10n` + JSON アセットで運用する

### 判断

Flutter 標準生成コードへ全面移行せず、独自 `L10n` と JSON アセットで `ja` / `en` を運用する。

### 根拠

- `lib/l10n/l10n.dart` が軽量な `LocalizationsDelegate` を持つ
- `l10n/messages.ja.json` と `l10n/messages.en.json` を直接読む
- 開発用データも `assets/mock/*.{ja,en}.json` に揃えている
- `SoftwareSkill` だけは固有名詞中心のため、locale 非依存の `assets/mock/software_skill.json` を使っている

### 利点

- 文字列定義の散在を防ぎやすい
- 文言と mock データのロケール切り替えを同じ粒度で扱える

### 欠点

- Flutter 標準の生成ベースと比べると型安全性と支援が弱い
- 日本語本文が一部ハードコードされており一貫性がない

## D-007 ブランド文字素材は SVG を正とする

### 判断

ブランド表現に関わる固定文字素材は、通常テキストや PNG ではなく `SVG` を正として扱う。

### 根拠

- `title.svg` は Header と Footer のブランドワードマークとして、`subtitle.svg`、`navbar-logo.svg`、`favicon.svg` は各表示文脈で `lib/res` 経由で表示している
- `assets/original/` に編集元、`assets/` に path 化済み成果物を分けている
- `flutter build web --wasm` を前提とした Web 配信が主用途である

### 利点

- レスポンシブ拡大縮小でもラスタ劣化しにくい
- フォント依存を配信時に解消できる
- ブランド字形をブラウザ差異から守りやすい

### 欠点

- 文言変更のたびに SVG 再生成が必要
- フォント解決に失敗した環境で path 化すると誤った字形が固定される
- 検索可能テキストや多言語化には向かない

## D-008 Header の補間ロジックを View から分離する

### 判断

ヒーローヘッダの位置・サイズ・opacity 補間は `HeaderView` に埋め込まず、`HeaderMotion` に分離する。

### 根拠

- `lib/features/header/header_motion.dart` が補間計算を一括して持つ
- `HeaderView` は `SliverAppBar` と `Positioned` による描画へ責務を絞っている

### 利点

- View と Motion の責務が明確になる
- 微調整時に計算ロジックだけを見直しやすい
- テストやレビュー時に意図を追いやすい

### 欠点

- ヘッダ周りのファイル数が増える
- 小規模変更でも 2 ファイル以上を見る必要がある

## D-009 Header 背景写真のトリミング責務を分離する

### 判断

`header-bg.png` のレスポンシブなズーム・パンは `HeaderView` に直接書かず、`HeaderBackgroundStyle` に分離する。

### 根拠

- `lib/features/header/header_motion.dart` はスクロール補間だけに責務を絞っている
- `lib/features/header/header_background_style.dart` でブレークポイント別の背景見せ方を管理できる
- 狭い幅では構図調整が必要だが、タイトルやロゴの動きとは独立している

### 利点

- 背景写真の見せ方だけを安全に微調整しやすい
- モーション調整時に背景用の条件分岐が混ざらない
- 画像差し替え時のレビュー観点が明確になる

### 欠点

- ヘッダ実装の関連ファイルが 1 つ増える
- 見た目調整時に View / Motion / BackgroundStyle を見分ける必要がある

## D-010 Provider は View に対する Snapshot とみなし、表示制御と購読制御を分離する

### 判断

View は Provider が提供する現在値だけを信じ、Widget の表示条件とデータ購読の寿命を分離する。

### 根拠

- `TopViewResponsive` は breakpoints ごとに別 Widget tree を差し替える
- feature panel は `StreamProvider` が提供する snapshot だけを描画する
- `RawAccessor` は late subscriber に最新値を返し、responsive 切替時の loading 停滞を避けている

### 利点

- View がデータソース種別や stream の寿命を意識しなくて済む
- レイアウト都合で Widget が張り直されても、データ状態の追跡が一貫する
- `Provider = UI 向け snapshot` という責務が明確になる
- responsive 切替後に再購読した panel でも直近データを即座に再利用できる

### 欠点

- storage 側 replay に寿命安定化を寄せており、設計意図を追わないと冗長に見える

## D-011 SoftwareSkill のカテゴリとアイコンは presentation concern として扱う

### 判断

`SoftwareSkill` の JSON は `id` と `label` に留め、カテゴリ分け、アイコン解決、capability snapshot への束ね方は UI 側の catalog / presenter に閉じ込める。

### 根拠

- `assets/mock/software_skill.json` は固有名詞の列挙だけを持つ
- `software_skill_catalog.dart` が `id -> category / icon` を管理している
- `software_skills_panel.dart` が `Primary Stack` などの見せ方へ再構成している

### 利点

- API や mock データが `FontAwesome` や UI ライブラリに依存しない
- mock データを増やしても、表示側で「主軸」「周辺経験」などの束ね方を変えやすい
- アイコン未対応スキルを text-only で自然に扱える

### 欠点

- `id -> category / icon` の対応表をアプリ側で保守する必要がある
- カタログと mock データの整合が崩れると表示ルールの追跡が難しくなる

## D-012 shared な装飾ルールは ThemeExtension に寄せる

### 判断

feature ごとの薄い theme helper を増やさず、再利用する装飾ルールは `ThemeExtension` として `AppThemeData` に集約する。

### 根拠

- `AppThemeExtensions` が `AuthorNameTheme`、`HeaderViewButtonTheme`、`InfoCardTheme`、`CopyrightTheme`、`HeaderPopupMenuTheme` を登録している
- `SectionViewButton`、`InfoCard`、`FooterView`、`HeaderPopupMenu` が shared theme extension を直接参照している
- `ProfilePanel` では既に `AuthorNameTheme` を `ThemeExtension` 経由で参照している

### 利点

- custom style の定義位置が `shared/themes` に揃い、feature ごとの重複を減らせる
- `ThemeData` から一括で差し替えられるため、テストで局所的な上書きがしやすい
- 「ポートフォリオとして theme 設計を見せる」という意図をコード上で明示できる

### 欠点

- 単純な色や `TextStyle` でも専用 extension を追加する判断が必要になり、型数は増える
- `TextTheme` や `ColorScheme` で十分な範囲まで custom extension に寄せると、かえって設計が過剰になりやすい
