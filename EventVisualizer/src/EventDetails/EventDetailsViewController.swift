//
//  EventDetailsViewController.swift
//  SettingsKit
//
//  Created by Rishav Gupta on 14/03/22.
//  Copyright © 2022 PT GoJek Indonesia. All rights reserved.
//

import SwiftProtobuf
import UIKit

final class EventDetailsViewController: UIViewController {

    private let tableView: UITableView = UITableView()
    
    private let viewModel: EventDetailsViewModel = EventDetailsViewModel()
    var messageSelected: Message?
    
    // MARK: - View Life Cycle
    override func loadView() {
        view = UIView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.viewDidLoad(message: messageSelected)
        setUpViews()
        setUpLayout()
    }
    
    private func setUpViews() {
        setTitle()

        view.backgroundColor = .white
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.keyboardDismissMode = .interactive
        tableView.register(EventsListingTableViewCell.self)
    }
    
    private func setTitle() {
        if #available(iOS 13.0, *) {
            let navView = UIView()

            // Create the label
            let label = UILabel()
            label.text = "Event Details"
            label.sizeToFit()
            label.center = navView.center
            label.textAlignment = NSTextAlignment.center

            /// Create the image view
            let image = UIImageView()
            image.image = UIImage(systemName: "wrench.and.screwdriver")
            /// To maintain the image's aspect ratio:
            if let actualImage = image.image {
            let imageAspect = actualImage.size.width / actualImage.size.height
                /// Setting the image frame so that it's immediately before the text:
                image.frame = CGRect(x: label.frame.origin.x - label.frame.size.height * imageAspect, y: label.frame.origin.y, width: label.frame.size.height * imageAspect, height: label.frame.size.height)
                image.contentMode = UIView.ContentMode.scaleAspectFit
            }

            /// Add both the label and image view to the navView
            navView.addSubview(label)
            navView.addSubview(image)
            
            self.navigationItem.titleView = navView
            navView.sizeToFit()
        } else {
            title = "Event Detail"
        }
    }
    
    private func setUpLayout() {
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        tableView.translatesAutoresizingMaskIntoConstraints = false
    }
}

// MARK: - UITableViewDelegate

extension EventDetailsViewController: UITableViewDelegate {
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    public func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60.0
    }
}

// MARK: - UITableViewDataSource

extension EventDetailsViewController: UITableViewDataSource {
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.cellsCount
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell() as EventsListingTableViewCell
        cell.apply(viewModel.cellViewModel(for: indexPath))
        return cell
    }
}
