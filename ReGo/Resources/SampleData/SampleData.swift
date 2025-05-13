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
                category: .category1,
                mood: .tired
            ),
            Retrospect(
                title: "Title2",
                content: "Ut mollis pulvinar ex sit amet tempor. In sapien risus, aliquet ut suscipit vitae, laoreet eu lectus. Duis nisl sem, suscipit malesuada ultricies ut, ultricies vel sapien. Duis laoreet fermentum lorem, at aliquam purus posuere ac. Sed gravida ipsum nec purus consectetur eleifend vel eget erat. Nulla et erat arcu. In in justo gravida, posuere urna ut, feugiat nisi. Quisque ultrices, purus in semper sodales, purus nisi pulvinar ex, sit amet ornare arcu est a nulla. Suspendisse massa elit, faucibus et justo vel, tristique varius augue. Phasellus pulvinar ut nibh vel placerat.",
                date: Date.distantPast,
                category: .category2,
                mood: .happy
            ),
            Retrospect(
                title: "Title3",
                content: "Aenean est orci, semper non ex at, porta sodales est. Etiam pulvinar sed lectus sit amet consectetur. Phasellus a venenatis orci. Curabitur ac tellus eget turpis accumsan gravida. Sed et nisi mauris. Maecenas mollis erat sed quam facilisis congue. Duis ornare ultrices neque ac viverra. Integer molestie quam eu metus imperdiet, eu tempor urna luctus.",
                date: Date.distantFuture,
                category: .category3,
                mood: .sad
            ),
            Retrospect(
                title: "Title4",
                content: "Mauris aliquam elit vel dictum hendrerit. Mauris non mauris a velit sagittis venenatis. Donec mattis pharetra diam, dapibus tincidunt urna viverra in. Etiam luctus urna sit amet enim fringilla mattis. Nunc maximus, augue porta mattis lobortis, ipsum risus iaculis elit, sed malesuada est augue a sem. Donec rutrum lacinia elit vulputate pellentesque. Nullam iaculis justo felis, at egestas justo fringilla id. Phasellus in tellus et nisi vulputate elementum sed vel enim. Vivamus ut orci id dui condimentum lacinia. In iaculis neque ut faucibus eleifend.",
                date: Date.distantPast,
                category: .category4,
                mood: .anxious
            ),
            Retrospect(
                title: "Title5",
                content: "Vestibulum rhoncus lectus nec viverra vehicula. Aliquam tincidunt dui neque, et lacinia sem euismod at. Aenean nec leo metus. Quisque in lectus elit. Integer non varius sem. Nullam tincidunt consequat tortor, ac tincidunt elit faucibus quis. Proin mollis, risus vitae dictum bibendum, magna urna fringilla enim, mollis malesuada libero lorem et enim.",
                date: Date.distantPast,
                category: .category5,
                mood: .angry
            ),
            Retrospect(
                title: "Title6",
                content: "Cras ut euismod felis. Nulla quis facilisis quam. Mauris eleifend enim nulla. Donec laoreet ipsum nisl, id placerat eros ultrices sit amet. Praesent non sagittis mi. Praesent efficitur est nibh, et sagittis magna facilisis at. Sed vitae suscipit dolor. Maecenas molestie tempor elit, eget posuere augue vulputate nec. Pellentesque consequat vehicula libero id faucibus. Duis tristique dapibus laoreet. Sed ultrices pulvinar suscipit. Nunc massa nisl, ultricies nec auctor ut, imperdiet eu massa.",
                date: Date.distantFuture,
                category: .category1,
                mood: .angry
            ),
            Retrospect(
                title: "Title7",
                content: "Praesent a mi facilisis, hendrerit ex nec, ultricies felis. Maecenas et risus in est porta suscipit. Integer blandit consequat sem eu ultrices. Cras venenatis pellentesque tincidunt. Donec auctor neque arcu, sed vehicula lacus eleifend a. Vivamus lacinia leo eu dolor iaculis, sit amet sagittis neque consectetur. Donec lobortis purus in eros ornare, non blandit nulla pulvinar. Cras hendrerit tellus ac neque vestibulum, nec fringilla enim efficitur.",
                date: Date.distantFuture,
                category: .category2,
                mood: .neutral
            ),
            Retrospect(
                title:"Title8",
                content: "Sed porttitor nisl sit amet nisl vehicula, sit amet imperdiet metus tincidunt. In et dictum odio. Aenean et accumsan lorem. Sed accumsan ipsum id ante porta, sed placerat ex sodales. Vivamus vitae ligula at neque rhoncus sodales nec id nisi. Fusce ut varius ligula. Donec iaculis nulla in nisi semper fringilla. Nam pellentesque feugiat augue quis tempor. Morbi justo mauris, vestibulum efficitur justo vel, aliquam sollicitudin tellus. Ut vel ex ac elit fringilla feugiat sit amet in nunc. Vestibulum accumsan ornare tortor nec ultricies. Pellentesque nec ligula tortor. Vivamus vehicula ligula pretium augue posuere semper.",
                date: Date.now,
                category: .category3,
                mood: .anxious
            ),
            Retrospect(
                title: "Title9",
                content: "Interdum et malesuada fames ac ante ipsum primis in faucibus. Vivamus commodo consequat eros, mattis commodo sapien facilisis sit amet. Nullam commodo efficitur mi, non aliquam magna rhoncus a. Phasellus tempus odio id neque lobortis volutpat. Suspendisse tempus neque orci, vel interdum arcu mattis quis. Interdum et malesuada fames ac ante ipsum primis in faucibus. Integer sit amet aliquam turpis. Donec velit urna, fringilla non bibendum in, imperdiet quis diam. Suspendisse potenti.",
                date: Date.now,
                category: .category4,
                mood: .angry
            ),
            Retrospect(
                title: "Title10",
                content: "Phasellus non imperdiet neque. Integer id molestie velit. Donec vel tincidunt magna. Etiam tempus augue justo, vel semper ipsum hendrerit sit amet. Vestibulum nec odio dignissim, posuere nisi ac, sollicitudin nisl. Vivamus eu velit vitae purus ullamcorper molestie non convallis purus. Nullam aliquet semper est, ac pulvinar ante cursus fermentum. Curabitur elementum dapibus sollicitudin. Praesent sit amet purus finibus quam placerat auctor. Ut at lacinia leo, ac varius odio. Nunc pulvinar congue pulvinar. Praesent in rhoncus ex, at facilisis nunc. Praesent viverra neque nec luctus tincidunt. Aliquam gravida at velit vel porta. Pellentesque non placerat tellus. Mauris id nunc consequat quam dapibus rutrum id sit amet orci.",
                date: Date.distantFuture,
                category: .category5,
                mood: .sad
            ),

        ]
    }
}

extension Retrospect {
    static var sampleDataForStatistics: [Retrospect] {
        return [
            Retrospect(
                title: "Title1",
                content: "Title1",
                date: Date.now.addingTimeInterval(-86400 * Double.random(in: 0...12)),
                category: .category3,
                mood: .angry
            ),
            Retrospect(
                title: "Title2",
                content: "Title2",
                date: Date.now.addingTimeInterval(-86400 * Double.random(in: 0...12)),
                category: .category5,
                mood: .anxious
            ),
            Retrospect(
                title: "Title3",
                content: "Title3",
                date: Date.now.addingTimeInterval(-86400 * Double.random(in: 0...12)),
                category: .category3,
                mood: .excited
            ),
            Retrospect(
                title: "Title4",
                content: "Title4",
                date: Date.now.addingTimeInterval(-86400 * Double.random(in: 0...12)),
                category: .category5,
                mood: .happy
            ),
            Retrospect(
                title: "Title5",
                content: "Title5",
                date: Date.now.addingTimeInterval(-86400 * Double.random(in: 0...12)),
                category: .category1,
                mood: .neutral
            ),
            Retrospect(
                title: "Title6",
                content: "Title6",
                date: Date.now.addingTimeInterval(-86400 * Double.random(in: 0...12)),
                category: .category2,
                mood: .sad
            ),
            Retrospect(
                title: "Title7",
                content: "Title7",
                date: Date.now.addingTimeInterval(-86400 * Double.random(in: 0...12)),
                category: .category3,
                mood: .tired
            ),
            Retrospect(
                title: "Title8",
                content: "Title8",
                date: Date.now.addingTimeInterval(-86400 * Double.random(in: 0...12)),
                category: .category3,
                mood: .neutral
            ),
            Retrospect(
                title: "Title9",
                content: "Title9",
                date: Date.now.addingTimeInterval(-86400 * Double.random(in: 0...12)),
                category: .category5,
                mood: .neutral
            ),
            Retrospect(
                title: "Title10",
                content: "Title10",
                date: Date.now.addingTimeInterval(-86400 * Double.random(in: 0...12)),
                category: .category3,
                mood: .neutral
            ),
            Retrospect(
                title: "Title11",
                content: "Title11",
                date: Date.now.addingTimeInterval(-86400 * Double.random(in: 0...12)),
                category: .category2,
                mood: .neutral
            ),
            Retrospect(
                title: "Title12",
                content: "Title12",
                date: Date.now.addingTimeInterval(-86400 * Double.random(in: 0...12)),
                category: .category4,
                mood: .neutral
            ),
            Retrospect(
                title: "Title13",
                content: "Title13",
                date: Date.now.addingTimeInterval(-86400 * Double.random(in: 0...12)),
                category: .category4,
                mood: .neutral
            ),
            Retrospect(
                title: "Title14",
                content: "Title14",
                date: Date.now.addingTimeInterval(-86400 * Double.random(in: 0...12)),
                category: .category1,
                mood: .neutral
            ),
            Retrospect(
                title: "Title15",
                content: "Title15",
                date: Date.now.addingTimeInterval(-86400 * Double.random(in: 0...12)),
                category: .category2,
                mood: .neutral
            ),
            Retrospect(
                title: "Title16",
                content: "Title16",
                date: Date.now.addingTimeInterval(-86400 * Double.random(in: 0...12)),
                category: .category2,
                mood: .neutral
            ),
            Retrospect(
                title: "Title17",
                content: "Title17",
                date: Date.now.addingTimeInterval(-86400 * Double.random(in: 0...12)),
                category: .category4,
                mood: .neutral
            ),
            Retrospect(
                title: "Title18",
                content: "Title18",
                date: Date.now.addingTimeInterval(-86400 * Double.random(in: 0...12)),
                category: .category4,
                mood: .neutral
            ),
            Retrospect(
                title: "Title19",
                content: "Title19",
                date: Date.now.addingTimeInterval(-86400 * Double.random(in: 0...12)),
                category: .category4,
                mood: .neutral
            ),
            Retrospect(
                title: "Title20",
                content: "Title20",
                date: Date.now.addingTimeInterval(-86400 * Double.random(in: 0...12)),
                category: .category4,
                mood: .neutral
            ),
            Retrospect(
                title: "Title21",
                content: "Title21",
                date: Date.now.addingTimeInterval(-86400 * Double.random(in: 0...12)),
                category: .category1,
                mood: .neutral
            ),
            Retrospect(
                title: "Title22",
                content: "Title22",
                date: Date.now.addingTimeInterval(-86400 * Double.random(in: 0...12)),
                category: .category3,
                mood: .neutral
            ),
            Retrospect(
                title: "Title23",
                content: "Title23",
                date: Date.now.addingTimeInterval(-86400 * Double.random(in: 0...12)),
                category: .category3,
                mood: .neutral
            ),
            Retrospect(
                title: "Title24",
                content: "Title24",
                date: Date.now.addingTimeInterval(-86400 * Double.random(in: 0...12)),
                category: .category3,
                mood: .neutral
            ),
            Retrospect(
                title: "Title25",
                content: "Title25",
                date: Date.now.addingTimeInterval(-86400 * Double.random(in: 0...12)),
                category: .category4,
                mood: .neutral
            ),
            Retrospect(
                title: "Title26",
                content: "Title26",
                date: Date.now.addingTimeInterval(-86400 * Double.random(in: 0...12)),
                category: .category2,
                mood: .neutral
            ),
            Retrospect(
                title: "Title27",
                content: "Title27",
                date: Date.now.addingTimeInterval(-86400 * Double.random(in: 0...12)),
                category: .category5,
                mood: .neutral
            ),
            Retrospect(
                title: "Title28",
                content: "Title28",
                date: Date.now.addingTimeInterval(-86400 * Double.random(in: 0...12)),
                category: .category1,
                mood: .neutral
            ),
            Retrospect(
                title: "Title29",
                content: "Title29",
                date: Date.now.addingTimeInterval(-86400 * Double.random(in: 0...12)),
                category: .category1,
                mood: .neutral
            ),
            Retrospect(
                title: "Title30",
                content: "Title30",
                date: Date.now.addingTimeInterval(-86400 * Double.random(in: 0...12)),
                category: .category4,
                mood: .neutral
            ),
            Retrospect(
                title: "Title31",
                content: "Title31",
                date: Date.now.addingTimeInterval(-86400 * Double.random(in: 0...12)),
                category: .category5,
                mood: .neutral
            ),
            Retrospect(
                title: "Title32",
                content: "Title32",
                date: Date.now.addingTimeInterval(-86400 * Double.random(in: 0...12)),
                category: .category4,
                mood: .neutral
            ),
            Retrospect(
                title: "Title33",
                content: "Title33",
                date: Date.now.addingTimeInterval(-86400 * Double.random(in: 0...12)),
                category: .category4,
                mood: .neutral
            ),
            Retrospect(
                title: "Title34",
                content: "Title34",
                date: Date.now.addingTimeInterval(-86400 * Double.random(in: 0...12)),
                category: .category5,
                mood: .neutral
            ),
            Retrospect(
                title: "Title35",
                content: "Title35",
                date: Date.now.addingTimeInterval(-86400 * Double.random(in: 0...12)),
                category: .category2,
                mood: .neutral
            ),
            Retrospect(
                title: "Title36",
                content: "Title36",
                date: Date.now.addingTimeInterval(-86400 * Double.random(in: 0...12)),
                category: .category3,
                mood: .neutral
            ),
            Retrospect(
                title: "Title37",
                content: "Title37",
                date: Date.now.addingTimeInterval(-86400 * Double.random(in: 0...12)),
                category: .category1,
                mood: .neutral
            ),
            Retrospect(
                title: "Title38",
                content: "Title38",
                date: Date.now.addingTimeInterval(-86400 * Double.random(in: 0...12)),
                category: .category2,
                mood: .neutral
            ),
            Retrospect(
                title: "Title39",
                content: "Title39",
                date: Date.now.addingTimeInterval(-86400 * Double.random(in: 0...12)),
                category: .category3,
                mood: .neutral
            ),
            Retrospect(
                title: "Title40",
                content: "Title40",
                date: Date.now.addingTimeInterval(-86400 * Double.random(in: 0...12)),
                category: .category1,
                mood: .neutral
            ),
            Retrospect(
                title: "Title41",
                content: "Title41",
                date: Date.now.addingTimeInterval(-86400 * Double.random(in: 0...12)),
                category: .category2,
                mood: .neutral
            ),
            Retrospect(
                title: "Title42",
                content: "Title42",
                date: Date.now.addingTimeInterval(-86400 * Double.random(in: 0...12)),
                category: .category3,
                mood: .neutral
            ),
            Retrospect(
                title: "Title43",
                content: "Title43",
                date: Date.now.addingTimeInterval(-86400 * Double.random(in: 0...12)),
                category: .category2,
                mood: .neutral
            ),
            Retrospect(
                title: "Title44",
                content: "Title44",
                date: Date.now.addingTimeInterval(-86400 * Double.random(in: 0...12)),
                category: .category5,
                mood: .neutral
            ),
            Retrospect(
                title: "Title45",
                content: "Title45",
                date: Date.now.addingTimeInterval(-86400 * Double.random(in: 0...12)),
                category: .category3,
                mood: .neutral
            ),
            Retrospect(
                title: "Title46",
                content: "Title46",
                date: Date.now.addingTimeInterval(-86400 * Double.random(in: 0...12)),
                category: .category5,
                mood: .neutral
            ),
            Retrospect(
                title: "Title47",
                content: "Title47",
                date: Date.now.addingTimeInterval(-86400 * Double.random(in: 0...12)),
                category: .category4,
                mood: .neutral
            ),
            Retrospect(
                title: "Title48",
                content: "Title48",
                date: Date.now.addingTimeInterval(-86400 * Double.random(in: 0...12)),
                category: .category3,
                mood: .neutral
            ),
            Retrospect(
                title: "Title49",
                content: "Title49",
                date: Date.now.addingTimeInterval(-86400 * Double.random(in: 0...12)),
                category: .category2,
                mood: .neutral
            ),
            Retrospect(
                title: "Title50",
                content: "Title50",
                date: Date.now.addingTimeInterval(-86400 * Double.random(in: 0...12)),
                category: .category5,
                mood: .neutral
            ),

        ]
    }
}
