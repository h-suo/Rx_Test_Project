//
//  ViewController.swift
//  Rx_Test_Project
//
//

import UIKit
import RxCocoa
import RxSwift

class ViewController: UIViewController {

    let disposeBag = DisposeBag()
    
    @IBOutlet weak var lable: UILabel!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var clearButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupRx()
    }
    
    // MARK: - basic Rx Code
//    func setupBinding() {
//        textField.rx.text.orEmpty
//            .bind(to: lable.rx.text)
//            .disposed(by: disposeBag)
//
//        textField.rx.text.orEmpty
//            .map({ s -> Bool in
//                s == "" ? false : true
//            })
//            .observe(on: MainScheduler.instance)
//            .bind(to: clearButton.rx.isEnabled)
//            .disposed(by: disposeBag)
//
//        clearButton.rx.tap
//            .do(onNext: {
//                self.clearButton.isEnabled = false
//            })
//            .map({ _ -> String in
//                return ""
//            })
//            .bind(to: textField.rx.text, lable.rx.text)
//            .disposed(by: disposeBag)
//    }
    
    // MARK: - input, output Rx Code
    func setupRx() {
                
        // input
        let textInputObservable = textField.rx.text.orEmpty.asObservable()
        let textEmptyCheckkObservable = textInputObservable.map({ s -> Bool in s == "" ? false : true })
        let clearTapObservable = clearButton.rx.tap.map({ _ -> String in return ""})
    
        // output
        textInputObservable
            .bind(to: lable.rx.text)
            .disposed(by: disposeBag)
        
        textEmptyCheckkObservable
            .bind(to: clearButton.rx.isEnabled)
            .disposed(by: disposeBag)
        
        clearTapObservable
            .do(onNext: { _ in self.clearButton.isEnabled = false })
            .bind(to: textField.rx.text, lable.rx.text)
            .disposed(by: disposeBag)
    }
}

