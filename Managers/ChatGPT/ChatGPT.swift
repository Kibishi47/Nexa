//
//  ChatGPT.swift
//  Nexa
//
//  Created by Emmanuel Moulin on 03/01/2025.
//

import Foundation

let chatGPTIP = Bundle.main.object(forInfoDictionaryKey: "CHATGPT_IP") as? String ?? ""

let chatGPTURL = "http://\(chatGPTIP)/api/chatgpt/"
