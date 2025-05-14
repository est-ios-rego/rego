//
//  HomeView.swift
//  ReGo
//
//  Created by  서재효 on 5/12/25.
//

import SwiftUI


struct HomeView: View {
    @State private var brownHeight: CGFloat = 50
    @State private var mintHeight: CGFloat = 40
    @State private var beigeHeight: CGFloat = 50
    @State private var apricotHeight: CGFloat = 40
    @State private var lavenderHeight: CGFloat = 50

    @Binding var selectedIndex: Int

    @Environment(\.colorScheme) var colorScreme

    var readStrokeColor: Color {
        colorScreme == .dark ? .white : .black

    }

    var buttonStrokeColor: Color {
        colorScreme == .dark ? .brown.opacity(0.7) : Color("AppCategoryBg2").opacity(0.7)

    }


    var infiniteAnimation: Animation {
        Animation.easeInOut(duration: 4).repeatForever(autoreverses: true)
    }


    var monthlyCount: Int {
        let calendar = Calendar.current
        let now = Date()

        let components = calendar.dateComponents([.year, .month], from: now)
        guard let startOfMonth = calendar.date(from: components),
              let endOfMonth = calendar.date(byAdding: DateComponents(month: 1, day: -1), to: startOfMonth) else {
            return 0
        }

        return Retrospect.sampleData.filter {
            $0.date >= startOfMonth && $0.date <= endOfMonth
        }.count
    }

    var weeklyCount: Int {
        let calendar = Calendar.current
        let now = Date()


        let weekday = calendar.component(.weekday, from: now)
        guard let startOfWeek = calendar.date(byAdding: .day, value: -(weekday - 1), to: now),
              let endOfWeek = calendar.date(byAdding: .day, value: 7 - weekday, to: now) else {
            return 0
        }

        return Retrospect.sampleData.filter {
            $0.date >= startOfWeek && $0.date <= endOfWeek
        }.count
    }

    var body: some View {
        NavigationStack {
            GeometryReader { geo in
                VStack {

                    VStack {

                        VStack {

                            HStack {

                                Image(systemName: "scribble.variable")
                                    .font(.largeTitle)
                                    .foregroundStyle(.orange)
                                    .bold()

                                VStack(alignment: .center, spacing: 4) {
                                    Text("ReGo")
                                        .italic()
                                        .font(.largeTitle)
                                        .bold()
                                        .foregroundStyle(.orange)


                                    Text("오늘보다 발전된 내일이 되기")
                                        .font(.subheadline)
                                        .foregroundColor(readStrokeColor)

                                }

                            }
                            .shadow(color: .white.opacity(0.3), radius: 1, x: 0, y: 2)

                            .frame(
                                maxWidth: geo.size.width > 600 ? 600 : .infinity,
                                alignment: .center
                            )

                            .frame(maxWidth: .infinity)
                            .padding(.top, 45)
                            .padding(.trailing, 50)





                        }

                        Spacer()


                        VStack(alignment: .center) {

                            HStack(alignment: .bottom) {

                                Rectangle()
                                    .foregroundColor(.brown.opacity(0.9))
                                    .frame(width: 40, height: brownHeight)
                                    .cornerRadius(6)
                                    .shadow(color: .brown.opacity(0.5), radius: 2, x: 0, y: 5)
                                    .onAppear {
                                        withAnimation(infiniteAnimation) {
                                            brownHeight = 130
                                        }
                                    }

                                Rectangle()
                                    .foregroundColor(.mint.opacity(0.4))
                                    .frame(width: 40, height: mintHeight)
                                    .cornerRadius(6)
                                    .shadow(color: .mint.opacity(0.4), radius: 2, x: 0, y: 5)
                                    .onAppear {
                                        withAnimation(infiniteAnimation) {
                                            mintHeight = 120
                                        }
                                    }

                                Rectangle()
                                    .foregroundColor(.brown.opacity(0.5))
                                    .frame(width: 40, height: beigeHeight)
                                    .cornerRadius(6)
                                    .shadow(color: .brown.opacity(0.4), radius: 2, x: 0, y: 5)
                                    .onAppear {
                                        withAnimation(infiniteAnimation) {
                                            beigeHeight = 140
                                        }
                                    }

                                Rectangle()
                                    .foregroundColor(.orange.opacity(0.4))
                                    .frame(width: 40, height: apricotHeight)
                                    .cornerRadius(6)
                                    .shadow(color: .orange.opacity(0.4), radius: 2, x: 0, y: 5)
                                    .onAppear {
                                        withAnimation(infiniteAnimation) {
                                            apricotHeight = 110
                                        }
                                    }

                                Rectangle()
                                    .foregroundColor(.red.opacity(0.4))
                                    .frame(width: 40, height: lavenderHeight)
                                    .cornerRadius(6)
                                    .shadow(color: .red.opacity(0.3), radius: 2, x: 0, y: 5)
                                    .onAppear {
                                        withAnimation(infiniteAnimation) {
                                            lavenderHeight = 150
                                        }
                                    }
                            }

                            .frame(height: 100, alignment: .bottom)
                            .padding()

                            VStack {

                                HStack {

                                    Text("최근 작성한 회고")
                                        .font(.headline)
                                        .foregroundColor(readStrokeColor)
                                        .padding(.leading, 20)



                                    Button {
                                        selectedIndex = 1
                                    } label: {

                                        Text("목록보기")
                                            .font(.caption)
                                            .frame(maxWidth: .infinity, alignment: .trailing)
                                            .padding(.top)
                                            .padding(.trailing, 20)
                                    }

                                }

                                if Retrospect.sampleData.isEmpty {

                                    ZStack {

                                        RoundedRectangle(cornerRadius: 30)
                                            .fill(.orange.opacity(0.4))
                                            .frame(width: 120, height: 80)
                                            .shadow(color: .white.opacity(0.3), radius: 4, x: 0, y: 5)

                                        Text("회고를 작성해주세요")
                                            .font(.caption)
                                            .foregroundColor(readStrokeColor)
                                    }
                                } else {

                                    let recentRetros = Retrospect.sampleData
                                        .sorted(by: { $0.date > $1.date })
                                        .prefix(4)

                                    ScrollView(.horizontal, showsIndicators: false) {

                                        HStack(spacing: 10) {

                                            ForEach(Array(recentRetros), id: \.id) { retrospect in
                                                NavigationLink(destination: DetailView(retro: retrospect)) {

                                                    ZStack {

                                                        RoundedRectangle(cornerRadius: 30)
                                                            .fill(.orange.opacity(0.4))
                                                            .frame(width: 120, height: 80)
                                                            .shadow(color: .white.opacity(0.3), radius: 3, x: 0, y: 2)

                                                        Text(retrospect.title)
                                                            .font(.headline)
                                                            .foregroundColor(readStrokeColor)
                                                            .multilineTextAlignment(.center)
                                                            .lineLimit(2)
                                                            .padding(.horizontal, 5)
                                                    }
                                                }
                                            }
                                        }
                                        .padding(.horizontal, 10)
                                    }
                                }



                            }
                            .frame(
                                maxWidth: geo.size.width > 600 ? 600 : .infinity,
                                alignment: .center
                            )


                            VStack {


                                Button {
                                    selectedIndex = 2
                                } label: {

                                    Text("통계보기")
                                        .font(.caption)
                                        .frame(maxWidth: .infinity, alignment: .trailing)
                                        .padding(.top)
                                        .padding(.trailing, 20)
                                }

                                HStack {

                                    ZStack{

                                        RoundedRectangle(cornerRadius: 30)
                                            .fill(Color(red: 1.0, green: 0.85, blue: 0.8).opacity(0.35))
                                            .frame(width: 130, height: 90)
                                            .shadow(color: .white.opacity(0.3), radius: 3, x: 0, y: 2)

                                        VStack {

                                            Text("       이번달\n회고 작성 횟수 :\n")
                                                .font(.caption)
                                                .bold()
                                                .foregroundColor(readStrokeColor)
                                                .padding(1)


                                            Text("\(monthlyCount)회")
                                                .font(.headline)
                                                .bold()
                                                .foregroundColor(.pink.opacity(0.8))
                                        }
                                        .padding(.bottom, 5)
                                        .frame(width: 130, height: 80)
                                    }

                                    .padding(.horizontal, 10)
                                    .padding(10)

                                    ZStack{

                                        RoundedRectangle(cornerRadius: 30)
                                            .fill(Color(red: 0.78, green: 0.9, blue: 0.82).opacity(0.35))
                                            .frame(width: 130, height: 90)
                                            .shadow(color: .white.opacity(0.3), radius: 3, x: 0, y: 2)


                                        VStack(alignment: .center, spacing: 0) {

                                            Text("       이번주\n회고 작성 횟수 :\n")
                                                .font(.caption)
                                                .bold()
                                                .foregroundColor(readStrokeColor)
                                                .padding(1)

                                            Text("\(weeklyCount)회")
                                                .font(.headline)
                                                .bold()
                                                .foregroundColor(.mint.opacity(0.8))
                                        }
                                        .padding(.bottom, 5)
                                        .frame(width: 130, height: 80)
                                    }
                                    .padding(.horizontal, 10)
                                    .padding(10)

                                }


                                .padding(.bottom)

                            }
                            .frame(
                                maxWidth: geo.size.width > 600 ? 600 : .infinity,
                                alignment: .center
                            )
                            .padding(10)
                        }
                    }



                    NavigationLink(destination: EditView(mode: .create)) {

                        VStack {

                            HStack {

                                Spacer()

                                Text(Image(systemName: "pencil.and.scribble"))
                                    .foregroundColor(readStrokeColor)
                                    .bold()


                                Text("Write")
                                    .italic()
                                    .bold()
                                    .frame(alignment: .leading)
                                    .foregroundColor(readStrokeColor)




                                Spacer()

                            }
                            .frame(width: 300, height: 40)
                            .background(buttonStrokeColor)
                            .shadow(color: .white.opacity(0.3), radius: 4, x: 0, y: 5)
                            .cornerRadius(12)
                            .frame(maxWidth: .infinity)
                            .padding(.bottom, 10)

                        }
                        .padding(.bottom, 40)


                    }
                }
                .scrollContentBackground(.hidden)
                .background(Color("AppBackground"))
            }
        }
    }
}


struct StatefulPreviewWrapper<Value, Content: View>: View {
    @State var value: Value
    var content: (Binding<Value>) -> Content

    init(_ initialValue: Value, content: @escaping (Binding<Value>) -> Content) {
        _value = State(wrappedValue: initialValue)
        self.content = content
    }

    var body: some View {
        content($value)
    }
}

#Preview {
    StatefulPreviewWrapper(0) { binding in
        HomeView(selectedIndex: binding)
    }
}

