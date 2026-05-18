# Wedding Invitation + Rich Story Page

## 바뀐 기능

- 방문자는 `Shin Haeya & Yoon Juyeon`을 누르면 글 목록을 바로 볼 수 있습니다.
- 글 카드를 누르면 전체 글 페이지가 열립니다.
- 관리자 로그인 후 글 작성, 수정, 삭제가 가능합니다.
- 글 작성에서 볼드체, 이탤릭, 밑줄, 정렬, 글자색을 사용할 수 있습니다.
- 본문에 사진을 추가할 수 있습니다.
- 글마다 썸네일 이미지를 설정할 수 있습니다.

## 꼭 해야 하는 Supabase 설정

이번 버전은 이미지 업로드와 썸네일 기능이 추가되어서 `supabase-setup.sql`을 다시 실행해야 합니다.

1. Supabase 프로젝트 접속
2. SQL Editor
3. New query
4. `supabase-setup.sql` 전체 복사
5. Run

이 SQL은 다음을 추가합니다.

- `stories.content_html`
- `stories.thumbnail_url`
- `story-images` Storage bucket
- 이미지 업로드 권한 정책

## 파일 구성

- `index.html`: 청첩장 메인 페이지
- `story.html`: 글 목록, 상세 글, 관리자 에디터 페이지
- `supabase-config.js`: Supabase 주소와 공개 키 입력 파일
- `supabase-setup.sql`: Supabase 데이터베이스와 이미지 저장소 설정
- `netlify.toml`: Netlify 배포 설정

## Supabase config

`supabase-config.js`에는 아래 값을 넣어야 합니다.

```js
window.SUPABASE_URL = '여기에 Supabase Project URL';
window.SUPABASE_ANON_KEY = '여기에 Supabase Publishable key';
window.STORY_ADMIN_EMAIL = 'jangh3073@gmail.com';
window.STORY_ADMIN_ID = 'admin';
```

관리자 아이디는 `supabase-config.js`의 `window.STORY_ADMIN_ID`에서 바꿀 수 있습니다. 관리자 이메일을 바꾸면 `supabase-setup.sql` 안의 이메일도 같은 값으로 바꾼 뒤 다시 실행하세요.

## Netlify 배포

GitHub에 파일을 올리면 Netlify가 자동으로 배포합니다.

- Build command: 비워두기
- Publish directory: `.`


## 관리자 로그인 방식

사이트 로그인 팝업에는 이메일이 아니라 아이디가 보입니다.

기본값은 아래와 같습니다.

```txt
아이디: admin
비밀번호: Supabase Authentication에서 만든 관리자 계정 비밀번호
```

아이디를 바꾸고 싶으면 `supabase-config.js`에서 아래 부분만 수정하세요.

```js
window.STORY_ADMIN_ID = '원하는아이디';
```

Supabase 안쪽 로그인은 여전히 `window.STORY_ADMIN_EMAIL`에 적힌 이메일 계정으로 처리됩니다.
그래서 Supabase Authentication에는 관리자 이메일 계정이 하나 만들어져 있어야 합니다.
