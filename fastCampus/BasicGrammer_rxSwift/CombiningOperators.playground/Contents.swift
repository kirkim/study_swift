import RxSwift
import Foundation

let disposeBag = DisposeBag()


print("-------startWith1-------")
let λΈλλ° = Observable<String>.of("π§π»", "π§π½", "π¦")

λΈλλ°
    .startWith("π¨π»μ μλ")
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)


print("-------startWith2-------")
let νλλ° = Observable<String>.of("π§π»", "π§π½", "π¦")

νλλ°
    .enumerated()
    .map { index, element in
        element + "μ΄λ¦°μ΄" + "\(index)"
    }
    .startWith("π¨π»μ μλ")
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)


print("-------concat1-------")
let λΈλλ°μ΄λ¦°μ΄λ€ = Observable<String>.of("π§π»", "π§π½", "π¦")
let μ μλ = Observable<String>.of("π¨π»μ μλ")

let μ€μμκ±·κΈ° = Observable
    .concat([μ μλ, λΈλλ°μ΄λ¦°μ΄λ€])

μ€μμκ±·κΈ°
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)


print("-------concat2-------")
μ μλ
    .concat(λΈλλ°μ΄λ¦°μ΄λ€)
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)


print("-------concatMap-------")
let μ΄λ¦°μ΄μ§: [String: Observable<String>] = [
    "λΈλλ°": Observable.of("π§π»", "π§π½", "π¦"),
    "νλλ°": Observable.of("πΆπ»", "πΆπΏ")
]

Observable.of("λΈλλ°", "νλλ°")
    .concatMap { λ° in
        μ΄λ¦°μ΄μ§[λ°] ?? .empty()
    }
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)


print("-------merge1-------")
let κ°λΆ = Observable.from(["κ°λΆκ΅¬", "μ±λΆκ΅¬", "λλλ¬Έκ΅¬", "μ’λ‘κ΅¬"])
let κ°λ¨ = Observable.from(["κ°λ¨κ΅¬", "κ°λκ΅¬", "μλ±ν¬κ΅¬", "μμ²κ΅¬"])

Observable.of(κ°λΆ, κ°λ¨)
    .merge()
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)


print("-------merge2-------")
Observable.of(κ°λΆ, κ°λ¨)
    .merge(maxConcurrent: 1) // λμμ λ³Ό μ΅μ λ²λΈμ μ ν, λ€νΈμν¬μμ²­ μ°κ²°μ μ¬ν ν λ μ¬μ©(μ μ¬μ©μx)
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)


print("-------combineLatest1-------")
let μ± = PublishSubject<String>()
let μ΄λ¦ = PublishSubject<String>()

let μ±λͺ = Observable
    .combineLatest(μ±, μ΄λ¦) { μ±, μ΄λ¦ in
        μ± + μ΄λ¦
    }

μ±λͺ
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)

μ±.onNext("κΉ")
μ΄λ¦.onNext("λλ")
μ΄λ¦.onNext("μμ")
μ΄λ¦.onNext("μμ")
μ±.onNext("λ°")
μ±.onNext("μ΄")
μ±.onNext("μ‘°")


print("-------combineLatest2-------")
let λ μ§νμνμ = Observable<DateFormatter.Style>.of(.short, .long)
let νμ¬λ μ§ = Observable<Date>.of(Date())

let νμ¬λ μ§νμ = Observable
    .combineLatest(
        λ μ§νμνμ,
        νμ¬λ μ§,
        resultSelector: { νμ, λ μ§ -> String in
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = νμ
            return dateFormatter.string(from: λ μ§)
        })

νμ¬λ μ§νμ
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)


print("-------combineLatest3-------")
let lastName = PublishSubject<String>()
let firstName = PublishSubject<String>()

let fullName = Observable
    .combineLatest([firstName, lastName]) { name in
        name.joined(separator: " ")
    }

fullName
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)

lastName.onNext("Kim")
firstName.onNext("Paul")
firstName.onNext("Stella")
firstName.onNext("Lily")


print("-------zip-------")
// combineLatestμ λΉμ·ν΄ λ³΄μ΄μ§λ§ λμ€νλμ observableμ΄ λλλ©΄ κ·Έλλ‘ λλλ²λ¦Ό
enum μΉν¨ {
    case μΉ
    case ν¨
}

let μΉλΆ = Observable<μΉν¨>.of(.μΉ, .μΉ, .ν¨, .μΉ, .μΉ)
let μ μ = Observable<String>.of("π°π·", "π©π°", "π―π΅", "πΊπ¦", "πΊπΈ")

let μν©κ²°κ³Ό = Observable
    .zip(μΉλΆ, μ μ) { κ²°κ³Ό, λνμ μ in
        return λνμ μ + "μ μ" + "\(κ²°κ³Ό)"
    }

μν©κ²°κ³Ό
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)


print("-------withLatestFrom1-------")
let π₯ = PublishSubject<Void>()
let λ¬λ¦¬κΈ°μ μ = PublishSubject<String>()

π₯
    .withLatestFrom(λ¬λ¦¬κΈ°μ μ)
//    .distinctUntilChanged()  // sampleμ²λΌ λμ
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)

λ¬λ¦¬κΈ°μ μ.onNext("ππ»ββοΈ")
λ¬λ¦¬κΈ°μ μ.onNext("ππ»ββοΈ ππΌββοΈ")
λ¬λ¦¬κΈ°μ μ.onNext("ππ»ββοΈ ππΌββοΈ ππΏ")
π₯.onNext(Void())
π₯.onNext(Void())


print("-------sample-------")
// withLatestFromκ³Ό λΉμ·ν΄λ³΄μ΄μ§λ§ μ΅μ΄νλ²λ§ λ°λν¨
let πμΆλ° = PublishSubject<Void>()
let F1μ μ = PublishSubject<String>()

F1μ μ
    .sample(πμΆλ°)
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)

F1μ μ.onNext("π")
F1μ μ.onNext("π  π")
F1μ μ.onNext("π      π  π")
πμΆλ°.onNext(Void())
πμΆλ°.onNext(Void())
πμΆλ°.onNext(Void())


print("-------amb-------")
//element(μμ)λ₯Ό λ¨Όμ  λ°©μΆνλ Observableλ§ κ΄μ°°ν¨
let πλ²μ€1 = PublishSubject<String>()
let πλ²μ€2 = PublishSubject<String>()

let πλ²μ€μ λ₯μ₯ = πλ²μ€1.amb(πλ²μ€2)

πλ²μ€μ λ₯μ₯
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)

πλ²μ€2.onNext("λ²μ€2-μΉκ°0: π­")
πλ²μ€1.onNext("λ²μ€1-μΉκ°0: πΉ")
πλ²μ€1.onNext("λ²μ€1-μΉκ°1: π¦")
πλ²μ€2.onNext("λ²μ€2-μΉκ°1: πΆ")
πλ²μ€1.onNext("λ²μ€1-μΉκ°1: π±")
πλ²μ€2.onNext("λ²μ€2-μΉκ°2: π―")


print("-------switchLatest-------")
// λ§μ§λ§ μνμ€μ μ΅μ λ²λ§ κ΅¬λ
let π©π»βπ»νμ1 = PublishSubject<String>()
let π©π½βπ»νμ2 = PublishSubject<String>()
let π¨βπ»νμ3 = PublishSubject<String>()

let μλ€κΈ° = PublishSubject<Observable<String>>()

let μλ μ¬λλ§λ§ν μμλκ΅μ€ = μλ€κΈ°.switchLatest()

μλ μ¬λλ§λ§ν μμλκ΅μ€
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)

μλ€κΈ°.onNext(π©π»βπ»νμ1)
π©π»βπ»νμ1.onNext("π©π»βπ»νμ1: μ λ 1λ² νμμλλ€.")
π©π½βπ»νμ2.onNext("π©π½βπ»νμ2: μ λ 15λ² νμμλλ€.")

μλ€κΈ°.onNext(π©π½βπ»νμ2)
π©π½βπ»νμ2.onNext("π©π½βπ»νμ2: λ€μ λ§νκ²μ μ λ 15λ²μ΄μμ!")
π©π»βπ»νμ1.onNext("π©π»βπ»νμ1: μΌ λ΄κ° λ§νκ³  μμλ")

μλ€κΈ°.onNext(π¨βπ»νμ3)
π©π»βπ»νμ1.onNext("π©π»βπ»νμ1: μ΄λ° λ΄λ§μ’!!")
π©π½βπ»νμ2.onNext("π©π½βπ»νμ2: λ λ§ μΉνλ―γγ")
π¨βπ»νμ3.onNext("π¨βπ»νμ3: λ§νκ³  μΆμΌλ©΄ μλ€κ³  λ§νλΌκ³ !")

μλ€κΈ°.onNext(π©π»βπ»νμ1)
π©π»βπ»νμ1.onNext("π©π»βπ»νμ1: νν κ·ΈλΌ λ΄κ° μλ€κ³  λ§ν΄μΌμ§")
π©π½βπ»νμ2.onNext("π©π½βπ»νμ2: ν, μ λ°...")
π¨βπ»νμ3.onNext("π©π»βπ»νμ1: μλ λ΄μ°¨λ‘λ°..")
π©π½βπ»νμ2.onNext("π©π½βπ»νμ2: μ΄κ±° λλ¬΄νλ€ μλ€κΈ° μΈμλ μλκ³ ")


print("-------reduce-------")
Observable.from((1...10))
    .reduce(0, accumulator: { summary, newValue in
        return summary + newValue
    })
//    .reduce(0, accumulator: +) // μΆμ½ν΄μ μμ±
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)


print("-------scan-------")
// reduceμ λμμ λμΌνμ§λ§ μλ‘μ΄ elementλ§λ€ κ²°κ³Όλ₯Ό λ³΄μ¬μ€
Observable.from((1...10))
    .scan(0, accumulator: +)
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)
