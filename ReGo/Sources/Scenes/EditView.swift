import SwiftUI

/// 회고 생성 또는 수정 모드를 나타내는 열거형
enum EditMode {
    case create
    case update
}

/// 회고 작성 및 수정 화면을 제공하는 뷰
struct EditView: View {
    /// 생성/수정 모드 지정
    let mode: EditMode

    /// 대상 회고 객체 (Bindable로 SwiftData 연동)
    @Bindable var retro: Retrospect

    // 원본 데이터 저장용 (변경 감지)
    @State private var originalTitle: String = ""
    @State private var originalContent: String = ""
    @State private var originalDate: Date = Date()
    @State private var originalCategory: RetrospectCategory = .daily
    @State private var originalMood: Mood = .neutral

    // 입력 값 상태
    @State private var title: String = ""
    @State private var content: String = ""
    @State private var date: Date = Date()
    @State private var category: RetrospectCategory = .daily
    @State private var mood: Mood = .neutral

    // 피커 및 알림 상태 제어
    @State private var showCategoryPicker = false
    @State private var showDatePicker = false
    @State private var showMoodPicker = false
    @State private var showDismissAlert = false
    @State private var showTitleAlert = false

    @FocusState private var isTitleFocused: Bool

    @EnvironmentObject private var toastManager: ToastManager

    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var modelContext

    /// 네비게이션 타이틀 (모드에 따라 다름)
    private var navigationTitle: String {
        switch mode {
        case .create: return "생성하기"
        case .update: return "수정하기"
        }
    }

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                TitleSection(title: $title, isTitleFocused: $isTitleFocused)

                ContentSection(content: $content)

                CategorySection(category: $category, showCategoryPicker: $showCategoryPicker)

                DateSection(date: $date, showDatePicker: $showDatePicker)

                MoodSection(mood: $mood, showMoodPicker: $showMoodPicker)
            }
            .padding()
        }
        .scrollContentBackground(.hidden)
        .background(Color.regoBackground)
        .navigationTitle(navigationTitle)
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden()
        .toolbar(.hidden, for: .tabBar)
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button {
                    if isDataChanged {
                        showDismissAlert = true
                    } else {
                        dismiss()
                    }
                } label: {
                    Image(systemName: "chevron.left")
                        .foregroundStyle(Color.regoAccent)
                }
            }
            ToolbarItem(placement: .topBarTrailing) {
                Button("저장") {
                    print("date: \(date), retro.date: \(retro.date)")
                    onClickSave()
                }
                .foregroundStyle(Color.regoAccent)
            }
        }
        .onAppear {
            if mode == .create {
                isTitleFocused = true
            }

            initRetro()
        }
        .alert("변경사항이 저장되지 않았습니다.\n나가시겠습니까?", isPresented: $showDismissAlert) {
            Button("취소", role: .cancel) {}

            Button("나가기", role: .destructive) {
                dismiss()
            }
        }
        .alert("제목을 입력해주세요.", isPresented: $showTitleAlert) {
            Button("확인") {
                isTitleFocused = true
            }
        }
    }
}

// MARK: - 내부 로직 확장
extension EditView {

    /// 입력값이 원본 회고 데이터에서 변경되었는지를 판단합니다.
    ///
    /// - Returns: 하나 이상의 필드가 변경되었을 경우 `true`, 그렇지 않으면 `false`
    private var isDataChanged: Bool {
        let calendar = Calendar.current
        let isSameDay = calendar.isDate(originalDate, inSameDayAs: date)

        return title != originalTitle ||
               content != originalContent ||
               category != originalCategory ||
               !isSameDay ||
               mood != originalMood
    }

    /// 수정 모드에서 사용되는 초기화 함수로,
    /// 원본 회고 데이터를 바인딩된 상태값들에 복사하여 편집 준비를 마칩니다.
    private func initRetro() {
        originalTitle = retro.title
        originalContent = retro.content
        originalCategory = retro.category
        originalDate = retro.date
        originalMood = retro.mood

        title = retro.title
        content = retro.content
        category = retro.category
        date = retro.date
        mood = retro.mood
    }

    /// 저장 버튼 클릭 시 호출되는 함수입니다.
    ///
    /// 입력값을 검증한 뒤, 생성 또는 수정 모드에 따라 데이터를 저장합니다.
    /// 저장 후 현재 뷰를 닫습니다.
    private func onClickSave() {
        guard validateTitle() else { return }

        switch mode {
        case .create:
            createRetrospect()
        case .update:
            updateRetrospect()
        }

        dismiss()
    }

    /// 사용자가 입력한 제목의 유효성을 검사합니다.
    ///
    /// - Returns: 제목이 비어있지 않으면 `true`, 그렇지 않으면 경고 알림을 띄우고 `false`
    private func validateTitle() -> Bool {
        if title.isEmpty {
            showTitleAlert = true
            return false
        }
        return true
    }

    /// 새로운 회고 데이터를 생성하고 SwiftData에 저장합니다.
    ///
    /// 이 함수는 생성 모드에서만 호출됩니다.
    private func createRetrospect() {
        let newRetro = Retrospect(
            title: title,
            content: content,
            date: date,
            category: category,
            mood: mood
        )
        modelContext.insert(newRetro)
        saveData()
        toastManager.show(message: "생성되었습니다.")
    }

    /// 기존 회고 데이터를 현재 입력값으로 수정하고 저장합니다.
    ///
    /// 이 함수는 수정 모드에서만 호출됩니다.
    private func updateRetrospect() {
        retro.title = title
        retro.content = content
        retro.date = date
        retro.category = category
        retro.date = date
        retro.mood = mood
        saveData()
        toastManager.show(message: "수정되었습니다.")
    }

    /// SwiftData의 모델 컨텍스트를 사용하여 변경 사항을 저장합니다.
    ///
    /// 저장 중 오류가 발생해도 앱이 크래시되지 않도록 예외를 무시합니다.
    private func saveData() {
        try? modelContext.save()
    }
}

// MARK: - UI 섹션 뷰

/// 제목을 입력할 수 있는 UI 섹션
///
/// 사용자가 회고의 제목을 작성할 수 있도록 돕는 `TextField`를 포함합니다.
/// 포커스 상태 바인딩을 통해 자동 포커싱 기능을 지원합니다.
struct TitleSection: View {
    /// 회고 제목 바인딩
    @Binding var title: String
    /// 제목 입력란의 포커스 상태 바인딩
    @FocusState.Binding var isTitleFocused: Bool

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("제목")
                .font(.subheadline)
                .foregroundColor(.secondary)
            
            TextField("제목을 입력해주세요.", text: $title)
                .padding(12)
                .background(Color.regoBackground2)
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.gray.opacity(0.2), lineWidth: 1)
                )
                .autocapitalization(.none)
                .autocorrectionDisabled(true)
                .focused($isTitleFocused)
        }
    }
}

/// 회고 내용을 입력할 수 있는 UI 섹션
///
/// 사용자가 상세 내용을 자유롭게 입력할 수 있는 `TextEditor`를 포함합니다.
struct ContentSection: View {
    /// 회고 내용 바인딩
    @Binding var content: String

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("내용")
                .font(.subheadline)
                .foregroundColor(.secondary)
            
            TextEditor(text: $content)
                .padding(12)
                .frame(minHeight: 200, maxHeight: 400)
                .scrollContentBackground(.hidden)
                .background(Color.regoBackground2)
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.gray.opacity(0.2), lineWidth: 1)
                )
                .autocapitalization(.none)
                .autocorrectionDisabled(true)
        }
    }
}

/// 카테고리를 선택할 수 있는 UI 섹션
///
/// 버튼을 눌러 `CategoryPickerView` 를 열어 카테고리를 선택할 수 있도록 구성된 섹션입니다.
struct CategorySection: View {
    /// 선택된 카테고리 바인딩
    @Binding var category: RetrospectCategory
    /// 카테고리 피커 표시 여부 바인딩
    @Binding var showCategoryPicker: Bool

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("카테고리")
                .font(.subheadline)
                .foregroundColor(.secondary)
            
            Button {
                showCategoryPicker = true
            } label: {
                HStack {
                    Text("\(category.displayName)")
                        .foregroundColor(.primary)
                    Spacer()
                    Image(systemName: "chevron.right")
                        .foregroundColor(.gray)
                }
                .padding()
                .background(Color.regoBackground2)
                .cornerRadius(8)
            }
            .sheet(isPresented: $showCategoryPicker) {
                CategoryPickerView(isPresented: $showCategoryPicker, currentCategory: $category)
            }
        }
    }
}

/// 날짜를 선택할 수 있는 UI 섹션
///
/// 현재 선택된 날짜를 보여주며, 버튼을 통해 `DatePickerView`를 띄울 수 있습니다.
struct DateSection: View {
    /// 선택된 날짜 바인딩
    @Binding var date: Date
    /// 날짜 피커 표시 여부 바인딩
    @Binding var showDatePicker: Bool
    /// 미래시점의 Date 값 선택시 alert창 표시여부
    @State var showAlert = false

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("날짜")
                .font(.subheadline)
                .foregroundColor(.secondary)
            
            Button {
                showDatePicker = true

            } label: {
                HStack {
                    Text("\(date.toDetailDate)")
                        .foregroundColor(.primary)
                    Spacer()
                    Image(systemName: "chevron.right")
                        .foregroundColor(.gray)
                }
                .padding()
                .background(Color.regoBackground2)
                .cornerRadius(8)
            }
            .sheet(isPresented: $showDatePicker) {
                DatePickerSheet(isPresented: $showDatePicker, currentDate: $date)
            }
            .onChange(of: date) { value in
                if Date.now < value {
                    showAlert = true
                }
            }
            .alert("미래의 회고를 작성할 수 없습니다.", isPresented: $showAlert) {
                Button("확인") {
                    showDatePicker = true
                }
            }

        }
    }
}

/// 오늘의 기분을 선택할 수 있는 UI 섹션
///
/// 현재 선택된 기분 이모지와 이름을 보여주며, 버튼을 통해 `MoodPickerView`를 띄울 수 있습니다.
struct MoodSection: View {
    /// 선택된 기분 바인딩
    @Binding var mood: Mood
    /// 기분 피커 표시 여부 바인딩
    @Binding var showMoodPicker: Bool

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("오늘의 기분")
                .font(.subheadline)
                .foregroundColor(.secondary)
            Button {
                showMoodPicker = true
            } label: {
                HStack {
                    Text("\(mood.emoji) \(mood.name)")
                        .foregroundColor(.primary)
                    Spacer()
                    Image(systemName: "chevron.right")
                        .foregroundColor(.gray)
                }
                .padding()
                .background(Color.regoBackground2)
                .cornerRadius(8)
            }
            .sheet(isPresented: $showMoodPicker) {
                MoodPickerView(isPresented: $showMoodPicker, currentMood: $mood)
            }
        }
    }
}

#Preview {
    let sampleRetro = Retrospect(
        title: "수정할 제목",
        content: "수정할 내용입니다.",
        date: Date(),
        category: .daily,
        mood: .happy
    )

    NavigationStack {
        // 생성 모드 미리보기
        // EditView(mode: .create)

        // 수정 모드 미리보기
        EditView(mode: .update, retro: sampleRetro)
    }
}
