# OPIc Shadowing Studio - Google Drive 연동판

이 패키지는 기존 OPIc 쉐도잉 플레이어에 Google Drive 답변 라이브러리를 추가한 버전입니다.

- 이미 만들어둔 Google Drive의 **OPIc** 폴더와 그 하위 파일을 표시합니다.
- **OPIc Master > Question Bank**의 문제 목록을 표시합니다.
- **Google Docs** 답변을 선택하면 `Answer · 한영 문장 교차` 아래의 한국어/영어 문장 쌍을 추출해 즉시 쉐도잉 플레이어에 적용합니다.
- **.txt** 파일도 `한국어 | 영어` 또는 `한국어 다음 줄에 영어` 형식이면 불러올 수 있습니다.
- 기존 **TTS 음성 선택·속도·반복·정지·문장별 재생·텍스트 편집** 기능은 유지됩니다.
- Google Drive에는 **읽기 권한만** 요청합니다. 플레이어에서 편집한 스크립트는 Google Docs로 다시 저장되지 않고, 사용 중인 브라우저에만 저장됩니다.

## 1. Google Cloud에서 웹 OAuth Client ID 만들기 (처음 한 번)

Google Drive를 ChatGPT에 연결한 것만으로는 독립 HTML 앱에서 로그인할 수 없습니다. Google Cloud 프로젝트의 웹 OAuth Client ID가 필요합니다. 

1. [Google Cloud Console](https://console.cloud.google.com/)에서 프로젝트를 만들거나 선택합니다.
2. [APIs & Services > Library](https://console.cloud.google.com/apis/library)에서 **Google Drive API**, **Google Docs API**, **Google Sheets API**를 활성화합니다.
3. **Google Auth Platform**의 Branding / Audience / Data Access 항목을 설정합니다. 개인 용도라면 **External (테스트)**로 구성하고 테스트 사용자로 `soeun94.choi@gmail.com`을 추가합니다. Cloud 콘솔이 제공하는 개인용 간편 설정 경로가 있다면 그 방식을 사용해도 됩니다.
4. Data Access에서 `https://www.googleapis.com/auth/drive.readonly` 범위를 설정합니다. 이 범위는 선택한 OPIc 폴더뿐 아니라 사용자가 접근할 수 있는 Drive 파일 전반의 **읽기 권한**이므로 본인만 사용하는 테스트 앱으로 관리하세요.
5. **Clients > Create client**에서 **Web application**을 선택하고 **Authorized JavaScript origins**에 **`http://localhost:8000`**을 추가합니다. (`/`나 HTML 파일 경로를 붙이지 마세요.)
6. 생성된 `...apps.googleusercontent.com` 형태의 **Client ID**를 복사합니다. **Client secret은 HTML에 넣지 마세요.**

[Google 공식 설정 안내](https://developers.google.com/identity/oauth2/web/guides/get-google-api-clientid) · [Drive JavaScript Quickstart](https://developers.google.com/workspace/drive/api/quickstart/js)

## 2. Windows PC에서 실행하기

1. 이 ZIP의 파일을 같은 폴더에 압축 해제합니다.
2. Python이 설치되어 있다면 **`Start_Windows.bat`**를 더블클릭합니다. 자동으로 로컬 웹서버를 시작하고 브라우저를 엽니다.
3. 배치 파일 대신 직접 실행하려면 해당 폴더에서 명령 프롬프트를 열고 다음 명령을 실행합니다.

   ```powershell
   py -m http.server 8000
   ```

4. 브라우저에서 **`http://localhost:8000/OPIc_Shadowing_Player_Drive.html`**에 접속합니다.
5. 웹페이지의 `OAuth 웹 클라이언트 ID` 칸에 위에서 복사한 Client ID를 붙여넣습니다.
6. **Google 계정 연결**을 누르고 **`soeun94.choi@gmail.com`** 계정을 선택해 읽기 권한에 동의합니다.
7. `OPIc Master`에서 `GEO-Q1 · Geography · 지형` 항목의 **연습하기**를 누릅니다. 문장 쌍이 입력되고, ▶ Play를 누르면 쉐도잉할 수 있습니다.

**중요:** HTML 파일을 더블클릭하여 `file://` 주소로 열면 Google OAuth가 동작하지 않습니다. `localhost` 또는 HTTPS에서 실행해야 합니다.

## 3. 모바일에서 사용하려면

휴대폰에서 PC의 `localhost` 주소는 열리지 않습니다. Google Drive와 자동 연결해 사용하려면 이 HTML을 GitHub Pages 같은 HTTPS 정적 사이트에 게시하고, Google Cloud의 Authorized JavaScript origins에 **게시한 사이트의 origin**(예: `https://myname.github.io`)을 추가해야 합니다. 폴더에 있는 Google Docs 자체가 공개되는 것은 아니고, 별도 Google 로그인이 필요합니다. 공개 저장소에는 Client Secret이나 액세스 토큰을 넣지 마세요.

## 기존에 만들었던 Drive 구조

- [OPIc 폴더](https://drive.google.com/drive/folders/1gPsBiHo0uA85vjcl4fZdxFEl77VQpQLm)
- [01_Answers 폴더](https://drive.google.com/drive/folders/1wbLZ3ALjeFI9bZ2m7bmphnpDKTpqDXHR)
- [OPIc Master](https://docs.google.com/spreadsheets/d/11PQhc2tcn6a8hKLtAhbesejX36HshS7kCrC6eFzz-H8/edit)
- [GEO-Q1 지형 묘사 원고](https://docs.google.com/document/d/1EVlyXQurAf66H1kYIySIdQyXegcWwCKLy-0LXFGivUE/edit)

## 문제 해결

- **Error 400: origin_mismatch**: Google Cloud의 OAuth Client ID가 웹 애플리케이션 타입인지, JavaScript origin이 `http://localhost:8000`으로 등록돼 있는지 확인합니다.
- **access_denied / 앱이 확인되지 않음**: OAuth Consent Screen의 테스트 사용자와 `soeun94.choi@gmail.com` 계정을 확인합니다. 필요하면 Google의 미확인 앱 경고 및 테스트 앱 제한 안내를 검토합니다.
- **Google API 403 / API disabled**: Drive/Docs/Sheets API 3개가 같은 Google Cloud 프로젝트에 활성화됐는지 확인합니다.
- **목록이 비어 있음**: 로그인한 Google 계정이 `soeun94.choi@gmail.com`인지 확인합니다.
- **한영 문장이 나오지 않음**: Google Docs에서 `Answer` 제목 아래 한국어/영어 문장을 번갈아 한 문장씩 넣습니다.
- **로그인 만료**: `Google 계정 연결`을 다시 누릅니다. 액세스 토큰은 브라우저에 영구 저장하지 않습니다.
- **휴대폰에서 안 열림**: 위 모바일 배포 절차가 필요합니다. PC 전용 `localhost`는 휴대폰에서 열리지 않습니다.

## 구현과 확인 범위

브라우저 테스트에서 가짜 Google 인증 및 Google API 응답을 사용해 마스터 시트 목록 표시, Drive 하위 폴더 탐색, Google Docs 한영 쌍 가져오기, 기존 플레이어로 전달하기를 확인했습니다. 실제 Google OAuth 로그인과 실계정 API 접근은 사용자의 Google Cloud Client ID 및 동의 절차가 완료된 뒤 검증할 수 있습니다.
