//
//  SBUUtils.swift
//  SendbirdUIKit
//
//  Created by Tez Park on 26/02/2020.
//  Copyright © 2020 Sendbird, Inc. All rights reserved.
//

import UIKit
import MobileCoreServices
import JuggleIM

private let kDefaultGroupChannelName = "Group Channel"
private let kDefaultOpenChannelName = "Open Channel"

/// `SBUUtils` is a utility class that provides various helper methods for Sendbird UIKit.
public class SBUUtils {
    
    /// This function gets the message file type of the file message.
    /// - Parameter JMessage: `JMessage` object
    /// - Returns: `SBUMessageFileType`
    public static func getMediaType(by message: JMessage) -> SBUMessageFileType {
        if message.content is JImageMessage {
            return .image
        } else if message.content is JVoiceMessage {
            return .voice
        } else if message.content is JVideoMessage {
            return .video
        } else {
            return .etc
        }
    }
    
    /// This function gets the message file type string as the type.
    /// - Parameter type: File type string
    /// - Returns: `SBUMessageFileType`
    public static func getFileType(by type: String) -> SBUMessageFileType {
        let type = type.lowercased()
        
        if type.hasPrefix("image") {
            if type.contains("svg") { return .etc } else { return .image }
        }
        if type.hasPrefix("video") { return .video }
        if type.hasPrefix("audio") {
            if let parameterType = self.getFileTypeParameter(by: type),
               parameterType.hasPrefix("voice") {
                return .voice
            }
            return .audio
        }
        if type.hasPrefix("pdf") { return .pdf }
        
        return .etc
    }
    
    static func getFileTypeParameter(by type: String) -> String? {
        // e,g. audio/m4a;sub_type=voice
        let parameter = type.components(separatedBy: ";")
        if parameter.count > 0,
           let type = parameter.last?.components(separatedBy: "=").last {
            return type
        }
        return nil
    }
    
    /// A function that returns a SBUFileType for a String file type.
    /// - Parameter type: File type string
    /// - Returns: `SBUFileType`
    /// - Since: 3.10.0
    @available(*, deprecated, renamed: "getFileTypePreviewString(by:)") // 3.16.0
    public static func getFileTypeString(by fileType: String) -> String {
        self.getFileTypePreviewString(by: fileType)
    }
    
    /// A function that returns a file type string for preview of channel cell of channel list.
    /// - Parameter fileType: File type string
    /// - Returns: File type string for preview
    ///
    /// - Since: 3.16.0
    public static func getFileTypePreviewString(by fileType: String) -> String {
        let type = fileType.lowercased()
        
        if type.hasPrefix("image") {
            if type.contains("svg") {
                return SBUStringSet.GroupChannel.Preview.file
            } else if type.contains("jpeg") || type.contains("png") {
                return SBUStringSet.GroupChannel.Preview.photo
            } else if type.contains("gif") {
                return SBUStringSet.GroupChannel.Preview.gif
            }
        }
        
        if type.hasPrefix("video") { return SBUStringSet.GroupChannel.Preview.video }
        
        if type.hasPrefix("audio") {
            if let parameterType = self.getFileTypeParameter(by: type),
               parameterType.hasPrefix("voice") {
                return SBUStringSet.GroupChannel.Preview.voice
            }
            return SBUStringSet.GroupChannel.Preview.audio
        }
        
        return SBUStringSet.GroupChannel.Preview.file
    }
    
    /// This is a function that creates a channel name.
    ///
    ///  If the channel name is not entered after creating the channel or channel name is empty,
    ///  the channel name is generated by combining the nicknames of the members in the channel.
    ///
    /// - Parameter channel: `GroupChannel` object
    /// - Returns: Generated channel name
    public static func generateChannelName(channel: JConversationInfo) -> String {
//        guard !SBUUtils.isValid(channelName: channel.name) else {
//            return channel.name
//        }
//        let members = channel.members as [User]
//        let users = members
//            .sbu_convertUserList()
//            .filter { $0.userId != SBUGlobals.currentUser?.userId }
//
//        guard !users.isEmpty else { return SBUStringSet.Channel_Name_No_Members }
//        let userNicknames = users.sbu_getUserNicknames()
//        let channelName = userNicknames.joined(separator: ", ")

//        return channelName
        return ""
    }
    
    /// This function gets the MIME type from the URL.
    /// - Parameter url: url
    /// - Returns: MIME type string
    public static func getMimeType(url: URL) -> String? {
        let lastPathComponent = url.lastPathComponent
        let ext = (lastPathComponent as NSString).pathExtension
        guard let UTI = UTTypeCreatePreferredIdentifierForTag(
            kUTTagClassFilenameExtension, ext as CFString, nil)?
            .takeRetainedValue() else { return nil }
        guard let retainedValueMimeType = UTTypeCopyPreferredTagWithClass(
            UTI, kUTTagClassMIMEType)?
            .takeRetainedValue() else { return nil }
        let mimeType = retainedValueMimeType as String
        
        return mimeType
    }
    
    /// This function gets the receipt state of the message on the channel.
    /// - Parameters:
    ///   - channel: `GroupChannel` object
    ///   - message: `JMessage` object
    /// - Returns: `SBUMessageReceiptState`
    @available(*, deprecated, renamed: "getReceiptState(of:in:)") // 2.0.5
    public static func getReceiptState(channel: JConversationInfo,
                                       message: JMessage) -> SBUMessageReceiptState {
        Self.getReceiptState(of: message, in: channel)
    }
    
    /// This function gets the receipt state of the message on the channel.
    /// Will return nil for `Super Group Channel` or `Broadcast Channel` which  doesn't support receipts.
    ///
    /// - Important: Please set returned value to `SBUMessageReceiptState.notUsed`.
    ///
    /// - Parameters:
    ///   - channel: `GroupChannel` object
    ///   - message: `JMessage` object
    /// - Returns: `SBUMessageReceiptState`, or nil if the channel doesn't support receipts.
    @available(*, unavailable, message: "It returns nil when th channel is super group channel or broadcast channel. Please set the value to `SBUMessageReceitState.notUsed`.", renamed: "getReceiptState(of:in:)") // 2.2.0
    public static func getReceiptStateIfExists(for channel: JConversationInfo,
                                               message: JMessage) -> SBUMessageReceiptState? {
        let receiptState = Self.getReceiptState(of: message, in: channel)
        return receiptState == .notUsed ? nil : receiptState
    }
    
    /// This function gets the receipt state of the message on the channel.
    ///
    /// - Parameters:
    ///   - channel: `GroupChannel` object
    ///   - message: `JMessage` object
    ///
    /// - Returns: `SBUMessageReceiptState`. , It returns `.notUsed` when the channel is *super group channel* or *broadcast channel* which doesn't support receipts.
    ///
    /// - Since: 2.2.0
    public static func getReceiptState(of message: JMessage, in channel: JConversationInfo) -> SBUMessageReceiptState {
//        if channel.isSuper || channel.isBroadcast {
//            return .notUsed
//        }
//        
//        let didReadAll = channel.getUnreadMemberCount(message) == 0
//        let didDeliverAll = channel.getUndeliveredMemberCount(message) == 0
//        
//        if didReadAll {
//            return .read
//        } else if didDeliverAll {
//            return .delivered
//        } else {
//            return .none
//        }
        return .none
    }
    
    /// This function checks the validity of coverURL.
    /// - Parameter coverURL: CoverURL string
    /// - Returns: If corverURL is valid, return `true`.
    public static func isValid(coverURL: String) -> Bool {
        guard !coverURL.hasPrefix(SBUConstant.coverImagePrefix),
            !coverURL.isEmpty  else {
                return false
        }
        
        return true
    }
    
    /// This function checks the validity of channel name.
    /// - Parameter channelName: Channel name string
    /// - Parameter type: Channel type
    /// - Returns: If channel name is valid, return `true`.
    public static func isValid(channelName: String) -> Bool {
        return true
    }
    
    /// This function generates an empty title for row edit action based on the provided size.
    /// - Parameter size: The size for which the empty title is generated.
    /// - Returns: An empty title string for row edit action.
    public static func emptyTitleForRowEditAction(for size: CGSize) -> String {
        let placeholderSymbol = "\u{200A}"
        let minimalActionWidth: CGFloat = 30
        let shiftFactor: CGFloat = 1.1

        let flt_max = CGFloat.greatestFiniteMagnitude
        let maxSize = CGSize(width: flt_max, height: flt_max)
        let attributes = [
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: UIFont.systemFontSize)
        ]
        let boundingRect = placeholderSymbol.boundingRect(
            with: maxSize,
            options: .usesLineFragmentOrigin,
            attributes: attributes,
            context: nil
        )
        
        var usefulWidth = size.width - minimalActionWidth
        usefulWidth = usefulWidth < 0 ? 0 : usefulWidth
        let countOfSymbols = Int(floor(usefulWidth * shiftFactor / boundingRect.width))
        return String(repeating: placeholderSymbol, count: countOfSymbols)
    }
}

extension SBUUtils {

    // To dismiss presented views which should be dismissed on view disappear.
    // - `SBUEmojiListViewController`
    // - `SBUReactionsViewController`
    // - `SBUMenuSheetViewController`
    static func dismissPresentedOnDisappear(presentedViewController: UIViewController?) {
        guard let presented = presentedViewController else { return }
        
        if presented is SBUMenuSheetViewController {
            presented.dismiss(animated: false, completion: nil)
        }
    }
    
    static func findIndex(of message: JMessage, in messageList: [JMessage]) -> Int? {
        return messageList.firstIndex(where: { $0.clientMsgNo == message.clientMsgNo })
    }
    
    static func contains(clientMsgNo: Int64, in messageList: [JMessage]) -> Bool {
        return messageList.contains(where: { $0.clientMsgNo == clientMsgNo })
    }
    
    static func findIndex(ofConversationInfo conversationInfo: JConversationInfo, in conversationInfoList: [JConversationInfo]) -> Int? {
        return conversationInfoList.firstIndex(where: { $0.conversation.isEqual(conversationInfo.conversation) })
    }
}

// MARK: - TIME
extension SBUUtils {
    static func convertToPlayTime(_ time: TimeInterval) -> String {
        // time -> ms | return format -> 00:00
        let min = Int(time / 1000 / 60)
        let sec = Int(time / 1000) % 60
        let strTime = String(format: "%02d:%02d", min, sec)
        return strTime
    }

}