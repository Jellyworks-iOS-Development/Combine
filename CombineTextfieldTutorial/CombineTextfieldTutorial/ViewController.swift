//
//  ViewController.swift
//  CombineTextfieldTutorial
//
//  Created by wizard on 2023/02/19.
//

import UIKit
import Combine

class ViewController: UIViewController {

    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var passwordConfirmTextField: UITextField!    
    @IBOutlet weak var myBtn: UIButton!
    
    var viewModel: MyViewModel!
    
    private var mySubscriptions = Set<AnyCancellable>()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        viewModel = MyViewModel()
        
        
        
        
        passwordTextField
            .myTextPublisher
//            .print()
            .receive(on: DispatchQueue.main)
            .assign(to: \.passwordInput, on: viewModel)
            .store(in: &mySubscriptions)
        
        passwordConfirmTextField
            .myTextPublisher
        //            .print()
            .receive(on: RunLoop.main)
            .assign(to: \.passwordConfirmInput, on: viewModel)
            .store(in: &mySubscriptions)
        
        viewModel.isMatchPasswordInput
            .print()
            .receive(on: RunLoop.main)
            .assign(to: \.isValid, on: myBtn)
            .store(in: &mySubscriptions)
        
   
    }


}

extension UITextField {
    var myTextPublisher : AnyPublisher<String, Never> {
        NotificationCenter.default.publisher(for: UITextField.textDidChangeNotification, object: self)
//            .print()
            .compactMap { $0.object as? UITextField }
            .map{ $0.text ?? "" }
            .print()
            .eraseToAnyPublisher()
    }
}

extension UIButton {
    var isValid: Bool {
        get{
            backgroundColor == .yellow
        }
        set{
            setTitleColor(newValue ? UIColor.blue : .white, for: .normal)
            backgroundColor = newValue ? .yellow : .lightGray
            isEnabled = newValue
            print(newValue)
           
        }
    }
}
