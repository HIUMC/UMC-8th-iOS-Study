/* 딕셔너리 */
// 1. 학생들의 점수 딕셔너리 선언
var studentScore: [String: Int] = ["Alice": 85, "Bob": 100, "Min": 90]

// 2. “Alice”의 점수를 95점으로 수정
studentScore["Alice"] = 95

// 3. “Bob”의 점수를 삭제하고, 남은 학생들의 점수를 출력
studentScore.removeValue(forKey: "Bob")
for (name, score) in studentScore {
    print("\(name)의 점수는 \(score)")
}

/* 세트(set) */
// 1. 과일 목록 세트 선언
var fruits: Set<String> = ["Apple", "Banana", "Orange"]

// 2. “Banana”가 이미 존재하는지 확인하고, 존재하면 “Mango”를 추가하세요
if fruits.contains("Banana") {
    fruits.insert("Mango")
}

// 3. 세트에 있는 모든 과일을 반복문으로 출력하세요
for fruit in fruits {
    print(fruit)
}

/* 열거형(enum) */
// 1. 네트워크 요청 상태 열거형 정의
enum currentStates {
    case idle
    case requesting
    case success(String)
    case failure(Error)
}

// 2. 네트워크 요청 상태를 나타내는 변수 선언
var currentState: currentStates = .idle

// 3. switch문으로 상태에 맞는 출력 작성
switch currentState {
case .idle:
    print("현재 대기 상태입니다.")
case .requesting:
    print("요청 중입니다...")
case .success(let success):
    print("요청 성공: \(success)")
case .failure(let error):
    print("요청 실패: \(error)")
}
