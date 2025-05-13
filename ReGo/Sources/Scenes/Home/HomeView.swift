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

    @Environment(\.colorScheme) var colorScreme

    var readStrokeColor: Color {
        colorScreme == .dark ? .white.opacity(0.8) : .black

    }

    var buttonStrokeColor: Color {
        colorScreme == .dark ? .brown.opacity(0.4) : .brown.opacity(0.2)

    }



    var infiniteAnimation: Animation {
        Animation.linear(duration: 3).repeatForever(autoreverses: true)
    }


    var body: some View {
        NavigationStack {
            VStack {
                VStack {
                    VStack {
                        HStack {
                            Image(systemName: "scribble.variable")
                                .font(.largeTitle)
                                .foregroundStyle(.orange)
                                .bold()

                            VStack(alignment: .leading,spacing: 4) {
                                Text("앱이름")
                                    .italic()
                                    .font(.largeTitle)
                                    .bold()
                                    .foregroundStyle(.orange)

                                Text("오늘보다 발전된 내일이 되기")
                                    .font(.subheadline)
                                    .foregroundColor(readStrokeColor)

                            }

                        }
                        .frame(maxWidth: .infinity)
                        .padding(.horizontal)





                    }
                    Spacer()


                    VStack(alignment: .center) {
                        HStack(alignment: .bottom) {

                            Rectangle()
                                .foregroundColor(.brown.opacity(0.9))
                                .frame(width: 40, height: brownHeight)
                                .cornerRadius(6)
                                .shadow(color: .brown.opacity(0.9), radius: 4, x: 0, y: 5)
                                .onAppear {
                                    withAnimation(infiniteAnimation) {
                                        brownHeight = 130
                                    }
                                }

                            Rectangle()
                                .foregroundColor(.mint.opacity(0.4))
                                .frame(width: 40, height: mintHeight)
                                .cornerRadius(6)
                                .shadow(color: .mint.opacity(0.4), radius: 4, x: 0, y: 5)
                                .onAppear {
                                    withAnimation(infiniteAnimation) {
                                        mintHeight = 120
                                    }
                                }

                            Rectangle()
                                .foregroundColor(.brown.opacity(0.5))
                                .frame(width: 40, height: beigeHeight)
                                .cornerRadius(6)
                                .shadow(color: .brown.opacity(0.4), radius: 4, x: 0, y: 5)
                                .onAppear {
                                    withAnimation(infiniteAnimation) {
                                        beigeHeight = 140
                                    }
                                }

                            Rectangle()
                                .foregroundColor(.orange.opacity(0.4))
                                .frame(width: 40, height: apricotHeight)
                                .cornerRadius(6)
                                .shadow(color: .orange.opacity(0.4), radius: 4, x: 0, y: 5)
                                .onAppear {
                                    withAnimation(infiniteAnimation) {
                                        apricotHeight = 110
                                    }
                                }

                            Rectangle()
                                .foregroundColor(.red.opacity(0.4))
                                .frame(width: 40, height: lavenderHeight)
                                .cornerRadius(6)
                                .shadow(color: .red.opacity(0.3), radius: 4, x: 0, y: 5)
                                .onAppear {
                                    withAnimation(infiniteAnimation) {
                                        lavenderHeight = 150
                                    }
                                }
                        }

                        .frame(height: 100, alignment: .bottom)
                        .padding()

                        NavigationLink(destination: ListView(items: Retrospect.sampleData)) {
                            Text("전체보기")
                                .frame(maxWidth: .infinity, alignment: .trailing)
                                .padding(.top)
                                .padding(.trailing, 10)
                        }

                        ScrollView(.horizontal) {

                            HStack {
                                ZStack{
                                    RoundedRectangle(cornerRadius: 30)
                                        .fill(.brown.opacity(0.4))
                                        .frame(width: 150, height: 150)



                                    Text("이번달 \n회고 작성 횟수 :\n ")
                                        .font(.headline)
                                        .foregroundColor(readStrokeColor)

                                }

                                .padding(.horizontal, 10)
                                .padding(10)

                                ZStack{
                                    RoundedRectangle(cornerRadius: 30)
                                        .fill(.brown.opacity(0.4))
                                        .frame(width: 150, height: 150)



                                    Text("이번달 \n회고 작성 횟수 :\n ")
                                        .font(.headline)
                                        .foregroundColor(readStrokeColor)

                                }
                                .padding(.horizontal, 10)
                                .padding(10)

                                ZStack{
                                    RoundedRectangle(cornerRadius: 30)
                                        .fill(.brown.opacity(0.4))
                                        .frame(width: 150, height: 150)
                                    VStack {
                                        Text("최근 작성한 회고")
                                            .font(.headline)
                                            .foregroundColor(readStrokeColor)

                                        NavigationLink(destination: ListItem(item: Retrospect.sampleData[0])) {
                                            Text("보기")
                                                .font(.headline)


                                        }


                                    }
                                    .padding(.horizontal, 10)
                                }
                            }
                        }
                        .padding()

                    }
                    .padding(10)
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

#Preview {
    HomeView()

}
