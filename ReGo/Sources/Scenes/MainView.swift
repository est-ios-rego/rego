import SwiftUI
import SwiftData

/// 앱의 메인 화면을 구성하는 뷰입니다.
///
/// `TabView`를 사용하여 홈, 목록, 통계, 설정 화면 간의 탭 전환을 제공합니다.
/// 선택된 탭 인덱스는 `@SceneStorage`를 통해 상태가 유지되며,
/// `ToastManager`를 전역 환경으로 공유하여 토스트 메시지를 표시합니다.
///
/// - 주요 탭:
///   - 홈 (HomeView)
///   - 목록 (ListView)
///   - 통계 (StatisticsView)
///   - 설정 (SettingView)
struct MainView: View {
    /// 현재 선택된 탭의 인덱스를 저장하며, 앱 종료 후에도 상태를 유지합니다.
    @SceneStorage("selectedTab") private var selectedIndex = 0
    /// 토스트 메시지의 상태를 관리하는 객체입니다.
    @StateObject private var toastManager = ToastManager()

    var body: some View {
        TabView(selection: $selectedIndex) {
            HomeView(selectedIndex: $selectedIndex)
                .tabItem {
                    Label("홈", systemImage: "house")
                }
                .tag(0)

            ListView()
                .tabItem {
                    Label("목록", systemImage: "list.bullet.clipboard")
                }
                .tag(1)

            StatisticsView()
                .tabItem {
                    Label("통계", systemImage: "pencil.slash")
                }
                .tag(2)

            SettingView()
                .tabItem {
                    Label("설정", systemImage: "gear")
                }
                .tag(3)
        }
        .environmentObject(toastManager)
        .modifier(ToastModifier(isPresented: $toastManager.isPresented, message: toastManager.message))
    }
}

#Preview {
    MainView()
}
