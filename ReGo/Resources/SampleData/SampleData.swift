//
//  SampleData.swift
//  ReGo
//
//  Created by JuHyeon Seong on 5/12/25.
//

import Foundation

private func randomPastDate(withinDays days: Int) -> Date {
    let randomInterval = TimeInterval(Int.random(in: 0...(days * 86400)))
    return Date().addingTimeInterval(-randomInterval)
}

extension Retrospect {
    static var emptyData: Retrospect {
        return Retrospect(
            title: "",
            content: "",
            date: Date(),
            category: .daily,
            mood: .tired
        )
    }

    static var sampleData: [Retrospect] {
        return [
            Retrospect(
                title: "느긋한 아침",
                content: "오늘은 알람 없이 자연스럽게 눈을 떴다. 커튼 사이로 들어오는 햇살이 따뜻하게 느껴졌고, 부엌에서 커피를 내리며 조용한 음악을 틀었다. 천천히 브런치를 먹으며 평소 놓치기 쉬운 작은 순간들을 음미했다. 이렇게 하루를 시작하니 마음이 한결 가벼웠고, 여유로운 기분으로 일정을 시작할 수 있었다.",
                date: randomPastDate(withinDays: 30),
                category: .daily,
                mood: .happy
            ),
            Retrospect(
                title: "회의 피로",
                content: "오늘 하루는 회의로 가득 차 있었다. 오전 회의에서는 팀 간 의견 차이로 논쟁이 있었고, 오후 회의는 기술적인 이슈로 시간이 지체되었다. 점심도 제대로 먹지 못한 채 계속된 일정에 정신적으로 지치고 체력도 바닥이 났다. 회의가 끝나고 나니 하루가 다 지나 있었고, 제대로 집중한 시간보다 회의에 소진된 에너지가 더 컸다.",
                date: randomPastDate(withinDays: 30),
                category: .study,
                mood: .tired
            ),
            Retrospect(
                title: "산책의 즐거움",
                content: "퇴근 후 답답한 마음을 달래기 위해 공원에 나갔다. 평소보다 한산한 공원은 잔잔한 분위기를 자아냈고, 풀냄새와 꽃향기가 은은하게 퍼졌다. 천천히 걷다 보니 머릿속이 맑아졌고, 복잡했던 생각들이 정리되는 느낌이었다. 아무 목적 없이 걷는 시간이 이렇게 소중하다는 걸 다시금 느꼈다.",
                date: randomPastDate(withinDays: 30),
                category: .relationship,
                mood: .neutral
            ),
            Retrospect(
                title: "실수와 반성",
                content: "업무 중 중요한 데이터를 잘못 입력하는 실수를 했다. 사소한 실수라고 생각했지만, 결과적으로 팀의 일정에 영향을 줄 수 있는 일이었다. 상사에게 보고하고 정정하긴 했지만 하루 종일 마음이 불편했다. 실수를 통해 다시 한번 확인의 중요성을 느꼈고, 내 책임감에 대해 돌아보게 되었다.",
                date: randomPastDate(withinDays: 30),
                category: .goal,
                mood: .anxious
            ),
            Retrospect(
                title: "친구와의 수다",
                content: "오랜만에 고등학교 친구를 만나 즐거운 시간을 보냈다. 서로의 근황을 이야기하고 예전 추억을 떠올리며 시간 가는 줄 몰랐다. 요즘 회사 일로 지쳐 있었는데, 친구와의 대화가 큰 위로가 되었다. 웃고 떠드는 동안 잠시나마 현실에서 벗어날 수 있었다.",
                date: randomPastDate(withinDays: 30),
                category: .lesson,
                mood: .happy
            ),
            Retrospect(
                title: "야근의 고단함",
                content: "오늘은 예상치 못한 버그로 인해 야근을 하게 되었다. 모두 퇴근한 사무실에서 혼자 코드를 수정하고 테스트하는 시간이 길게 느껴졌다. 배도 고프고 집중도 떨어졌지만, 결국 문제를 해결하고 나니 뿌듯함이 밀려왔다. 다음엔 더 효율적으로 일해야겠다는 생각이 들었다.",
                date: randomPastDate(withinDays: 30),
                category: .work,
                mood: .tired
            ),
            Retrospect(
                title: "영화 감상",
                content: "기다리던 영화가 개봉해 바로 예매하고 관람했다. 극장에서 보는 영화는 언제나 특별하다. 이번 영화는 배우들의 연기도 훌륭했고, 스토리도 몰입감이 높았다. 특히 결말에서 예상치 못한 반전이 인상 깊었고, 상영이 끝난 후에도 여운이 오래 남았다.",
                date: randomPastDate(withinDays: 30),
                category: .study,
                mood: .excited
            ),
            Retrospect(
                title: "운동의 성취",
                content: "오늘은 운동을 시작한 지 3주째 되는 날이었다. 매일 꾸준히 하려 노력했고, 어느새 운동이 습관처럼 자리 잡기 시작했다. 아직 체력이 부족하다고 느껴질 때도 있지만, 땀을 흘릴수록 마음도 정리되는 기분이다. 앞으로도 꾸준히 몸과 마음을 돌보려 한다.",
                date: randomPastDate(withinDays: 30),
                category: .daily,
                mood: .happy
            ),
            Retrospect(
                title: "무기력한 하루",
                content: "오늘은 하루 종일 무기력하고 의욕이 없었다. 해야 할 일들은 많았지만 손에 잡히지 않았고, 소파에 누워 넷플릭스만 보며 시간을 보냈다. 이렇게 아무것도 하지 않는 날이 필요하다고 위로했지만, 왠지 모르게 자책감이 밀려왔다.",
                date: randomPastDate(withinDays: 30),
                category: .goal,
                mood: .sad
            ),
            Retrospect(
                title: "맛있는 점심",
                content: "점심시간에 팀원들과 함께 새로 생긴 맛집에 갔다. 분위기도 아늑하고 음식도 정갈해서 대화도 자연스럽게 이어졌다. 오랜만에 유쾌한 식사 시간이었고, 다시 업무로 돌아와서도 기분 좋게 집중할 수 있었다.",
                date: randomPastDate(withinDays: 30),
                category: .relationship,
                mood: .happy
            ),
            Retrospect(
                title: "새로운 시작",
                content: "하루를 돌아보며 많은 생각이 들었다.",
                date: randomPastDate(withinDays: 60),
                category: .work,
                mood: .neutral
            ),
            Retrospect(
                title: "늦잠의 여유",
                content: "크게 특별한 일은 없었지만 평온한 하루였다.",
                date: randomPastDate(withinDays: 60),
                category: .goal,
                mood: .sad
            ),
            Retrospect(
                title: "버그 수정",
                content: "작은 실수 하나가 많은 것을 배우게 해줬다.",
                date: randomPastDate(withinDays: 60),
                category: .relationship,
                mood: .anxious
            ),
            Retrospect(
                title: "동료와의 마찰",
                content: "내가 진짜 원하는 방향이 무엇인지 고민하게 된다.",
                date: randomPastDate(withinDays: 60),
                category: .work,
                mood: .anxious
            ),
            Retrospect(
                title: "야근의 대가",
                content: "나 자신에게 솔직해지려 노력하는 하루였다.",
                date: randomPastDate(withinDays: 60),
                category: .goal,
                mood: .angry
            ),
            Retrospect(
                title: "성취의 기쁨",
                content: "지친 하루였지만 의미 있는 시간이었다.",
                date: randomPastDate(withinDays: 60),
                category: .daily,
                mood: .excited
            ),
            Retrospect(
                title: "이직 준비",
                content: "앞으로의 나를 기대하게 된 하루.",
                date: randomPastDate(withinDays: 60),
                category: .daily,
                mood: .anxious
            ),
            Retrospect(
                title: "주말 루틴",
                content: "더 나아지기 위해 필요한 하루였다.",
                date: randomPastDate(withinDays: 60),
                category: .lesson,
                mood: .neutral
            ),
            Retrospect(
                title: "고양이와의 오후",
                content: "휴식도 생산적인 활동이라는 걸 느꼈다.",
                date: randomPastDate(withinDays: 60),
                category: .relationship,
                mood: .angry
            ),
            Retrospect(
                title: "새 프로젝트 시작",
                content: "소소한 행복이 주는 큰 위안을 느낀 하루.",
                date: randomPastDate(withinDays: 60),
                category: .daily,
                mood: .sad
            ),
            Retrospect(
                title: "집중력 저하",
                content: "하루를 돌아보며 많은 생각이 들었다.",
                date: randomPastDate(withinDays: 60),
                category: .relationship,
                mood: .angry
            ),
            Retrospect(
                title: "운동 루틴",
                content: "크게 특별한 일은 없었지만 평온한 하루였다.",
                date: randomPastDate(withinDays: 60),
                category: .work,
                mood: .excited
            ),
            Retrospect(
                title: "좋은 책 발견",
                content: "작은 실수 하나가 많은 것을 배우게 해줬다.",
                date: randomPastDate(withinDays: 60),
                category: .daily,
                mood: .anxious
            ),
            Retrospect(
                title: "우울한 하루",
                content: "내가 진짜 원하는 방향이 무엇인지 고민하게 된다.",
                date: randomPastDate(withinDays: 60),
                category: .study,
                mood: .happy
            ),
            Retrospect(
                title: "성장하는 느낌",
                content: "나 자신에게 솔직해지려 노력하는 하루였다.",
                date: randomPastDate(withinDays: 60),
                category: .goal,
                mood: .tired
            ),
            Retrospect(
                title: "거절의 용기",
                content: "지친 하루였지만 의미 있는 시간이었다.",
                date: randomPastDate(withinDays: 60),
                category: .daily,
                mood: .excited
            ),
            Retrospect(
                title: "어색한 만남",
                content: "앞으로의 나를 기대하게 된 하루.",
                date: randomPastDate(withinDays: 60),
                category: .relationship,
                mood: .happy
            ),
            Retrospect(
                title: "재미있는 아이디어",
                content: "더 나아지기 위해 필요한 하루였다.",
                date: randomPastDate(withinDays: 60),
                category: .work,
                mood: .neutral
            ),
            Retrospect(
                title: "피드백 수용",
                content: "휴식도 생산적인 활동이라는 걸 느꼈다.",
                date: randomPastDate(withinDays: 60),
                category: .daily,
                mood: .angry
            ),
            Retrospect(
                title: "자기 반성",
                content: "소소한 행복이 주는 큰 위안을 느낀 하루.",
                date: randomPastDate(withinDays: 60),
                category: .study,
                mood: .happy
            ),
            Retrospect(
                title: "느긋한 아침",
                content: "오늘은 알람 없이 자연스럽게 눈을 떴다. 커튼 사이로 들어오는 햇살이 따뜻하게 느껴졌고, 부엌에서 커피를 내리며 조용한 음악을 틀었다. 천천히 브런치를 먹으며 평소 놓치기 쉬운 작은 순간들을 음미했다. 이렇게 하루를 시작하니 마음이 한결 가벼웠고, 여유로운 기분으로 일정을 시작할 수 있었다.",
                date: randomPastDate(withinDays: 30),
                category: .daily,
                mood: .happy
            ),
            Retrospect(
                title: "회의 피로",
                content: "오늘 하루는 회의로 가득 차 있었다. 오전 회의에서는 팀 간 의견 차이로 논쟁이 있었고, 오후 회의는 기술적인 이슈로 시간이 지체되었다. 점심도 제대로 먹지 못한 채 계속된 일정에 정신적으로 지치고 체력도 바닥이 났다. 회의가 끝나고 나니 하루가 다 지나 있었고, 제대로 집중한 시간보다 회의에 소진된 에너지가 더 컸다.",
                date: randomPastDate(withinDays: 30),
                category: .study,
                mood: .tired
            ),
            Retrospect(
                title: "산책의 즐거움",
                content: "퇴근 후 답답한 마음을 달래기 위해 공원에 나갔다. 평소보다 한산한 공원은 잔잔한 분위기를 자아냈고, 풀냄새와 꽃향기가 은은하게 퍼졌다. 천천히 걷다 보니 머릿속이 맑아졌고, 복잡했던 생각들이 정리되는 느낌이었다. 아무 목적 없이 걷는 시간이 이렇게 소중하다는 걸 다시금 느꼈다.",
                date: randomPastDate(withinDays: 30),
                category: .relationship,
                mood: .neutral
            ),
            Retrospect(
                title: "실수와 반성",
                content: "업무 중 중요한 데이터를 잘못 입력하는 실수를 했다. 사소한 실수라고 생각했지만, 결과적으로 팀의 일정에 영향을 줄 수 있는 일이었다. 상사에게 보고하고 정정하긴 했지만 하루 종일 마음이 불편했다. 실수를 통해 다시 한번 확인의 중요성을 느꼈고, 내 책임감에 대해 돌아보게 되었다.",
                date: randomPastDate(withinDays: 30),
                category: .goal,
                mood: .anxious
            ),
            Retrospect(
                title: "친구와의 수다",
                content: "오랜만에 고등학교 친구를 만나 즐거운 시간을 보냈다. 서로의 근황을 이야기하고 예전 추억을 떠올리며 시간 가는 줄 몰랐다. 요즘 회사 일로 지쳐 있었는데, 친구와의 대화가 큰 위로가 되었다. 웃고 떠드는 동안 잠시나마 현실에서 벗어날 수 있었다.",
                date: randomPastDate(withinDays: 30),
                category: .lesson,
                mood: .happy
            ),
            Retrospect(
                title: "야근의 고단함",
                content: "오늘은 예상치 못한 버그로 인해 야근을 하게 되었다. 모두 퇴근한 사무실에서 혼자 코드를 수정하고 테스트하는 시간이 길게 느껴졌다. 배도 고프고 집중도 떨어졌지만, 결국 문제를 해결하고 나니 뿌듯함이 밀려왔다. 다음엔 더 효율적으로 일해야겠다는 생각이 들었다.",
                date: randomPastDate(withinDays: 30),
                category: .work,
                mood: .tired
            ),
            Retrospect(
                title: "영화 감상",
                content: "기다리던 영화가 개봉해 바로 예매하고 관람했다. 극장에서 보는 영화는 언제나 특별하다. 이번 영화는 배우들의 연기도 훌륭했고, 스토리도 몰입감이 높았다. 특히 결말에서 예상치 못한 반전이 인상 깊었고, 상영이 끝난 후에도 여운이 오래 남았다.",
                date: randomPastDate(withinDays: 30),
                category: .study,
                mood: .excited
            ),
            Retrospect(
                title: "운동의 성취",
                content: "오늘은 운동을 시작한 지 3주째 되는 날이었다. 매일 꾸준히 하려 노력했고, 어느새 운동이 습관처럼 자리 잡기 시작했다. 아직 체력이 부족하다고 느껴질 때도 있지만, 땀을 흘릴수록 마음도 정리되는 기분이다. 앞으로도 꾸준히 몸과 마음을 돌보려 한다.",
                date: randomPastDate(withinDays: 30),
                category: .daily,
                mood: .happy
            ),
            Retrospect(
                title: "무기력한 하루",
                content: "오늘은 하루 종일 무기력하고 의욕이 없었다. 해야 할 일들은 많았지만 손에 잡히지 않았고, 소파에 누워 넷플릭스만 보며 시간을 보냈다. 이렇게 아무것도 하지 않는 날이 필요하다고 위로했지만, 왠지 모르게 자책감이 밀려왔다.",
                date: randomPastDate(withinDays: 30),
                category: .goal,
                mood: .sad
            ),
            Retrospect(
                title: "맛있는 점심",
                content: "점심시간에 팀원들과 함께 새로 생긴 맛집에 갔다. 분위기도 아늑하고 음식도 정갈해서 대화도 자연스럽게 이어졌다. 오랜만에 유쾌한 식사 시간이었고, 다시 업무로 돌아와서도 기분 좋게 집중할 수 있었다.",
                date: randomPastDate(withinDays: 30),
                category: .relationship,
                mood: .happy
            ),
            Retrospect(
                title: "새로운 시작",
                content: "하루를 돌아보며 많은 생각이 들었다.",
                date: randomPastDate(withinDays: 60),
                category: .work,
                mood: .neutral
            ),
            Retrospect(
                title: "늦잠의 여유",
                content: "크게 특별한 일은 없었지만 평온한 하루였다.",
                date: randomPastDate(withinDays: 60),
                category: .goal,
                mood: .sad
            ),
            Retrospect(
                title: "버그 수정",
                content: "작은 실수 하나가 많은 것을 배우게 해줬다.",
                date: randomPastDate(withinDays: 60),
                category: .relationship,
                mood: .anxious
            ),
            Retrospect(
                title: "동료와의 마찰",
                content: "내가 진짜 원하는 방향이 무엇인지 고민하게 된다.",
                date: randomPastDate(withinDays: 60),
                category: .work,
                mood: .anxious
            ),
            Retrospect(
                title: "야근의 대가",
                content: "나 자신에게 솔직해지려 노력하는 하루였다.",
                date: randomPastDate(withinDays: 60),
                category: .goal,
                mood: .angry
            ),
            Retrospect(
                title: "성취의 기쁨",
                content: "지친 하루였지만 의미 있는 시간이었다.",
                date: randomPastDate(withinDays: 60),
                category: .daily,
                mood: .excited
            ),
            Retrospect(
                title: "이직 준비",
                content: "앞으로의 나를 기대하게 된 하루.",
                date: randomPastDate(withinDays: 60),
                category: .daily,
                mood: .anxious
            ),
            Retrospect(
                title: "주말 루틴",
                content: "더 나아지기 위해 필요한 하루였다.",
                date: randomPastDate(withinDays: 60),
                category: .lesson,
                mood: .neutral
            ),
            Retrospect(
                title: "고양이와의 오후",
                content: "휴식도 생산적인 활동이라는 걸 느꼈다.",
                date: randomPastDate(withinDays: 60),
                category: .relationship,
                mood: .angry
            ),
            Retrospect(
                title: "새 프로젝트 시작",
                content: "소소한 행복이 주는 큰 위안을 느낀 하루.",
                date: randomPastDate(withinDays: 60),
                category: .daily,
                mood: .sad
            ),
            Retrospect(
                title: "집중력 저하",
                content: "하루를 돌아보며 많은 생각이 들었다.",
                date: randomPastDate(withinDays: 60),
                category: .relationship,
                mood: .angry
            ),
            Retrospect(
                title: "운동 루틴",
                content: "크게 특별한 일은 없었지만 평온한 하루였다.",
                date: randomPastDate(withinDays: 60),
                category: .work,
                mood: .excited
            ),
            Retrospect(
                title: "좋은 책 발견",
                content: "작은 실수 하나가 많은 것을 배우게 해줬다.",
                date: randomPastDate(withinDays: 60),
                category: .daily,
                mood: .anxious
            ),
            Retrospect(
                title: "우울한 하루",
                content: "내가 진짜 원하는 방향이 무엇인지 고민하게 된다.",
                date: randomPastDate(withinDays: 60),
                category: .study,
                mood: .happy
            ),
            Retrospect(
                title: "성장하는 느낌",
                content: "나 자신에게 솔직해지려 노력하는 하루였다.",
                date: randomPastDate(withinDays: 60),
                category: .goal,
                mood: .tired
            ),
            Retrospect(
                title: "거절의 용기",
                content: "지친 하루였지만 의미 있는 시간이었다.",
                date: randomPastDate(withinDays: 60),
                category: .daily,
                mood: .excited
            ),
            Retrospect(
                title: "어색한 만남",
                content: "앞으로의 나를 기대하게 된 하루.",
                date: randomPastDate(withinDays: 60),
                category: .relationship,
                mood: .happy
            ),
            Retrospect(
                title: "재미있는 아이디어",
                content: "더 나아지기 위해 필요한 하루였다.",
                date: randomPastDate(withinDays: 60),
                category: .work,
                mood: .neutral
            ),
            Retrospect(
                title: "피드백 수용",
                content: "휴식도 생산적인 활동이라는 걸 느꼈다.",
                date: randomPastDate(withinDays: 60),
                category: .daily,
                mood: .angry
            ),
            Retrospect(
                title: "자기 반성",
                content: "소소한 행복이 주는 큰 위안을 느낀 하루.",
                date: randomPastDate(withinDays: 60),
                category: .study,
                mood: .happy
            ),
        ]
    }
}
