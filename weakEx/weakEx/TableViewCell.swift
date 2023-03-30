//
//  TableViewCell.swift
//  weakEx
//
//  Created by 김민재 on 2023/03/30.
//

import UIKit

protocol TableViewCellProtocol: AnyObject {
    func buttonDidTap()
}

class TableViewCell: UITableViewCell {

    weak var delegate: TableViewCellProtocol?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    deinit {
        print("cell deinit ❌ ")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func buttonDidTap(_ sender: Any) {
        delegate?.buttonDidTap()
    }
}
