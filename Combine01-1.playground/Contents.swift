import UIKit
import Combine


let myIntArrayPublisher: Publishers.Sequence<[Int], Never> = [1,2,3].publisher

myIntArrayPublisher.sink { completion in
    switch completion {
        case .finished:print("완료")
    }
} receiveValue: { recievedValue in
    print(recievedValue)
}



var mySubscription: AnyCancellable?
var mySubscriptionSet = Set<AnyCancellable>()
var myNotification = Notification.Name("merong")
var myDefaultPublisher = NotificationCenter.default.publisher(for: myNotification)

mySubscription = myDefaultPublisher.sink(receiveCompletion: { completion in
    switch completion {
        case .finished: print("완료")
        case .failure(let error):
            print(error)
    }
}, receiveValue: { recievedValue in
    print(recievedValue)
})
mySubscription?.store(in: &mySubscriptionSet)

NotificationCenter.default.post(Notification(name: myNotification))
NotificationCenter.default.post(Notification(name: myNotification))
NotificationCenter.default.post(Notification(name: myNotification))


//구독 set 해제하는 방법
for sub in mySubscriptionSet {
    sub.cancel()
}
mySubscriptionSet.removeAll()

//mySubscription?.cancel()

NotificationCenter.default.post(Notification(name: myNotification))

class MyFriend {
    var name = "철수" {
        didSet {
            print("name - didSet(): \(name)")
        }
    }
}

var myFriend = MyFriend()
var myFriendSubscription: AnyCancellable = ["wizard"].publisher.assign(to: \.name, on: myFriend)

