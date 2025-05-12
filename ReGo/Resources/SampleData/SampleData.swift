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
                category: .category1

            ),
            Retrospect(
                title: "Title2",
                content: "Ut mollis pulvinar ex sit amet tempor. In sapien risus, aliquet ut suscipit vitae, laoreet eu lectus. Duis nisl sem, suscipit malesuada ultricies ut, ultricies vel sapien. Duis laoreet fermentum lorem, at aliquam purus posuere ac. Sed gravida ipsum nec purus consectetur eleifend vel eget erat. Nulla et erat arcu. In in justo gravida, posuere urna ut, feugiat nisi. Quisque ultrices, purus in semper sodales, purus nisi pulvinar ex, sit amet ornare arcu est a nulla. Suspendisse massa elit, faucibus et justo vel, tristique varius augue. Phasellus pulvinar ut nibh vel placerat.",
                date: Date.distantPast,
                category: .category2

            ),
            Retrospect(
                title: "Title3",
                content: "Aenean est orci, semper non ex at, porta sodales est. Etiam pulvinar sed lectus sit amet consectetur. Phasellus a venenatis orci. Curabitur ac tellus eget turpis accumsan gravida. Sed et nisi mauris. Maecenas mollis erat sed quam facilisis congue. Duis ornare ultrices neque ac viverra. Integer molestie quam eu metus imperdiet, eu tempor urna luctus.",
                date: Date.distantFuture,
                category: .category3
            ),
            Retrospect(
                title: "Title4",
                content: "Mauris aliquam elit vel dictum hendrerit. Mauris non mauris a velit sagittis venenatis. Donec mattis pharetra diam, dapibus tincidunt urna viverra in. Etiam luctus urna sit amet enim fringilla mattis. Nunc maximus, augue porta mattis lobortis, ipsum risus iaculis elit, sed malesuada est augue a sem. Donec rutrum lacinia elit vulputate pellentesque. Nullam iaculis justo felis, at egestas justo fringilla id. Phasellus in tellus et nisi vulputate elementum sed vel enim. Vivamus ut orci id dui condimentum lacinia. In iaculis neque ut faucibus eleifend.",
                date: Date.distantPast,
                category: .category4
            ),
            Retrospect(
                title: "Title5",
                content: "Vestibulum rhoncus lectus nec viverra vehicula. Aliquam tincidunt dui neque, et lacinia sem euismod at. Aenean nec leo metus. Quisque in lectus elit. Integer non varius sem. Nullam tincidunt consequat tortor, ac tincidunt elit faucibus quis. Proin mollis, risus vitae dictum bibendum, magna urna fringilla enim, mollis malesuada libero lorem et enim.",
                date: Date.distantPast,
                category: .category5
            ),
            Retrospect(
                title: "Title6",
                content: "Cras ut euismod felis. Nulla quis facilisis quam. Mauris eleifend enim nulla. Donec laoreet ipsum nisl, id placerat eros ultrices sit amet. Praesent non sagittis mi. Praesent efficitur est nibh, et sagittis magna facilisis at. Sed vitae suscipit dolor. Maecenas molestie tempor elit, eget posuere augue vulputate nec. Pellentesque consequat vehicula libero id faucibus. Duis tristique dapibus laoreet. Sed ultrices pulvinar suscipit. Nunc massa nisl, ultricies nec auctor ut, imperdiet eu massa.",
                date: Date.distantFuture,
                category: .category1
            ),
            Retrospect(
                title: "Title7",
                content: "Praesent a mi facilisis, hendrerit ex nec, ultricies felis. Maecenas et risus in est porta suscipit. Integer blandit consequat sem eu ultrices. Cras venenatis pellentesque tincidunt. Donec auctor neque arcu, sed vehicula lacus eleifend a. Vivamus lacinia leo eu dolor iaculis, sit amet sagittis neque consectetur. Donec lobortis purus in eros ornare, non blandit nulla pulvinar. Cras hendrerit tellus ac neque vestibulum, nec fringilla enim efficitur.",
                date: Date.distantFuture,
                category: .category2
            ),
            Retrospect(
                title:"Title8",
                content: "Sed porttitor nisl sit amet nisl vehicula, sit amet imperdiet metus tincidunt. In et dictum odio. Aenean et accumsan lorem. Sed accumsan ipsum id ante porta, sed placerat ex sodales. Vivamus vitae ligula at neque rhoncus sodales nec id nisi. Fusce ut varius ligula. Donec iaculis nulla in nisi semper fringilla. Nam pellentesque feugiat augue quis tempor. Morbi justo mauris, vestibulum efficitur justo vel, aliquam sollicitudin tellus. Ut vel ex ac elit fringilla feugiat sit amet in nunc. Vestibulum accumsan ornare tortor nec ultricies. Pellentesque nec ligula tortor. Vivamus vehicula ligula pretium augue posuere semper.",
                date: Date.now,
                category: .category3
            ),
            Retrospect(
                title: "Title9",
                content: "Interdum et malesuada fames ac ante ipsum primis in faucibus. Vivamus commodo consequat eros, mattis commodo sapien facilisis sit amet. Nullam commodo efficitur mi, non aliquam magna rhoncus a. Phasellus tempus odio id neque lobortis volutpat. Suspendisse tempus neque orci, vel interdum arcu mattis quis. Interdum et malesuada fames ac ante ipsum primis in faucibus. Integer sit amet aliquam turpis. Donec velit urna, fringilla non bibendum in, imperdiet quis diam. Suspendisse potenti.",
                date: Date.now,
                category: .category4
            ),
            Retrospect(
                title: "Title10",
                content: "Phasellus non imperdiet neque. Integer id molestie velit. Donec vel tincidunt magna. Etiam tempus augue justo, vel semper ipsum hendrerit sit amet. Vestibulum nec odio dignissim, posuere nisi ac, sollicitudin nisl. Vivamus eu velit vitae purus ullamcorper molestie non convallis purus. Nullam aliquet semper est, ac pulvinar ante cursus fermentum. Curabitur elementum dapibus sollicitudin. Praesent sit amet purus finibus quam placerat auctor. Ut at lacinia leo, ac varius odio. Nunc pulvinar congue pulvinar. Praesent in rhoncus ex, at facilisis nunc. Praesent viverra neque nec luctus tincidunt. Aliquam gravida at velit vel porta. Pellentesque non placerat tellus. Mauris id nunc consequat quam dapibus rutrum id sit amet orci.",
                date: Date.distantFuture,
                category: .category5
            ),

        ]
    }
}
