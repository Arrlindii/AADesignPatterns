//
//  ViewController.swift
//  AADesignPatterns
//
//  Created by Arlind on 8/19/18.
//  Copyright © 2018 Arlind Aliu. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var surnameField: UITextField!
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var addressField: UITextField!
    @IBOutlet weak var essayField: UITextView!
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindKeyboardNotifications()
    }

    @IBAction func saveChangesAction(_ sender: UIButton) {
        let formState = FormState(name: nameField.text!, surname: surnameField.text!, address: addressField.text!, essay: essayField.text, email: emailField.text!)
        FormStateSaver.save(formState)
        alert(with: "Changes Saved")
    }
    
    @IBAction func undoAction(_ sender: Any) {
        if let state = FormStateSaver.restoreLatest() {
            configureView(for: state)
        } else {
            resetAllFields()
        }
    }
    
    @IBAction func publishAction(_ sender: Any) {
        do {
            let _ = try emailField.validatedText(validationType: ValidatorType.email)
            let _ = try nameField.validatedText(validationType: ValidatorType.name(field: "Name"))
            let _ = try surnameField.validatedText(validationType: ValidatorType.name(field: "Surname"))
            let _ = try addressField.validatedText(validationType: ValidatorType.requiredField(field: "Address"))
            let _ = try self.essayField.validatedText(validationType: ValidatorType.requiredField(field: "Essay"))
            handleDataPublished()
        } catch(let error) {
            alert(with: (error as! ValidationError).message)
        }
    }
    
    func handleDataPublished() {
        alert(with: "You have published your changes")
        resetAllFields()
        FormStateSaver.removeAllStates()
    }
    
    func resetAllFields() {
        nameField.text = ""
        surnameField.text = ""
        addressField.text = ""
        essayField.text = ""
        emailField.text = ""
    }
    
    func configureView(for state: FormState) {
        nameField.text = state.name
        surnameField.text = state.surname
        addressField.text = state.address
        essayField.text = state.essay
        emailField.text = state.email
    }
    
    func bindKeyboardNotifications() {
        NotificationCenter.default.addObserver(forName: Notification.Name.UIKeyboardWillShow, object: nil, queue: nil) { notification in
            let keyboardHeight: CGFloat = (notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue.height ?? 0
            self.bottomConstraint.constant  = 20 + keyboardHeight
        }
        
        NotificationCenter.default.addObserver(forName: Notification.Name.UIKeyboardWillHide, object: nil, queue: nil) { _ in
            self.bottomConstraint.constant = 20.0
        }
    }
    
    func alert(with message: String) {
        let alert = UIAlertController(title: "", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert,animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? RevisionsViewController {
            vc.delegate = self
        }
    }
}

extension ViewController: RevisionsViewControllerDelegate {
    func didFinish(with state: FormState) {
        configureView(for: state)
    }
}

