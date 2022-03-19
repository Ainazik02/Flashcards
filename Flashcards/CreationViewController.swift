//
//  CreationViewController.swift
//  Flashcards
//
//  Created by Ainazik on 3/18/22.
//

import UIKit

class CreationViewController: UIViewController {
    var flashcardsController: ViewController!
    @IBOutlet weak var questionField: UITextField!
    @IBOutlet weak var answerField: UITextField!
    var initialQuestion: String?
    var initialAnswer: String?



    override func viewDidLoad() {
        super.viewDidLoad()
        questionField.text = initialQuestion
        answerField.text = initialAnswer


        // Do any additional setup after loading the view.
    }
    
    @IBAction func didTapOnCancel(_ sender: Any) {
        dismiss(animated: true)
    }
    
    @IBAction func didTapOnDone(_ sender: Any) {
        let questionText = questionField.text
        let answerText = answerField.text
        flashcardsController.updateFlashcard(question: questionText!, answer: answerText!)
        dismiss(animated: true)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
