//
//  HomeView.swift
//  ReGo
//
//  Created by  서재효 on 5/12/25.
//

import SwiftUI


struct HomeView: View {
    @State private var mintHeight: CGFloat = 50
    @State private var orangeHeight: CGFloat = 40
    @State private var blueHeight: CGFloat = 50
    @State private var pupleHeight: CGFloat = 40
    @State private var redHeight: CGFloat = 50

    @Environment(\.colorScheme) var colorScreme

    var readStrokeColor: Color {
        colorScreme == .dark ? .white.opacity(0.8) : .black

    }

    var infiniteAnimation: Animation {
        Animation.linear(duration: 3).repeatForever(autoreverses: true)
    }


    var body: some View {
        NavigationStack {
            VStack {
                VStack {
                    HStack {
                        Image(systemName: "scribble.variable")
                            .font(.largeTitle)
                            .foregroundStyle(.blue)
                            .bold()

                        VStack(alignment: .leading,spacing: 4) {
                            Text("??")
                                .italic()
                                .font(.largeTitle)
                                .bold()
                                .foregroundStyle(.blue)

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
                            .foregroundColor(.mint.opacity(0.7))
                            .frame(width: 40, height: mintHeight)
                            .cornerRadius(6)
                            .shadow(color: .mint.opacity(0.6), radius: 4, x: 0, y: 5)
                            .onAppear {
                                withAnimation(infiniteAnimation) {
                                    mintHeight = 130
                                }
                            }

                        Rectangle()
                            .foregroundColor(.orange.opacity(0.7))
                            .frame(width: 40, height: orangeHeight)
                            .cornerRadius(6)
                            .shadow(color: .orange.opacity(0.6), radius: 4, x: 0, y: 5)
                            .onAppear {
                                withAnimation(infiniteAnimation) {
                                    orangeHeight = 120
                                }
                            }

                        Rectangle()
                            .foregroundColor(.blue.opacity(0.7))
                            .frame(width: 40, height: blueHeight)
                            .cornerRadius(6)
                            .shadow(color: .blue.opacity(0.6), radius: 4, x: 0, y: 5)
                            .onAppear {
                                withAnimation(infiniteAnimation) {
                                    blueHeight = 140
                                }
                            }

                        Rectangle()
                            .foregroundColor(.purple.opacity(0.7))
                            .frame(width: 40, height: pupleHeight)
                            .cornerRadius(6)
                            .shadow(color: .purple.opacity(0.6), radius: 4, x: 0, y: 5)
                            .onAppear {
                                withAnimation(infiniteAnimation) {
                                    pupleHeight = 110
                                }
                            }

                        Rectangle()
                            .foregroundColor(.red.opacity(0.7))
                            .frame(width: 40, height: redHeight)
                            .cornerRadius(6)
                            .shadow(color: .red.opacity(0.6), radius: 4, x: 0, y: 5)
                            .onAppear {
                                withAnimation(infiniteAnimation) {
                                    redHeight = 150
                                }
                            }
                    }

                    .frame(height: 100, alignment: .bottom)
                    .padding()

                    NavigationLink(destination: ListItem(item: Retrospect.sampleData[0])) {
                        Text("자세히보기")
                            .frame(maxWidth: .infinity, alignment: .trailing)
                            .padding(.top)
                            .padding(.trailing, 10)
                    }

                    ScrollView(.horizontal) {

                        HStack {
                            ZStack{
                                RoundedRectangle(cornerRadius: 30)
                                    .fill(.gray.opacity(0.7))
                                    .frame(width: 150, height: 150)



                                    Text("이번달 \n회고 작성 횟수 :\n ")
                                        .font(.headline)
                                        .foregroundColor(readStrokeColor)

                            }

                            .padding(.horizontal, 10)
                            .padding(10)

                            ZStack{
                                RoundedRectangle(cornerRadius: 30)
                                    .fill(.gray.opacity(0.7))
                                    .frame(width: 150, height: 150)



                                    Text("이번달 \n회고 작성 횟수 :\n ")
                                        .font(.headline)
                                        .foregroundColor(readStrokeColor)

                            }
                            .padding(.horizontal, 10)
                            .padding(10)

                            ZStack{
                                RoundedRectangle(cornerRadius: 30)
                                    .fill(.gray.opacity(0.7))
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



            //TODO: 작성뷰로 수정하기
            NavigationLink(destination: ListItem(item: Retrospect.sampleData[0])) {
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
                .background(.ultraThinMaterial)
                .cornerRadius(12)
                .frame(maxWidth: .infinity)
                .padding(.bottom, 10)

                }
                .padding(.bottom, 40)


            }
        }
    }
}

#Preview {
    HomeView()

}
