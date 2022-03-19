//
//  ViewController.swift
//  Flashcards
//
//  Created by Ainazik on 3/4/22.
//

import UIKit

struct Flashcard {
    var question: String
    var answer: String}
class ViewController: UIViewController {
    

    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var answerLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func didTapOnFlashcard(_ sender: Any) {
        questionLabel.isHidden=true;
    }
    
    func updateFlashcard(question: String, answer:String){


    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // We know the destination of segue is the Navigation Controller
        let navigationController = segue.destination as! UINavigationController
        
        // We know the Navigation Controller only contains a Creation View Controller
        let creationController = navigationController.topViewController as! CreationViewController
        
        // We set the flashcardsController prop to self
        creationController.flashcardsController = self

    }
    
}

