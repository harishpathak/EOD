//
//  MCQViewController.swift
//  EODAssignment
//
//  Created by Harish Pathak on 16/08/18.
//  Copyright © 2018 CRMNEXT. All rights reserved.
//

import UIKit

class MCQViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    @IBOutlet weak var tblQuestionList: UITableView!
    var viewModel = MCQViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        viewModel.modelQuestion.bindAndFire(listener: { (question) in
            print(question)
            self.tblQuestionList.reloadData()
        })
        
        viewModel.fillModel()
        
    }
    
    //MARK: - Actions
    
    @IBAction func actionCheckAnswers(_ sender: Any) {
        
        viewModel.checkAnswers = true
        tblQuestionList.reloadData()
    }
    
    @IBAction func actionReset(_ sender: Any) {
        viewModel.resetQuestions()
        tblQuestionList.reloadData()
    }
    
    //MARK: - Table View Methods
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.numberOfQuestions()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfOptions(questionIndex: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let option = viewModel.optionDataForQuestion(questionIndex: indexPath.section, optionIndex: indexPath.row)
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell_option", for: indexPath)
        
        if let label = cell.viewWithTag(101) as? UILabel {
            label.text = option.text
        }
        
        //choose option
        if viewModel.selectedAnswers.contains(indexPath) {
            
            cell.contentView.backgroundColor = .orange
            //correct answers
            if viewModel.checkAnswers{
                if option.correct == "true"{
                    cell.contentView.backgroundColor = .green
                }else{
                    cell.contentView.backgroundColor = .red
                }
            }
            
        }else{
            cell.contentView.backgroundColor = .clear
        }
        
        return cell
        
    }
    //Adjust height of row according to content
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 30
    }
    
    //Custom header view
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = Bundle.main.loadNibNamed("QuestionView", owner: self, options: nil)?.last as! UIView
        if let lbl = header.viewWithTag(101) as? UILabel{
            lbl.text = viewModel.questionText(questionIndex: section)
        }
        return header
    }
    //Adjust height of header according to content
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        viewModel.giveAnswer(path: indexPath)
        let indexSet = IndexSet.init(integer: indexPath.section)
        tableView.reloadSections(indexSet, with: .automatic)
    }
    
}

