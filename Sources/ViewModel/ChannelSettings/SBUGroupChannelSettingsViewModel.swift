//
//  SBUGroupChannelSettingsViewModel.swift
//  SendbirdUIKit
//
//  Created by Tez Park on 2021/09/22.
//  Copyright © 2021 Sendbird, Inc. All rights reserved.
//

import Foundation
import UIKit
import JetIM

public protocol SBUGroupChannelSettingsViewModelDelegate: SBUBaseChannelSettingsViewModelDelegate {
    /// Called when the current user has left the channel
    func groupChannelSettingsViewModel(
        _ viewModel: SBUGroupChannelSettingsViewModel,
        didLeaveChannel channel: JConversationInfo
    )
}

/// This is a typealias for `SBUGroupChannelSettingsViewModel`. It is deprecated and renamed to `SBUGroupChannelSettingsViewModel`.
@available(*, deprecated, renamed: "SBUGroupChannelSettingsViewModel") // 3.0.0
public typealias SBUChannelSettingsViewModel = SBUGroupChannelSettingsViewModel

/// `SBUGroupChannelSettingsViewModel` is a class that inherits from `SBUBaseChannelSettingsViewModel`.
/// It is used to manage the settings of a group channel.
open class SBUGroupChannelSettingsViewModel: SBUBaseChannelSettingsViewModel {
    // MARK: - Logic properties (Public)
    /// The delegate for the `SBUGroupChannelSettingsViewModel`. This delegate receives callbacks
    /// for events such as when the current user has left the channel.
    public weak var delegate: SBUGroupChannelSettingsViewModelDelegate? {
        get { self.baseDelegate as? SBUGroupChannelSettingsViewModelDelegate }
        set { self.baseDelegate = newValue }
    }
    
    // MARK: - LifeCycle
    /// Initializes a new instance of the `SBUGroupChannelSettingsViewModel` class.
    ///
    /// - Parameters:
    ///   - channel: The base channel. Default value is `nil`.
    ///   - channelURL: The URL of the channel. Default value is `nil`.
    ///   - delegate: The delegate for the `SBUGroupChannelSettingsViewModel`. Default value is `nil`.
    public init(
        channel: JConversationInfo? = nil,
        channelURL: String? = nil,
        delegate: SBUGroupChannelSettingsViewModelDelegate? = nil
    ) {
        super.init()
        
        self.delegate = delegate
        
//        SendbirdChat.addChannelDelegate(
//            self,
//            identifier: "\(SBUConstant.groupChannelDelegateIdentifier).\(self.description)"
//        )
        
        if let channel = channel {
            self.channel = channel
//            self.channelURL = channel.channelURL
        } else if let channelURL = channelURL {
            self.channelURL = channelURL
        }
        //TODO:
//        self.loadChannel(channelURL: self.channelURL)
    }
    
    deinit {
//        SendbirdChat.removeChannelDelegate(
//            forIdentifier: "\(SBUConstant.groupChannelDelegateIdentifier).\(self.description)"
//        )
    }
    
    // MARK: - Channel related
    public override func loadChannel(channelURL: String?) {
        guard let channelURL = channelURL else { return }
//        self.loadChannel(channelURL: channelURL, type: .group)
    }
    
    public override func updateChannel(channelName: String? = nil, coverImage: UIImage? = nil) {
//        let channelParams = GroupChannelUpdateParams()
//
//        channelParams.name = channelName
//
//        if let coverImage = coverImage {
//            channelParams.coverImage = coverImage.jpegData(compressionQuality: 0.5)
//        } else {
//            channelParams.coverURL = self.channel?.coverURL
//        }
//
//        SBUGlobalCustomParams.groupChannelParamsUpdateBuilder?(channelParams)
//
//        self.updateChannel(params: channelParams)
    }
    
    /// Updates the channel with channelParams.
    ///
    /// You can update a channel by setting various properties of ChannelParams.
    /// - Parameters:
    ///   - params: `GroupChannelParams` class object
//    public func updateChannel(params: GroupChannelUpdateParams) {
//        guard let groupChannel = self.channel as? JConversationInfo else { return }
//
//        SBULog.info("[Request] Channel update")
//        self.delegate?.shouldUpdateLoadingState(true)
//
//        groupChannel.update(params: params) { [weak self] channel, error in
//            defer { self?.delegate?.shouldUpdateLoadingState(false) }
//            guard let self = self else { return }
//
//            if let error = error {
//                self.delegate?.didReceiveError(error, isBlocker: false)
//                return
//            } else if let channel = channel {
//                self.channel = channel
//
//                let context = MessageContext(source: .eventChannelChanged, sendingStatus: .succeeded)
//                self.delegate?.baseChannelSettingsViewModel(
//                    self,
//                    didChangeChannel: channel,
//                    withContext: context
//                )
//            }
//        }
//    }
    
    /// Leaves the channel.
    public func leaveChannel() {
        guard let groupChannel = self.channel as? JConversationInfo else { return }
        
        self.delegate?.shouldUpdateLoadingState(true)
        
//        groupChannel.leave { [weak self] error in
//            guard let self = self else { return }
//
//            self.delegate?.shouldUpdateLoadingState(false)
//
//            if let error = error {
//                self.delegate?.didReceiveError(error)
//                return
//            }
//
//            self.channel = nil
//
//            self.delegate?.groupChannelSettingsViewModel(
//                self,
//                didLeaveChannel: groupChannel
//            )
//        }
    }
}

// MARK: GroupChannelDelegate
//extension SBUGroupChannelSettingsViewModel: GroupChannelDelegate {
//    open func channel(_ channel: JConversationInfo, userDidJoin user: JUserInfo) {
//        let context =  MessageContext(source: .eventUserJoined, sendingStatus: .succeeded)
//        self.baseDelegate?.baseChannelSettingsViewModel(
//            self,
//            didChangeChannel: channel,
//            withContext: context
//        )
//    }
//    
//    open func channel(_ channel: JConversationInfo, userDidLeave user: JUserInfo) {
//        let context =  MessageContext(source: .eventUserLeft, sendingStatus: .succeeded)
//        self.baseDelegate?.baseChannelSettingsViewModel(
//            self,
//            didChangeChannel: channel,
//            withContext: context
//        )
//    }
//}