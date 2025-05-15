//
//  HomeView.swift
//  ReGo
//
//  Created by  서재효 on 5/12/25.
//

import SwiftUI

extension Font {
    static var extraLargeTitle: Font {
        .system(size: 55, weight: .bold)
    }
}

struct HomeView: View {
    @State private var brownHeight: CGFloat = 50
    @State private var mintHeight: CGFloat = 40
    @State private var beigeHeight: CGFloat = 50
    @State private var apricotHeight: CGFloat = 40
    @State private var lavenderHeight: CGFloat = 50
    @State private var recentRetros: [Retrospect] = []
    

    @Binding var selectedIndex: Int

    @Environment(\.colorScheme) var colorScreme

    var readStrokeColor: Color {
        colorScreme == .dark ? .white : .black

    }

    var buttonStrokeColor: Color {
        colorScreme == .dark ? .brown.opacity(0.7) : Color.regoCategoryBg2.opacity(0.7)

    }

    var barStrokeColor: Color {
        colorScreme == .dark ? Color(red: 1.0, green: 0.85, blue: 0.8).opacity(0.45) : Color(red: 1.0, green: 0.85, blue: 0.8).opacity(0.9).opacity(0.9)
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

    private var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy.MM.dd"
        return formatter
    }


    var body: some View {
        NavigationStack {
            GeometryReader { geo in
                VStack {

                    VStack {

                        VStack {

                            HStack {

                                Image(systemName: "scribble.variable")
                                    .font(Font.extraLargeTitle)
                                    .foregroundStyle(.orange)
                                    .bold()

                                VStack(alignment: .center, spacing: 4) {
                                    Text("ReGo")
                                        .italic()
                                        .font(Font.extraLargeTitle)
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

                        VStack {
                            VStack(alignment: .center) {

                                if geo.size.width > 600 && geo.size.height > geo.size.width {
                                    Spacer()
                                }

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
                                .padding(.bottom, 10)

                                if geo.size.width > 600 && geo.size.height > geo.size.width {
                                    Spacer()
                                }
                                
                                VStack {

                                    HStack {

                                        Text("최근 작성한 회고")
                                            .font(.headline)
                                            .foregroundColor(readStrokeColor)



                                        Spacer()

                                        Button {
                                            selectedIndex = 1
                                        } label: {

                                            Text("목록보기")
                                                .font(.caption)
                                                .frame(alignment: .trailing)
                                                .foregroundStyle(Color.regoAccent)

                                        }

                                    }
                                    .padding(.horizontal, 20)



                                    if recentRetros.isEmpty {


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

                                        HStack(spacing: 7) {

                                            ForEach(recentRetros, id: \.id) { retrospect in
                                                NavigationLink(destination: DetailView(retro: retrospect)) {

                                                    ZStack {

                                                        RoundedRectangle(cornerRadius: 30)
                                                            .fill(.orange.opacity(0.4))
                                                            .frame(height: 80)
                                                            .shadow(color: .white.opacity(0.3), radius: 3, x: 0, y: 2)

                                                        VStack {
                                                            Text(dateFormatter.string(from: retrospect.date))
                                                                .font(.caption2)
                                                                .foregroundColor(readStrokeColor)



                                                            Text(retrospect.title)
                                                                .font(.headline)
                                                                .foregroundColor(readStrokeColor)
                                                                .multilineTextAlignment(.center)
                                                                .lineLimit(2)
                                                                .padding(.horizontal, 5)
                                                                .padding(.bottom, 15)
                                                        }
                                                    }
                                                }

                                            }

                                        }
                                        .padding(.horizontal, 10)


                                    }




                                }
                                .frame(
                                    maxWidth: geo.size.width > 600 ? 600 : .infinity,
                                    alignment: .center
                                )
                                .padding(.horizontal, 5)
                                .padding(.top, 30)


                                VStack {

                                    HStack {

                                        Spacer()

                                        Button {
                                            selectedIndex = 2
                                        } label: {

                                            Text("통계보기")
                                                .font(.caption)
                                                .frame(alignment: .trailing)
                                                .foregroundStyle(Color.regoAccent)

                                        }
                                    }
                                    .padding(.horizontal, 20)

                                    HStack {

                                        ZStack{

                                            RoundedRectangle(cornerRadius: 30)
                                                .fill(barStrokeColor)
                                                .frame(height: 80)
                                                .shadow(color: .brown.opacity(0.3), radius: 3, x: 0, y: 2)

                                            VStack {

                                                Text("이번달 회고 작성 횟수 :\n")
                                                    .font(.caption)
                                                    .bold()
                                                    .foregroundColor(readStrokeColor)
                                                    .padding(.top, 5)


                                                Text("\(monthlyCount)회")
                                                    .font(.headline)
                                                    .bold()
                                                    .foregroundColor(Color(red: 0.85, green: 0.55, blue: 0.55).opacity(0.9))
                                            }
                                            .padding(.bottom, 15)
                                            .frame(height: 80)
                                        }



                                        ZStack{

                                            RoundedRectangle(cornerRadius: 30)
                                                .fill(barStrokeColor)
                                                .frame(height: 80)
                                                .shadow(color: .brown.opacity(0.3), radius: 3, x: 0, y: 2)


                                            VStack(alignment: .center, spacing: 0) {

                                                Text("이번주 회고 작성 횟수 :\n")
                                                    .font(.caption)
                                                    .bold()
                                                    .foregroundColor(readStrokeColor)
                                                    .padding(.top, 5)

                                                Text("\(weeklyCount)회")
                                                    .font(.headline)
                                                    .bold()
                                                    .foregroundColor(Color(red: 0.85, green: 0.55, blue: 0.55).opacity(0.9))
                                            }
                                            .padding(.bottom, 15)
                                            .frame(height: 80)
                                        }


                                    }
                                    .padding(.horizontal, 5)
                                    .padding(.bottom)

                                }
                                .frame(
                                    maxWidth: geo.size.width > 600 ? 600 : .infinity,
                                    alignment: .center
                                )
                                .padding(10)
                            }
                        }
                    }



                    NavigationLink(destination: EditView(mode: .create, retro: Retrospect.emptyData)) {
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

                .onAppear {
                    recentRetros = Retrospect.sampleData
                        .sorted(by: { $0.date > $1.date })
                        .prefix(3)
                        .map { $0 }
                }
                .scrollContentBackground(.hidden)
                .background(Color.regoBackground)
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

