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
    
    func setupBinding() {
        textField.rx.text.orEmpty
            .bind(to: lable.rx.text)
            .disposed(by: disposeBag)
        
        textField.rx.text.orEmpty
            .map({ s -> Bool in
                s == "" ? false : true
            })
            .observe(on: MainScheduler.instance)
            .bind(to: clearButton.rx.isEnabled)
            .disposed(by: disposeBag)
        
        clearButton.rx.tap
            .do(onNext: {
                self.clearButton.isEnabled = false
            })
            .map({ _ -> String in
                return ""
            })
            .bind(to: textField.rx.text, lable.rx.text)
            .disposed(by: disposeBag)
    }
    
    
    func setupRx() {
                
        // input
        let textInputOb = textField.rx.text.orEmpty.asObservable()
        let textEmptyCheckkOb = textInputOb.map({ s -> Bool in s == "" ? false : true })
        let clearTapOb = clearButton.rx.tap.map({ _ -> String in return ""})
    
        // output
        textInputOb
            .bind(to: lable.rx.text)
            .disposed(by: disposeBag)
        
        textEmptyCheckkOb
            .bind(to: clearButton.rx.isEnabled)
            .disposed(by: disposeBag)
        
        clearTapOb
            .do(onNext: { _ in self.clearButton.isEnabled = false })
            .bind(to: textField.rx.text, lable.rx.text)
            .disposed(by: disposeBag)
        
    //    idValidOb.subscribe(onNext: { b in self.idValidView.isHidden = b })
    //        .disposed(by: disposeBag)
    //    pwValidOb.subscribe(onNext: { b in self.pwValidView.isHidden = b })
    //        .disposed(by: disposeBag)
    //
    //    Observable.combineLatest(idValidOb, pwValidOb, resultSelector: { $0 && $1 })
    //        .subscribe(onNext: { b in
    //            self.loginButton.isEnabled = b
    //        })
    //        .disposed(by: disposeBag)
    }
}

