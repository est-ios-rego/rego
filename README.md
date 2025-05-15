<img width="270" alt="스크린샷 2025-05-15 오전 11 25 14" src="https://github.com/user-attachments/assets/6ff17d93-7dbb-47ae-b22c-fbeee32266b3" />

# ReGo - 회고 관리 앱

ReGo는 자기 성찰이나 업무 회고를 습관화하고 싶은 개인 사용자 혹은 팀을 위한 iOS 앱입니다.</br>
일상의 감정 변화나 업무 피드백을 기록함으로써 자기 인식을 높이고 성장 패턴을 시각화할 수 있습니다.

<br/>

## ✨ 주요 기능

### 홈 탭
- 최근 작성한 회고들을 확인하고, '목록보기' 버튼을 통해 목록 탭으로 이동할 수 있습니다.
- 이번달/이번주의 회고 작성 횟수를 확인하고, '통계보기' 버튼을 통해 통계 탭으로 이동할 수 있습니다.

### 목록 탭
- 전체 회고 목록을 확인할 수 있습니다.
- 제목을 기준으로 검색하거나 카테고리/날짜별로 필터링할 수 있습니다.

### 통계 탭
- 주/월별로 나누어 회고 작성 빈도를 시각화하여 확인할 수 있습니다.
- 감정/카테고리별로 시각화된 데이터를 확인할 수 있습니다.

### 설정 탭
- 시스템, 라이트모드와 다크모드를 설정할 수 있습니다.

### 상세보기 화면
- 회고의 본문 내용을 확인할 수 있습니다.
- 메뉴를 통해 수정/삭제할 수 있습니다.

### 생성/수정 화면
- 제목과 내용을 입력하고, 카테고리와 날짜, 오늘의 기분을 선택할 수 있습니다.

<br/>

## 🛠 설치 방법

1. 이 저장소를 클론합니다.

   ```
   git clone https://github.com/yourusername/ReGo.git
   ```
2. Xcode 15 이상을 실행한 후 ReGo.xcodeproj 또는 ReGo.xcworkspace를 엽니다.
3. 시뮬레이터 또는 실제 디바이스에서 실행합니다.

<br/>

## 📦 의존 라이브러리
- SwiftUI
- SwiftData
- Foundation
- Charts - Apple 공식 라이브러리로 통계 데이터를 시각적으로 표현

<br/>

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
└── ReGoApp.swift              # App 진입점
```

<br/>   

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

// 회고의 카테고리를 나타내는 열거형
enum RetrospectCategory: String, Codable, CaseIterable {
    case daily, work, study, relationship, goal, lesson, all
}

// 회고 작성 시 선택 가능한 감정 상태를 나타내는 열거형
enum Mood: String, CaseIterable, Identifiable, Codable, Equatable {
    case happy, sad, angry, tired, excited, neutral, anxious
}
```

<br/>   

## 💾 저장 방식 (SwiftData)
ReGo는 Apple이 제공하는 최신 영속성 프레임워크인 SwiftData를 사용합니다.
- @Model을 통해 모델 정의
- @Query로 회고 목록 바인딩
- CRUD 작업은 SwiftData API로 처리
- 변경사항은 실시간으로 UI에 반영됨

<br/>

## 🌗 UI/UX 지원 사항
ReGo는 다양한 사용자 환경을 고려하여 다음과 같은 기능을 제공합니다.

✅ 다크 모드 지원
시스템 테마에 따라 배경색 및 텍스트 색상 자동 변경

✅ 접근성(Accessibility)
Dynamic Type 대응 (시스템 글꼴 크기 반영)

✅ 성능 최적화
LazyView 및 화면 단위 상태 관리(@State, @Environment) 적용
불필요한 View 재렌더링 방지를 위한 구조 설계

<br/>   

## 👨‍💻 개발진 (Contributors)

| 이름 | GitHub |
|--|--|
| 김재훈 | [@jaehun6165](https://github.com/jaehun6165) |
| 김종성 | [@jseongee](https://github.com/jseongee) |
| 서재효 | [@jaehyo0318](https://github.com/jaehyo0318) |
| 성주현 | [@zudugy](https://github.com/zudugy) |
