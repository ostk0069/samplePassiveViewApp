//
//  UserCell.swift
//  samplePassiveViewApp
//
//  Created by Takuma Osada on 2019/04/30.
//  Copyright © 2019 Takuma Osada. All rights reserved.
//

import UIKit

final class UserCell: UITableViewCell {

    @IBOutlet private weak var iconImageView: UIImageView!
    @IBOutlet private weak var name: UILabel!

    private var task: URLSessionTask?

    override func awakeFromNib() {
        super.awakeFromNib()
    }
  
    override func prepareForReuse() {
        super.prepareForReuse()
        
        task?.cancel()
        task = nil
        iconImageView.image = nil
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configure(user: User) {
        task = {
            let url = user.avatarURL
            let task = URLSession.shared.dataTask(with: url) { data, response, error in
                guard let imageData = data else {
                    return
                }
                
                DispatchQueue.global().async { [weak self] in
                    guard let image = UIImage(data: imageData) else {
                        return
                    }
                    
                    DispatchQueue.main.async {
                        self?.iconImageView.image = image
                        self?.setNeedsLayout()
                    }
                }
            }
            task.resume()
            return task
        }()
        name.text = user.login
    }
}
