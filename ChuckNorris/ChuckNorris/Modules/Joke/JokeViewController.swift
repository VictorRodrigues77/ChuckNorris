//
//  JokeViewController.swift
//  ChuckNorris
//
//  Created by Victor Rodrigues on 18/10/21.
//

import UIKit
import MBProgressHUD

class JokeViewController: UIViewController {
    
    @IBOutlet private weak var jokeImageView: UIImageView!
    @IBOutlet private weak var jokeTitleLabel: UILabel!
    @IBOutlet private weak var jokeOpenButton: UIButton!
    
    var presenter: JokePresenterInput?

    override func viewDidLoad() {
        super.viewDidLoad()

        presenter?.loadJoke()
        prepareNavigation()
    }

    @IBAction private func open(_ sender: UIButton) {
        presenter?.openJoke { url in
            UIApplication.shared.open(url)
        }
    }

}

extension JokeViewController {
    private func prepareNavigation() {
        title = "Joke"
        jokeImageView.isHidden = true
        jokeTitleLabel.isHidden = true
        jokeOpenButton.isHidden = true
    }
}

extension JokeViewController: JokePresenterOutput {
    func showProgress() {
        MBProgressHUD
            .showAdded(to: self.view, animated: true)
    }
    
    func hideProgress() {
        MBProgressHUD
            .hide(for: self.view, animated: true)
    }
    
    func onFetchJoke(joke: Joke) {
        jokeImageView.isHidden = false
        jokeTitleLabel.isHidden = false
        jokeOpenButton.isHidden = false
        jokeImageView.downloaded(from: joke.iconURL)
        jokeTitleLabel.text = joke.value
    }
    
    func onFetchJoke(error: String) {
        let alert = UIAlertController(title: "Error", message: error, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default) { _ in
            self.navigationController?.popViewController(animated: true)
        })
        self.present(alert, animated: true, completion: nil)
    }
}
