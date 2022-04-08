//
//  ViewController.swift
//  Flashcards
//
//  Created by Ainazik on 3/4/22.
//

import UIKit

struct Flashcard{
    var question:String
    var answer: String
}
class ViewController: UIViewController {
    

    @IBOutlet weak var card: UIView!
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var answerLabel: UILabel!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var prevButton: UIButton!
    
    var flashcards=[Flashcard]()
    var currentIndex=0
    
    override func viewDidLoad() {
        card.layer.cornerRadius = 20.0
        card.layer.shadowRadius = 15.0
        card.layer.shadowOpacity = 0.2
        questionLabel.clipsToBounds = true
        answerLabel.clipsToBounds = true

        super.viewDidLoad()
        //UserDefaults.standard.removeObject(forKey: "flashcards")
        readSavedFlashcards()
        if flashcards.count == 0{
            updateFlashcard(question: "What is the smallest bird in the world?", answer: "Hummingbird")}
        else{
            updateLables()
            updateNextPrevButtons()
        }
    }

    @IBAction func didTapOnFlashcard(_ sender: Any) {
        flipFlashcard()
    }
    func flipFlashcard(){
        UIView.transition(with: card, duration: 0.3, options: .transitionFlipFromRight, animations : { [self] in
            self.questionLabel.isHidden = !self.questionLabel.isHidden})
}

    
    @IBAction func didTapOnNext(_ sender: Any) {
        currentIndex = currentIndex + 1
        updateLables()
        updateNextPrevButtons()
        animateCardOut()
    }
    
    @IBAction func didTapOnPrev(_ sender: Any) {
        currentIndex = currentIndex - 1
        updateLables()
        updateNextPrevButtons()
    }
    func animateCardOut(){
        UIView.animate(withDuration: 0.3, animations: {self.card.transform=CGAffineTransform.identity.translatedBy(x: -300.0, y: 0.0)}, completion: { finished in
            self.updateLables()
            self.animateCardIn()
            
        })
    }
    func animateCardIn(){
        card.transform=CGAffineTransform.identity.translatedBy(x: 300.0, y: 0.0)
        UIView.animate(withDuration:0.3){
            self.card.transform=CGAffineTransform.identity
        }
    
    }
    
    
    
    
    func updateFlashcard(question: String, answer:String){
        let flashcard=Flashcard(question: question, answer: answer)
        flashcards.append(flashcard)
        print("Added new flashcard")
        print("Now we have \(flashcards.count) flashcards")
        currentIndex = flashcards.count - 1
        print("Our current index is \(currentIndex)")
        updateNextPrevButtons()
        updateLables()
        saveAllFlashcardsToDisk()
    }
    func updateNextPrevButtons() {
            if currentIndex == flashcards.count - 1 {
                nextButton.isEnabled = false
            } else {
                nextButton.isEnabled = true
            }
            
            if currentIndex == 0 {
                prevButton.isEnabled = false
            } else {
                prevButton.isEnabled = true
            }
        }
    func updateLables(){
        let currentFlashcard=flashcards[currentIndex]
        questionLabel.text=currentFlashcard.question
        answerLabel.text=currentFlashcard.answer
        
    }
    func saveAllFlashcardsToDisk(){
        let dictionaryArray = flashcards.map { (card) -> [String: String] in return ["question": card.question, "answer": card.answer]
            
        }
        UserDefaults.standard.set(dictionaryArray, forKey: "flashcards")
        print("🎉 Flashcards saved to UserDefaults")

    }
    func readSavedFlashcards() {
                if let dictionaryArray = UserDefaults.standard.array(forKey: "flashcards") as? [[String: String]] {
                let savedCards = dictionaryArray.map { dictionary -> Flashcard in return Flashcard(question: dictionary["question"]!, answer: dictionary["answer"]!)
                }
                flashcards.append(contentsOf: savedCards)
            }
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

