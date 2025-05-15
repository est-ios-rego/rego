<img width="270" alt="스크린샷 2025-05-15 오전 11 25 14" src="https://github.com/user-attachments/assets/6ff17d93-7dbb-47ae-b22c-fbeee32266b3" />

# ReGo - 회고 관리 앱

ReGo는 일상 및 회고를 기록하고, 카테고리와 감정 상태로 분류하며, 주∙월간 통계를 통해 회고 패턴을 분석할 수 있는 iOS 앱입니다. SwiftUI 및 SwiftData를 기반으로 개발되었습니다.

## ✨ 주요 기능

- Home 화면: 최근 작성 회고 빠른 접근 및 주∙월 작성 횟수
- List 화면: 전체 회고 목록 및 검색, 필터링
- Statistics 화면: 감정/카테고리 기반 통계 제공
- Setting 화면: 앱 테마 설정
- Detail 화면: 회고 상세 보기
- Edit 화면: 회고 생성 및 수정

## 🛠 설치 방법

1. 이 저장소를 클론합니다.

   ```
   git clone https://github.com/yourusername/ReGo.git
   ```
2. Xcode 15 이상을 실행한 후 ReGo.xcodeproj 또는 ReGo.xcworkspace를 엽니다.
3. 시뮬레이터 또는 실제 디바이스에서 실행합니다.

## 📦 의존 라이브러리
- SwiftUI
- SwiftData
- Foundation - 기본 Swift 프레임워크
- Charts - 통계 화면 시각화

## 📁 폴더 구조
```
ReGo/
├── Assets.xcassets/           # 앱 색상, 아이콘 등의 에셋
├── Resources/                 # 샘플 데이터, 색상 정의
├── Sources/                   # 주요 소스코드
│   ├── Components/
│   ├── Extensions/
│   ├── Models/
│   └── Scenes/                # 각 화면(View) 구성
│       ├── MainView.swift
│       ├── HomeView.swift
│       ├── EditView.swift
│       ├── StatisticsView.swift
│       ├── SettingView.swift
│       ├── ListView.swift
│       └── DetailView.swift
├── ReGoApp.swift              # App 진입점
```

## 🧱 데이터 모델

ReGo는 SwiftData를 기반으로 회고 데이터를 구조화하여 저장합니다.

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
- `RetrospectCategory`: .daily, .work, .study, .relationship, .goal, .lesson, .all
- `Mood`: .happy, .sad, .angry, .tired, .excited, .neutral, .anxious

## 💾 저장 방식 (SwiftData)
ReGo는 Apple이 제공하는 최신 영속성 프레임워크인 SwiftData를 사용합니다.
- @Model을 통해 모델 정의
- @Query로 회고 목록 바인딩
- CRUD 작업은 SwiftData API로 처리
- 변경사항은 실시간으로 UI에 반영됨

## 🌗 UI/UX 지원 사항
ReGo는 다양한 사용자 환경을 고려하여 다음과 같은 기능을 제공합니다.

✅ 다크 모드 지원
시스템 테마에 따라 배경색 및 텍스트 색상 자동 변경

✅ 접근성(Accessibility)
Dynamic Type 대응 (시스템 글꼴 크기 반영)

✅ 성능 최적화
LazyView 및 화면 단위 상태 관리(@State, @Environment) 적용
불필요한 View 재렌더링 방지를 위한 구조 설계
