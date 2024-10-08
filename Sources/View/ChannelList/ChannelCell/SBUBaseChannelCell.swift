//
//  SBUBaseChannelCell.swift
//  SendbirdUIKit
//
//  Created by Harry Kim on 2020/03/23.
//  Copyright © 2020 Sendbird, Inc. All rights reserved.
//

import UIKit
import JuggleIM

open class SBUBaseChannelCell: SBUTableViewCell {

    // MARK: - Public property
    public private(set) var conversationInfo: JConversationInfo?

    // MARK: - View Lifecycle
 
    /// This function configure a cell using channel information.
    /// - Parameter channel: cell object
    open func configure(conversationInfo: JConversationInfo) {
        self.conversationInfo = conversationInfo
    }
    
    // MARK: -
    open override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    open override func prepareForReuse() {
        super.prepareForReuse()
    }
}
