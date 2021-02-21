//
//  SettingsViewController.swift
//  CoinQuest
//
//  Created by Matias Cevallos on 2/20/21.
//  Copyright © 2021 Matias Cevallos. All rights reserved.
//

import SafariServices
import UIKit

struct SettingCellModel{
    let title: String
    let handler: (() -> Void)
}

//view controller for settings
final class SettingsViewController: UIViewController {
    
    private let tableView: UITableView = {
        
        let tableView = UITableView(frame: .zero,
                                    style: .grouped)
        tableView.register(UITableViewCell.self,
                           forCellReuseIdentifier: "cell")
        return tableView
    }()
    
    private var data = [[SettingCellModel]]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureModels()
        view.backgroundColor = .systemBackground
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        let size = view.frame(forAlignmentRect: CGRect(x: 0, y: 50, width: view.frame.width, height: view.frame.height))
        tableView.frame = size
    }
    
    private func configureModels(){
        data.append([
            SettingCellModel(title: "Crypto Currency"){ [weak self] in
                self?.didTapCurrency()
            },
            SettingCellModel(title: "Previous Transactions"){ [weak self] in
                self?.didTapHistory()
            },
            SettingCellModel(title: "Invite Friends"){ [weak self] in
                self?.didTapInviteFriends()
            }
        ])
        data.append([
            SettingCellModel(title: "Terms of Service"){ [weak self] in
                self?.openURL(type: .terms)
            },
            SettingCellModel(title: "Privacy Policy"){ [weak self] in
                self?.openURL(type: .privacy)
            },
            SettingCellModel(title: "Help and Feedback"){ [weak self] in
                self?.openURL(type: .help)
            }
        ])
        data.append([
            SettingCellModel(title: "Log Out"){ [weak self] in
                self?.didTapLogOut()
            }
        ])
    }
    
    enum SettingsURLType{
        case terms, privacy, help
    }
    
    private func didTapCurrency(){

    }
    
    private func didTapInviteFriends(){
        //show share sheet for invitations
        
    }
    
    private func didTapHistory(){
        
    }
    
    private func openURL(type: SettingsURLType){
        let urlString: String
        switch type{
            case .terms: urlString = ""
            case .privacy: urlString = ""
            case .help: urlString = ""

        }
        guard let url = URL(string: urlString) else{
            return
        }
        let vc = SFSafariViewController(url: url)
        present(vc, animated: true)
    }
    
    private func didTapLogOut(){
        let actionSheet = UIAlertController(title: "Log Out", message: "Are you sure you want to log out?", preferredStyle: .actionSheet)
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        actionSheet.addAction(UIAlertAction(title: "Log Out", style: .destructive, handler: { _ in
            
        }))
        actionSheet.popoverPresentationController?.sourceView = tableView
        actionSheet.popoverPresentationController?.sourceRect = tableView.bounds
        present(actionSheet, animated: true)
        
    }

}

extension SettingsViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return data.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data[section].count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = data[indexPath.section][indexPath.row].title
        cell.accessoryType = .disclosureIndicator
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        //handle selection
        data[indexPath.section][indexPath.row].handler()
    }
    
}
