<p align="center">
  <img src="https://github.com/user-attachments/assets/6ff17d93-7dbb-47ae-b22c-fbeee32266b3" width="270" alt="ReGo Logo" />
</p>

<h1 align="center">📝 ReGo - 회고 관리 iOS 앱</h1>
<p align="center">
  감정과 카테고리로 회고를 정리하고, 통계로 돌아보는 성장 기록 앱
</p>

<br />

## ✨ 주요 기능

- 🏠 **홈 탭 (Home)**: 최근 회고 요약, 주∙월 작성 횟수 표시
- 📋 **목록 탭 (List)**: 전체 회고 목록 확인, 키워드 검색 및 카테고리/날짜별 필터링
- 📊 **통계 탭 (Statistics)**: 작성 횟수 및 감정/카테고리별 통계 시각화
- 🎨 **설정 탭 (Setting)**: 테마 설정
- 🔍 **상세보기 (Detail)**: 회고 내용 상세 보기
- ✍️ **생성/수정하기 (Edit)**: 회고 생성 및 수정

<br />

## 🛠 설치 방법

1. 이 저장소를 클론합니다.

   ```
   git clone https://github.com/est-ios-rego/rego.git
   ```
2. Xcode 15 이상에서 ReGo.xcodeproj 또는 ReGo.xcworkspace 열기
3. 시뮬레이터 또는 실제 디바이스에서 실행

<br />

## 📦 사용 프레임워크 및 라이브러리
| 기술 | 설명 |
|------|------|
| SwiftUI | 선언형 UI 프레임워크 |
| SwiftData | Apple 최신 영속성 프레임워크 |
| Charts | 통계 시각화 |
| Foundation | 기본 Swift 라이브러리 |

<br />

## 📁 폴더 구조
```
ReGo/
├── Assets.xcassets/           # 앱 색상, 아이콘 등의 에셋
├── Resources/                 # 샘플 데이터, 색상 정의
├── Sources/                   # 주요 소스코드
│   ├── Components/            # UI 컴포넌트
│   ├── Extensions/            # 확장 기능
│   ├── Models/                # 데이터 모델 정의
│   └── Scenes/                # 각 화면(View) 구성
│       ├── MainView.swift
│       ├── HomeView.swift
│       ├── EditView.swift
│       ├── StatisticsView.swift
│       ├── SettingView.swift
│       ├── ListView.swift
│       └── DetailView.swift
└── ReGoApp.swift              # 앱 진입점
```

<br/>   

## 🧱 데이터 모델

`SwiftData` 기반으로 회고 데이터 구조화 및 저장

```swift
@Model
class Retrospect {
    var title: String
    var content: String
    var date: Date
    var category: RetrospectCategory
    var mood: Mood
}
```
- **RetrospectCategory**: `.daily`, `.work`, `.study`, `.relationship`, `.goal`, `.lesson`, `.all`
- **Mood**: `.happy`, `.sad`, `.angry`, `.tired`, `.excited`, `.neutral`, `.anxious`

<br/>   

## 💾 저장 방식 (SwiftData)
- `@Model`: 모델 정의
- `@Query`: View에 데이터 자동 바인딩
- CRUD: SwiftData API 기반 처리
- 변경 사항은 **실시간 UI 반영**

<br/>

## 🌗 UI/UX 지원 사항
| 항목 | 설명 |
|------|------|
| 🌙 다크 모드 | 시스템 테마에 따라 UI 자동 전환 |
| 🧑‍🦯 접근성 | Dynamic Type (글자 크기) 지원 |
| 🚀 성능 최적화 | LazyView, @State 분리로 렌더링 최소화 |

<br/>   

## 👨‍💻 개발진 (Contributors)

| 이름 | GitHub |
|--|--|
| 김재훈 | [@jaehun6165](https://github.com/jaehun6165) |
| 김종성 | [@jseongee](https://github.com/jseongee) |
| 서재효 | [@jaehyo0318](https://github.com/jaehyo0318) |
| 성주현 | [@zudugy](https://github.com/zudugy) |
