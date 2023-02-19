//
//  MyViewModel.swift
//  CombineTextfieldTutorial
//
//  Created by wizard on 2023/02/19.
//

import Foundation
import Combine

class MyViewModel {
    @Published var passwordInput: String = "" {
        didSet {
            print("MyViewModel / PasswordInput: \(passwordInput) ")
        }
    }
    @Published var passwordConfirmInput: String = "" {
        didSet {
            print("MyViewModel / PasswordConfirmInputInput: \(passwordConfirmInput) ")
        }
    }
    
    lazy var isMatchPasswordInput : AnyPublisher<Bool, Never> = Publishers
        .CombineLatest($passwordInput, $passwordConfirmInput)
        .map({(password: String, passwordConfirm: String) in
            if password == "" || passwordConfirm == ""{
                return false
            }
            if password == passwordConfirm {
                return true
            } else {
                return false
            }
        })
        .print()
        .eraseToAnyPublisher()
}
