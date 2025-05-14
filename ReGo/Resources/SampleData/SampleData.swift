//
//  SampleData.swift
//  ReGo
//
//  Created by JuHyeon Seong on 5/12/25.
//

import Foundation

extension Retrospect {
    static var sampleData: [Retrospect] {
        return [
            Retrospect(
                title: "Title1",
                content: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Maecenas blandit suscipit venenatis. Nam vel ante erat. Fusce neque nunc, pretium eu varius a, elementum in tortor. Proin id pretium augue, id scelerisque mauris. Nullam ac elit placerat, rhoncus orci ac, semper erat. Donec faucibus dui ac maximus dapibus. Donec nunc lacus, aliquam eu ipsum et, auctor auctor augue. Mauris venenatis id mi sed pretium. Nam quis sodales leo, in semper mauris.",
                date: Date.now,
                category: .daily,
                mood: .tired
            ),
            Retrospect(
                title: "Title2",
                content: "Ut mollis pulvinar ex sit amet tempor. In sapien risus, aliquet ut suscipit vitae, laoreet eu lectus. Duis nisl sem, suscipit malesuada ultricies ut, ultricies vel sapien. Duis laoreet fermentum lorem, at aliquam purus posuere ac. Sed gravida ipsum nec purus consectetur eleifend vel eget erat. Nulla et erat arcu. In in justo gravida, posuere urna ut, feugiat nisi. Quisque ultrices, purus in semper sodales, purus nisi pulvinar ex, sit amet ornare arcu est a nulla. Suspendisse massa elit, faucibus et justo vel, tristique varius augue. Phasellus pulvinar ut nibh vel placerat.",
                date: Calendar.current.date(byAdding: .day, value: -29, to: Date())!,
                category: .work,
                mood: .happy
            ),
            Retrospect(
                title: "Title3",
                content: "Aenean est orci, semper non ex at, porta sodales est. Etiam pulvinar sed lectus sit amet consectetur. Phasellus a venenatis orci. Curabitur ac tellus eget turpis accumsan gravida. Sed et nisi mauris. Maecenas mollis erat sed quam facilisis congue. Duis ornare ultrices neque ac viverra. Integer molestie quam eu metus imperdiet, eu tempor urna luctus.",
                date: Calendar.current.date(byAdding: .day, value: 29, to: Date())!,
                category: .study,
                mood: .sad
            ),
            Retrospect(
                title: "Title4",
                content: "Mauris aliquam elit vel dictum hendrerit. Mauris non mauris a velit sagittis venenatis. Donec mattis pharetra diam, dapibus tincidunt urna viverra in. Etiam luctus urna sit amet enim fringilla mattis. Nunc maximus, augue porta mattis lobortis, ipsum risus iaculis elit, sed malesuada est augue a sem. Donec rutrum lacinia elit vulputate pellentesque. Nullam iaculis justo felis, at egestas justo fringilla id. Phasellus in tellus et nisi vulputate elementum sed vel enim. Vivamus ut orci id dui condimentum lacinia. In iaculis neque ut faucibus eleifend.",
                date: Calendar.current.date(byAdding: .day, value: -30, to: Date())!,
                category: .relationship,
                mood: .anxious
            ),
            Retrospect(
                title: "Title5",
                content: "Vestibulum rhoncus lectus nec viverra vehicula. Aliquam tincidunt dui neque, et lacinia sem euismod at. Aenean nec leo metus. Quisque in lectus elit. Integer non varius sem. Nullam tincidunt consequat tortor, ac tincidunt elit faucibus quis. Proin mollis, risus vitae dictum bibendum, magna urna fringilla enim, mollis malesuada libero lorem et enim.",
                date: Calendar.current.date(byAdding: .day, value: -25, to: Date())!,
                category: .goal,
                mood: .angry
            ),
            Retrospect(
                title: "Title6",
                content: "Cras ut euismod felis. Nulla quis facilisis quam. Mauris eleifend enim nulla. Donec laoreet ipsum nisl, id placerat eros ultrices sit amet. Praesent non sagittis mi. Praesent efficitur est nibh, et sagittis magna facilisis at. Sed vitae suscipit dolor. Maecenas molestie tempor elit, eget posuere augue vulputate nec. Pellentesque consequat vehicula libero id faucibus. Duis tristique dapibus laoreet. Sed ultrices pulvinar suscipit. Nunc massa nisl, ultricies nec auctor ut, imperdiet eu massa.",
                date: Calendar.current.date(byAdding: .day, value: 25, to: Date())!,
                category: .daily,
                mood: .angry
            ),
            Retrospect(
                title: "Title7",
                content: "Praesent a mi facilisis, hendrerit ex nec, ultricies felis. Maecenas et risus in est porta suscipit. Integer blandit consequat sem eu ultrices. Cras venenatis pellentesque tincidunt. Donec auctor neque arcu, sed vehicula lacus eleifend a. Vivamus lacinia leo eu dolor iaculis, sit amet sagittis neque consectetur. Donec lobortis purus in eros ornare, non blandit nulla pulvinar. Cras hendrerit tellus ac neque vestibulum, nec fringilla enim efficitur.",
                date: Calendar.current.date(byAdding: .day, value: 20, to: Date())!,
                category: .work,
                mood: .neutral
            ),
            Retrospect(
                title:"Title8",
                content: "Sed porttitor nisl sit amet nisl vehicula, sit amet imperdiet metus tincidunt. In et dictum odio. Aenean et accumsan lorem. Sed accumsan ipsum id ante porta, sed placerat ex sodales. Vivamus vitae ligula at neque rhoncus sodales nec id nisi. Fusce ut varius ligula. Donec iaculis nulla in nisi semper fringilla. Nam pellentesque feugiat augue quis tempor. Morbi justo mauris, vestibulum efficitur justo vel, aliquam sollicitudin tellus. Ut vel ex ac elit fringilla feugiat sit amet in nunc. Vestibulum accumsan ornare tortor nec ultricies. Pellentesque nec ligula tortor. Vivamus vehicula ligula pretium augue posuere semper.",
                date: Date.now,
                category: .study,
                mood: .anxious
            ),
            Retrospect(
                title: "Title9",
                content: "Interdum et malesuada fames ac ante ipsum primis in faucibus. Vivamus commodo consequat eros, mattis commodo sapien facilisis sit amet. Nullam commodo efficitur mi, non aliquam magna rhoncus a. Phasellus tempus odio id neque lobortis volutpat. Suspendisse tempus neque orci, vel interdum arcu mattis quis. Interdum et malesuada fames ac ante ipsum primis in faucibus. Integer sit amet aliquam turpis. Donec velit urna, fringilla non bibendum in, imperdiet quis diam. Suspendisse potenti.",
                date: Date.now,
                category: .relationship,
                mood: .angry
            ),
            Retrospect(
                title: "Title10",
                content: "Phasellus non imperdiet neque. Integer id molestie velit. Donec vel tincidunt magna. Etiam tempus augue justo, vel semper ipsum hendrerit sit amet. Vestibulum nec odio dignissim, posuere nisi ac, sollicitudin nisl. Vivamus eu velit vitae purus ullamcorper molestie non convallis purus. Nullam aliquet semper est, ac pulvinar ante cursus fermentum. Curabitur elementum dapibus sollicitudin. Praesent sit amet purus finibus quam placerat auctor. Ut at lacinia leo, ac varius odio. Nunc pulvinar congue pulvinar. Praesent in rhoncus ex, at facilisis nunc. Praesent viverra neque nec luctus tincidunt. Aliquam gravida at velit vel porta. Pellentesque non placerat tellus. Mauris id nunc consequat quam dapibus rutrum id sit amet orci.",
                date: Calendar.current.date(byAdding: .day, value: 25, to: Date())!,
                category: .goal,
                mood: .sad
            ),
            Retrospect(
                title: "Title1",
                content: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Maecenas blandit suscipit venenatis. Nam vel ante erat. Fusce neque nunc, pretium eu varius a, elementum in tortor. Proin id pretium augue, id scelerisque mauris. Nullam ac elit placerat, rhoncus orci ac, semper erat. Donec faucibus dui ac maximus dapibus. Donec nunc lacus, aliquam eu ipsum et, auctor auctor augue. Mauris venenatis id mi sed pretium. Nam quis sodales leo, in semper mauris.",
                date: Date.now,
                category: .daily,
                mood: .tired
            ),
            Retrospect(
                title: "Title2",
                content: "Ut mollis pulvinar ex sit amet tempor. In sapien risus, aliquet ut suscipit vitae, laoreet eu lectus. Duis nisl sem, suscipit malesuada ultricies ut, ultricies vel sapien. Duis laoreet fermentum lorem, at aliquam purus posuere ac. Sed gravida ipsum nec purus consectetur eleifend vel eget erat. Nulla et erat arcu. In in justo gravida, posuere urna ut, feugiat nisi. Quisque ultrices, purus in semper sodales, purus nisi pulvinar ex, sit amet ornare arcu est a nulla. Suspendisse massa elit, faucibus et justo vel, tristique varius augue. Phasellus pulvinar ut nibh vel placerat.",
                date: Calendar.current.date(byAdding: .day, value: -28, to: Date())!,
                category: .work,
                mood: .happy
            ),
            Retrospect(
                title: "Title3",
                content: "Aenean est orci, semper non ex at, porta sodales est. Etiam pulvinar sed lectus sit amet consectetur. Phasellus a venenatis orci. Curabitur ac tellus eget turpis accumsan gravida. Sed et nisi mauris. Maecenas mollis erat sed quam facilisis congue. Duis ornare ultrices neque ac viverra. Integer molestie quam eu metus imperdiet, eu tempor urna luctus.",
                date: Calendar.current.date(byAdding: .day, value: 32, to: Date())!,
                category: .study,
                mood: .sad
            ),
            Retrospect(
                title: "Title4",
                content: "Mauris aliquam elit vel dictum hendrerit. Mauris non mauris a velit sagittis venenatis. Donec mattis pharetra diam, dapibus tincidunt urna viverra in. Etiam luctus urna sit amet enim fringilla mattis. Nunc maximus, augue porta mattis lobortis, ipsum risus iaculis elit, sed malesuada est augue a sem. Donec rutrum lacinia elit vulputate pellentesque. Nullam iaculis justo felis, at egestas justo fringilla id. Phasellus in tellus et nisi vulputate elementum sed vel enim. Vivamus ut orci id dui condimentum lacinia. In iaculis neque ut faucibus eleifend.",
                date: Calendar.current.date(byAdding: .day, value: -31, to: Date())!,
                category: .relationship,
                mood: .anxious
            ),
            Retrospect(
                title: "Title5",
                content: "Vestibulum rhoncus lectus nec viverra vehicula. Aliquam tincidunt dui neque, et lacinia sem euismod at. Aenean nec leo metus. Quisque in lectus elit. Integer non varius sem. Nullam tincidunt consequat tortor, ac tincidunt elit faucibus quis. Proin mollis, risus vitae dictum bibendum, magna urna fringilla enim, mollis malesuada libero lorem et enim.",
                date: Calendar.current.date(byAdding: .day, value: -34, to: Date())!,
                category: .goal,
                mood: .angry
            ),
            Retrospect(
                title: "Title6",
                content: "Cras ut euismod felis. Nulla quis facilisis quam. Mauris eleifend enim nulla. Donec laoreet ipsum nisl, id placerat eros ultrices sit amet. Praesent non sagittis mi. Praesent efficitur est nibh, et sagittis magna facilisis at. Sed vitae suscipit dolor. Maecenas molestie tempor elit, eget posuere augue vulputate nec. Pellentesque consequat vehicula libero id faucibus. Duis tristique dapibus laoreet. Sed ultrices pulvinar suscipit. Nunc massa nisl, ultricies nec auctor ut, imperdiet eu massa.",
                date: Calendar.current.date(byAdding: .day, value: 36, to: Date())!,
                category: .daily,
                mood: .angry
            ),
            Retrospect(
                title: "Title7",
                content: "Praesent a mi facilisis, hendrerit ex nec, ultricies felis. Maecenas et risus in est porta suscipit. Integer blandit consequat sem eu ultrices. Cras venenatis pellentesque tincidunt. Donec auctor neque arcu, sed vehicula lacus eleifend a. Vivamus lacinia leo eu dolor iaculis, sit amet sagittis neque consectetur. Donec lobortis purus in eros ornare, non blandit nulla pulvinar. Cras hendrerit tellus ac neque vestibulum, nec fringilla enim efficitur.",
                date: Calendar.current.date(byAdding: .day, value: 29, to: Date())!,
                category: .work,
                mood: .neutral
            ),
            Retrospect(
                title:"Title8",
                content: "Sed porttitor nisl sit amet nisl vehicula, sit amet imperdiet metus tincidunt. In et dictum odio. Aenean et accumsan lorem. Sed accumsan ipsum id ante porta, sed placerat ex sodales. Vivamus vitae ligula at neque rhoncus sodales nec id nisi. Fusce ut varius ligula. Donec iaculis nulla in nisi semper fringilla. Nam pellentesque feugiat augue quis tempor. Morbi justo mauris, vestibulum efficitur justo vel, aliquam sollicitudin tellus. Ut vel ex ac elit fringilla feugiat sit amet in nunc. Vestibulum accumsan ornare tortor nec ultricies. Pellentesque nec ligula tortor. Vivamus vehicula ligula pretium augue posuere semper.",
                date: Date.now,
                category: .study,
                mood: .anxious
            ),
            Retrospect(
                title: "Title9",
                content: "Interdum et malesuada fames ac ante ipsum primis in faucibus. Vivamus commodo consequat eros, mattis commodo sapien facilisis sit amet. Nullam commodo efficitur mi, non aliquam magna rhoncus a. Phasellus tempus odio id neque lobortis volutpat. Suspendisse tempus neque orci, vel interdum arcu mattis quis. Interdum et malesuada fames ac ante ipsum primis in faucibus. Integer sit amet aliquam turpis. Donec velit urna, fringilla non bibendum in, imperdiet quis diam. Suspendisse potenti.",
                date: Date.now,
                category: .relationship,
                mood: .angry
            ),
            Retrospect(
                title: "Title10",
                content: "Phasellus non imperdiet neque. Integer id molestie velit. Donec vel tincidunt magna. Etiam tempus augue justo, vel semper ipsum hendrerit sit amet. Vestibulum nec odio dignissim, posuere nisi ac, sollicitudin nisl. Vivamus eu velit vitae purus ullamcorper molestie non convallis purus. Nullam aliquet semper est, ac pulvinar ante cursus fermentum. Curabitur elementum dapibus sollicitudin. Praesent sit amet purus finibus quam placerat auctor. Ut at lacinia leo, ac varius odio. Nunc pulvinar congue pulvinar. Praesent in rhoncus ex, at facilisis nunc. Praesent viverra neque nec luctus tincidunt. Aliquam gravida at velit vel porta. Pellentesque non placerat tellus. Mauris id nunc consequat quam dapibus rutrum id sit amet orci.",
                date: Calendar.current.date(byAdding: .day, value: 30, to: Date())!,
                category: .goal,
                mood: .sad
            )
        ]
    }
}

extension Retrospect {
    static var sampleDataForStatistics: [Retrospect] {
        return [
            Retrospect(
                title: "Title1",
                content: "Title1",
                date: Date.now.addingTimeInterval(-86400 * Double.random(in: 0...30)),
                category: .study,
                mood: .angry
            ),
            Retrospect(
                title: "Title2",
                content: "Title2",
                date: Date.now.addingTimeInterval(-86400 * Double.random(in: 0...30)),
                category: .goal,
                mood: .anxious
            ),
            Retrospect(
                title: "Title3",
                content: "Title3",
                date: Date.now.addingTimeInterval(-86400 * Double.random(in: 0...30)),
                category: .study,
                mood: .excited
            ),
            Retrospect(
                title: "Title4",
                content: "Title4",
                date: Date.now.addingTimeInterval(-86400 * Double.random(in: 0...30)),
                category: .goal,
                mood: .happy
            ),
            Retrospect(
                title: "Title5",
                content: "Title5",
                date: Date.now.addingTimeInterval(-86400 * Double.random(in: 0...30)),
                category: .daily,
                mood: .neutral
            ),
            Retrospect(
                title: "Title6",
                content: "Title6",
                date: Date.now.addingTimeInterval(-86400 * Double.random(in: 0...30)),
                category: .work,
                mood: .sad
            ),
            Retrospect(
                title: "Title7",
                content: "Title7",
                date: Date.now.addingTimeInterval(-86400 * Double.random(in: 0...30)),
                category: .study,
                mood: .tired
            ),
            Retrospect(
                title: "Title8",
                content: "Title8",
                date: Date.now.addingTimeInterval(-86400 * Double.random(in: 0...30)),
                category: .study,
                mood: .neutral
            ),
            Retrospect(
                title: "Title9",
                content: "Title9",
                date: Date.now.addingTimeInterval(-86400 * Double.random(in: 0...30)),
                category: .goal,
                mood: .neutral
            ),
            Retrospect(
                title: "Title10",
                content: "Title10",
                date: Date.now.addingTimeInterval(-86400 * Double.random(in: 0...30)),
                category: .study,
                mood: .neutral
            ),
            Retrospect(
                title: "Title11",
                content: "Title11",
                date: Date.now.addingTimeInterval(-86400 * Double.random(in: 0...30)),
                category: .work,
                mood: .neutral
            ),
            Retrospect(
                title: "Title12",
                content: "Title12",
                date: Date.now.addingTimeInterval(-86400 * Double.random(in: 0...30)),
                category: .relationship,
                mood: .neutral
            ),
            Retrospect(
                title: "Title13",
                content: "Title13",
                date: Date.now.addingTimeInterval(-86400 * Double.random(in: 0...30)),
                category: .relationship,
                mood: .neutral
            ),
            Retrospect(
                title: "Title14",
                content: "Title14",
                date: Date.now.addingTimeInterval(-86400 * Double.random(in: 0...30)),
                category: .daily,
                mood: .neutral
            ),
            Retrospect(
                title: "Title15",
                content: "Title15",
                date: Date.now.addingTimeInterval(-86400 * Double.random(in: 0...30)),
                category: .work,
                mood: .neutral
            ),
            Retrospect(
                title: "Title16",
                content: "Title16",
                date: Date.now.addingTimeInterval(-86400 * Double.random(in: 0...30)),
                category: .work,
                mood: .neutral
            ),
            Retrospect(
                title: "Title17",
                content: "Title17",
                date: Date.now.addingTimeInterval(-86400 * Double.random(in: 0...30)),
                category: .relationship,
                mood: .neutral
            ),
            Retrospect(
                title: "Title18",
                content: "Title18",
                date: Date.now.addingTimeInterval(-86400 * Double.random(in: 0...30)),
                category: .relationship,
                mood: .neutral
            ),
            Retrospect(
                title: "Title19",
                content: "Title19",
                date: Date.now.addingTimeInterval(-86400 * Double.random(in: 0...30)),
                category: .relationship,
                mood: .neutral
            ),
            Retrospect(
                title: "Title20",
                content: "Title20",
                date: Date.now.addingTimeInterval(-86400 * Double.random(in: 0...30)),
                category: .relationship,
                mood: .neutral
            ),
            Retrospect(
                title: "Title21",
                content: "Title21",
                date: Date.now.addingTimeInterval(-86400 * Double.random(in: 0...30)),
                category: .daily,
                mood: .neutral
            ),
            Retrospect(
                title: "Title22",
                content: "Title22",
                date: Date.now.addingTimeInterval(-86400 * Double.random(in: 0...30)),
                category: .study,
                mood: .neutral
            ),
            Retrospect(
                title: "Title23",
                content: "Title23",
                date: Date.now.addingTimeInterval(-86400 * Double.random(in: 0...30)),
                category: .study,
                mood: .neutral
            ),
            Retrospect(
                title: "Title24",
                content: "Title24",
                date: Date.now.addingTimeInterval(-86400 * Double.random(in: 0...30)),
                category: .study,
                mood: .neutral
            ),
            Retrospect(
                title: "Title25",
                content: "Title25",
                date: Date.now.addingTimeInterval(-86400 * Double.random(in: 0...30)),
                category: .relationship,
                mood: .neutral
            ),
            Retrospect(
                title: "Title26",
                content: "Title26",
                date: Date.now.addingTimeInterval(-86400 * Double.random(in: 0...30)),
                category: .work,
                mood: .neutral
            ),
            Retrospect(
                title: "Title27",
                content: "Title27",
                date: Date.now.addingTimeInterval(-86400 * Double.random(in: 0...30)),
                category: .goal,
                mood: .neutral
            ),
            Retrospect(
                title: "Title28",
                content: "Title28",
                date: Date.now.addingTimeInterval(-86400 * Double.random(in: 0...30)),
                category: .daily,
                mood: .neutral
            ),
            Retrospect(
                title: "Title29",
                content: "Title29",
                date: Date.now.addingTimeInterval(-86400 * Double.random(in: 0...30)),
                category: .daily,
                mood: .neutral
            ),
            Retrospect(
                title: "Title30",
                content: "Title30",
                date: Date.now.addingTimeInterval(-86400 * Double.random(in: 0...30)),
                category: .relationship,
                mood: .neutral
            ),
            Retrospect(
                title: "Title31",
                content: "Title31",
                date: Date.now.addingTimeInterval(-86400 * Double.random(in: 0...30)),
                category: .goal,
                mood: .neutral
            ),
            Retrospect(
                title: "Title32",
                content: "Title32",
                date: Date.now.addingTimeInterval(-86400 * Double.random(in: 0...30)),
                category: .relationship,
                mood: .neutral
            ),
            Retrospect(
                title: "Title33",
                content: "Title33",
                date: Date.now.addingTimeInterval(-86400 * Double.random(in: 0...30)),
                category: .relationship,
                mood: .neutral
            ),
            Retrospect(
                title: "Title34",
                content: "Title34",
                date: Date.now.addingTimeInterval(-86400 * Double.random(in: 0...30)),
                category: .goal,
                mood: .neutral
            ),
            Retrospect(
                title: "Title35",
                content: "Title35",
                date: Date.now.addingTimeInterval(-86400 * Double.random(in: 0...30)),
                category: .work,
                mood: .neutral
            ),
            Retrospect(
                title: "Title36",
                content: "Title36",
                date: Date.now.addingTimeInterval(-86400 * Double.random(in: 0...30)),
                category: .study,
                mood: .neutral
            ),
            Retrospect(
                title: "Title37",
                content: "Title37",
                date: Date.now.addingTimeInterval(-86400 * Double.random(in: 0...30)),
                category: .daily,
                mood: .neutral
            ),
            Retrospect(
                title: "Title38",
                content: "Title38",
                date: Date.now.addingTimeInterval(-86400 * Double.random(in: 0...30)),
                category: .work,
                mood: .neutral
            ),
            Retrospect(
                title: "Title39",
                content: "Title39",
                date: Date.now.addingTimeInterval(-86400 * Double.random(in: 0...30)),
                category: .study,
                mood: .neutral
            ),
            Retrospect(
                title: "Title40",
                content: "Title40",
                date: Date.now.addingTimeInterval(-86400 * Double.random(in: 0...30)),
                category: .daily,
                mood: .neutral
            ),
            Retrospect(
                title: "Title41",
                content: "Title41",
                date: Date.now.addingTimeInterval(-86400 * Double.random(in: 0...30)),
                category: .work,
                mood: .neutral
            ),
            Retrospect(
                title: "Title42",
                content: "Title42",
                date: Date.now.addingTimeInterval(-86400 * Double.random(in: 0...30)),
                category: .study,
                mood: .neutral
            ),
            Retrospect(
                title: "Title43",
                content: "Title43",
                date: Date.now.addingTimeInterval(-86400 * Double.random(in: 0...30)),
                category: .work,
                mood: .neutral
            ),
            Retrospect(
                title: "Title44",
                content: "Title44",
                date: Date.now.addingTimeInterval(-86400 * Double.random(in: 0...30)),
                category: .goal,
                mood: .neutral
            ),
            Retrospect(
                title: "Title45",
                content: "Title45",
                date: Date.now.addingTimeInterval(-86400 * Double.random(in: 0...30)),
                category: .study,
                mood: .neutral
            ),
            Retrospect(
                title: "Title46",
                content: "Title46",
                date: Date.now.addingTimeInterval(-86400 * Double.random(in: 0...30)),
                category: .goal,
                mood: .neutral
            ),
            Retrospect(
                title: "Title47",
                content: "Title47",
                date: Date.now.addingTimeInterval(-86400 * Double.random(in: 0...30)),
                category: .relationship,
                mood: .neutral
            ),
            Retrospect(
                title: "Title48",
                content: "Title48",
                date: Date.now.addingTimeInterval(-86400 * Double.random(in: 0...30)),
                category: .study,
                mood: .neutral
            ),
            Retrospect(
                title: "Title49",
                content: "Title49",
                date: Date.now.addingTimeInterval(-86400 * Double.random(in: 0...30)),
                category: .work,
                mood: .neutral
            ),
            Retrospect(
                title: "Title50",
                content: "Title50",
                date: Date.now.addingTimeInterval(-86400 * Double.random(in: 0...30)),
                category: .goal,
                mood: .neutral
            ),

        ]
    }
}

func randomPastDate(withinDays days: Int) -> Date {
    let randomInterval = TimeInterval(Int.random(in: 0...(days * 86400)))
    return Date().addingTimeInterval(-randomInterval)
}

extension Retrospect {
    
    static var detailSampleData: [Retrospect] {
        return [
            Retrospect(title: "느긋한 아침", content: "오늘은 알람 없이 자연스럽게 눈을 떴다. 커튼 사이로 들어오는 햇살이 따뜻하게 느껴졌고, 부엌에서 커피를 내리며 조용한 음악을 틀었다. 천천히 브런치를 먹으며 평소 놓치기 쉬운 작은 순간들을 음미했다. 이렇게 하루를 시작하니 마음이 한결 가벼웠고, 여유로운 기분으로 일정을 시작할 수 있었다.", date: randomPastDate(withinDays: 30), category: .daily, mood: .happy),

            Retrospect(title: "회의 피로", content: "오늘 하루는 회의로 가득 차 있었다. 오전 회의에서는 팀 간 의견 차이로 논쟁이 있었고, 오후 회의는 기술적인 이슈로 시간이 지체되었다. 점심도 제대로 먹지 못한 채 계속된 일정에 정신적으로 지치고 체력도 바닥이 났다. 회의가 끝나고 나니 하루가 다 지나 있었고, 제대로 집중한 시간보다 회의에 소진된 에너지가 더 컸다.", date: randomPastDate(withinDays: 30), category: .study, mood: .tired),

            Retrospect(title: "산책의 즐거움", content: "퇴근 후 답답한 마음을 달래기 위해 공원에 나갔다. 평소보다 한산한 공원은 잔잔한 분위기를 자아냈고, 풀냄새와 꽃향기가 은은하게 퍼졌다. 천천히 걷다 보니 머릿속이 맑아졌고, 복잡했던 생각들이 정리되는 느낌이었다. 아무 목적 없이 걷는 시간이 이렇게 소중하다는 걸 다시금 느꼈다.", date: randomPastDate(withinDays: 30), category: .relationship, mood: .neutral),

            Retrospect(title: "실수와 반성", content: "업무 중 중요한 데이터를 잘못 입력하는 실수를 했다. 사소한 실수라고 생각했지만, 결과적으로 팀의 일정에 영향을 줄 수 있는 일이었다. 상사에게 보고하고 정정하긴 했지만 하루 종일 마음이 불편했다. 실수를 통해 다시 한번 확인의 중요성을 느꼈고, 내 책임감에 대해 돌아보게 되었다.", date: randomPastDate(withinDays: 30), category: .goal, mood: .anxious),

            Retrospect(title: "친구와의 수다", content: "오랜만에 고등학교 친구를 만나 즐거운 시간을 보냈다. 서로의 근황을 이야기하고 예전 추억을 떠올리며 시간 가는 줄 몰랐다. 요즘 회사 일로 지쳐 있었는데, 친구와의 대화가 큰 위로가 되었다. 웃고 떠드는 동안 잠시나마 현실에서 벗어날 수 있었다.", date: randomPastDate(withinDays: 30), category: .lesson, mood: .happy),

            Retrospect(title: "야근의 고단함", content: "오늘은 예상치 못한 버그로 인해 야근을 하게 되었다. 모두 퇴근한 사무실에서 혼자 코드를 수정하고 테스트하는 시간이 길게 느껴졌다. 배도 고프고 집중도 떨어졌지만, 결국 문제를 해결하고 나니 뿌듯함이 밀려왔다. 다음엔 더 효율적으로 일해야겠다는 생각이 들었다.", date: randomPastDate(withinDays: 30), category: .work, mood: .tired),

            Retrospect(title: "영화 감상", content: "기다리던 영화가 개봉해 바로 예매하고 관람했다. 극장에서 보는 영화는 언제나 특별하다. 이번 영화는 배우들의 연기도 훌륭했고, 스토리도 몰입감이 높았다. 특히 결말에서 예상치 못한 반전이 인상 깊었고, 상영이 끝난 후에도 여운이 오래 남았다.", date: randomPastDate(withinDays: 30), category: .study, mood: .excited),

            Retrospect(title: "운동의 성취", content: "오늘은 운동을 시작한 지 3주째 되는 날이었다. 매일 꾸준히 하려 노력했고, 어느새 운동이 습관처럼 자리 잡기 시작했다. 아직 체력이 부족하다고 느껴질 때도 있지만, 땀을 흘릴수록 마음도 정리되는 기분이다. 앞으로도 꾸준히 몸과 마음을 돌보려 한다.", date: randomPastDate(withinDays: 30), category: .daily, mood: .happy),

            Retrospect(title: "무기력한 하루", content: "오늘은 하루 종일 무기력하고 의욕이 없었다. 해야 할 일들은 많았지만 손에 잡히지 않았고, 소파에 누워 넷플릭스만 보며 시간을 보냈다. 이렇게 아무것도 하지 않는 날이 필요하다고 위로했지만, 왠지 모르게 자책감이 밀려왔다.", date: randomPastDate(withinDays: 30), category: .goal, mood: .sad),

            Retrospect(title: "맛있는 점심", content: "점심시간에 팀원들과 함께 새로 생긴 맛집에 갔다. 분위기도 아늑하고 음식도 정갈해서 대화도 자연스럽게 이어졌다. 오랜만에 유쾌한 식사 시간이었고, 다시 업무로 돌아와서도 기분 좋게 집중할 수 있었다.", date: randomPastDate(withinDays: 30), category: .relationship, mood: .happy),
            ]
    }
}
