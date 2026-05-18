# Wedding Invitation + Story Page

## 파일 구성

- `index.html`: 청첩장 메인 페이지
- `story.html`: 글 목록 페이지, 작은 관리자 로그인 팝업과 글쓰기 영역 포함
- `supabase-config.js`: Supabase 주소와 anon key 입력 파일
- `supabase-setup.sql`: Supabase 데이터베이스 설정 SQL
- `netlify.toml`: Netlify 배포 설정

## 동작 방식

1. 메인 페이지 마지막의 `Shin Haeya & Yoon Juyeon`을 누르면 `story.html`로 이동합니다.
2. `story.html`에 들어오면 방문자는 글 목록을 바로 볼 수 있습니다.
3. 글쓰기가 필요할 때만 `로그인해서 글쓰기` 버튼을 누릅니다.
4. 버튼을 누르면 화면 중앙에 작은 로그인 팝업이 열립니다.
5. 관리자 로그인 후에만 글 작성, 수정, 삭제 영역이 나타납니다.
6. 방문자는 회원 가입 없이 글을 읽기만 합니다.

## Supabase 설정

Supabase SQL Editor에서 `supabase-setup.sql` 내용을 실행하세요.

그다음 `supabase-config.js`에 아래 값을 넣으세요.

```js
window.SUPABASE_URL = '여기에 Supabase Project URL';
window.SUPABASE_ANON_KEY = '여기에 Supabase anon public key';
window.STORY_ADMIN_EMAIL = 'jangh3073@gmail.com';
```

관리자 계정은 Supabase Dashboard의 Authentication 메뉴에서 직접 하나 만들어두면 됩니다.

## Netlify 배포

GitHub 저장소에 이 파일들을 올린 뒤 Netlify에서 해당 저장소를 연결하면 됩니다.

- Build command: 비워두기
- Publish directory: `.`
