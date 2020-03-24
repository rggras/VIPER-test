//
//  ProfileViewController.swift
//  MoneyBack
//
//  Created by Rodrigo Gras on 4/20/16.
//  Copyright (c) 2016 Globallogic. All rights reserved.
//

import UIKit

protocol ProfileViewControllerInput {
    func displayCurrentUser(viewModel: ProfileViewModel)
    func navigateToSignIn()
}

protocol ProfileViewControllerOutput {
    func getCurrentUser(request: ProfileRequest)
    func googleSignOut()
}

class ProfileViewController: UIViewController, ProfileViewControllerInput {
    var output: ProfileViewControllerOutput!
    var router: ProfileRouterInput!
    @IBOutlet weak var avatarImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!

    // MARK: Object lifecycle

    override func awakeFromNib() {
        super.awakeFromNib()
        ProfileConfigurator.sharedInstance.configure(self)
    }

    // MARK: View lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        getCurrentUser()
        // TODO: rfresh user information (Silent login)
    }

    // MARK: Actions
    
    @IBAction func onLogoutPressed(sender: UIButton) {
        self.output.googleSignOut()
    }
    
    // MARK: Event handling

    func getCurrentUser() {
        let request = ProfileRequest()
        self.output.getCurrentUser(request)
    }
    
    // MARK: Display logic

    func displayCurrentUser(viewModel: ProfileViewModel) {
        self.avatarImage.imageFromUrl(link: viewModel.avatarUrl!)
        self.avatarImage.circularImage()
        self.nameLabel.text = viewModel.name
        self.emailLabel.text = viewModel.email
    }
    
    func navigateToSignIn() {
        self.router.navigateToSignIn()
    }
}
