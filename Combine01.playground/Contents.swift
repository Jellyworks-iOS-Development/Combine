import UIKit
import Combine

var myIntArrayPublisher :Publishers.Sequence<[Int], Never> = [1,2,3].publisher

myIntArrayPublisher.sink { completion in
    switch completion {
        case .finished:
            print("완료")
//        case .failure(let error):
//            print(error.localizedDescription)
    }
} receiveValue: { value in
    print("받은 값은 \(value)")
}

var mySubscription: AnyCancellable?
var mySubscriptionSet = Set<AnyCancellable>()
var myNotification = Notification.Name("net.jellyworks")
var myDefaultPublisher = NotificationCenter.default.publisher(for: myNotification)

//Publisher에서 Subscript 생성
mySubscription = myDefaultPublisher.sink(receiveCompletion: { completion in
    switch completion {
        case .finished:
            print("완료")
        case .failure(let error):
            print("error: \(error)")
    }
}, receiveValue: { receivedValue in
    print("받은값은 \(receivedValue)")
}) //Cancellable Set에 store

//Subscription Set에 Store
mySubscription?.store(in: &mySubscriptionSet)

//Subscription 생성과 동시에 Cancellable Set에 store
myDefaultPublisher.sink(receiveCompletion: { completion in
    switch completion {
        case .finished:
            print("완료")
        case .failure(let error):
            print("error: \(error)")
    }
}, receiveValue: { receivedValue in
    print("받은값은 \(receivedValue)")
}).store(in: &mySubscriptionSet)

NotificationCenter.default.post(Notification(name: myNotification))

NotificationCenter.default.post(Notification(name: myNotification))

NotificationCenter.default.post(Notification(name: myNotification))

//mySubscript 해제
mySubscription?.cancel()

class MyFriend {
    var name = "철수" {
        didSet {
            print("name -didSet(): ", name)
        }
    }
}

var myFriend = MyFriend()
var myFriendSubscription : AnyCancellable = ["영수"].publisher.assign(to: \.name, on: myFriend)

