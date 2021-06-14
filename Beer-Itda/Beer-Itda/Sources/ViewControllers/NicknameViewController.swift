//
//  NicknameViewController.swift
//  Beer-Itda
//
//  Created by 초이 on 2021/03/20.
//

import UIKit

class NicknameViewController: UIViewController {
    
    // MARK: - @IBOutlet Properties
    
    @IBOutlet weak var nicknameTextField: UITextField!
    @IBOutlet weak var underlineView: UIView!
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var completeButton: UIButton!
    
    enum NicknameViewUsage: Int {
        case onboarding = 0, mypage
    }
    
    var nicknameViewUsage: NicknameViewUsage?
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initNavigationBar()
        initUnderLineAndLabel()
        disableCompleteButton()
    }
    
    // MARK: - @IBAction Functions
    
    @IBAction func touchCompleteButton(_ sender: Any) {
        if nicknameViewUsage == .onboarding {
            pushToStyleViewController()
        } else {
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    @IBAction func editTextField(_ sender: Any) {
        
        if checkRegex(nickname: nicknameTextField.text ?? "") {
            // 사용 가능한 닉네임
            showCorrectNickname()
        } else {
            // 형식에 어긋나는 닉네임
            showRegexError()
        }
    }
    
    // MARK: - Functions
    
    private func initNavigationBar() {
            self.navigationController?.initializeNavigationBarWithBackButton(navigationItem: self.navigationItem)
    }
    
    private func initUnderLineAndLabel() {
        underlineView.tintColor = UIColor.gray
        errorLabel.text = ""
        completeButton.isEnabled = true
    }
    
    private func pushToStyleViewController() {
        let styleStoryboard = UIStoryboard(name: Const.Storyboard.Name.style, bundle: nil)
        guard let styleViewController = styleStoryboard.instantiateViewController(withIdentifier: Const.ViewController.Identifier.style) as? StyleViewController else {
            return
        }
        styleViewController.styleViewUsage = .onboarding
        self.navigationController?.pushViewController(styleViewController, animated: true)
    }
    
    private func checkRegex(nickname: String) -> Bool {
        
        let pattern = "^([a-zA-Z0-9ㄱ-ㅎ|ㅏ-ㅣ|가-힣]).{1,10}$"
        let regex = try? NSRegularExpression(pattern: pattern)
        
        if let _ = regex?.firstMatch(in: nickname, options: [], range: NSRange(location: 0, length: nickname.count)) {
            
            // 닉네임이 형식에 맞을 때
            return true
        }
        return false
    }
    
    private func showRegexError() {
        underlineView.backgroundColor = UIColor.ErrorRed
        errorLabel.textColor = UIColor.ErrorRed
        errorLabel.text = "사용할 수 없는 닉네임입니다."
        disableCompleteButton()
    }
    
    private func showCorrectNickname() {
        underlineView.backgroundColor = UIColor.Green
        errorLabel.textColor = UIColor.Green
        errorLabel.text = "사용 가능한 닉네임입니다."
        enableCompleteButton()
    }
    
    private func showAlreadUsingError() {
        underlineView.backgroundColor = UIColor.ErrorRed
        errorLabel.textColor = UIColor.ErrorRed
        errorLabel.text = "이미 존재하는 닉네임입니다."
        disableCompleteButton()
    }
    
    private func enableCompleteButton() {
        completeButton.isEnabled = true
        completeButton.backgroundColor = UIColor.Black
    }
    
    private func disableCompleteButton() {
        completeButton.isEnabled = false
        completeButton.backgroundColor = UIColor.lightGray
    }

}
