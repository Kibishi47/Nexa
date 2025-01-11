//
//  Supabase.swift
//  Nexa
//
//  Created by Emmanuel Moulin on 11/12/2024.
//

import Foundation
import Supabase

let supabaseDomain = Bundle.main.object(forInfoDictionaryKey: "SUPABASE_DOMAIN") as? String ?? ""
let supabaseKey = Bundle.main.object(forInfoDictionaryKey: "SUPABASE_ANON_KEY") as? String ?? ""

let supabaseClient = SupabaseClient(
    supabaseURL: URL(string: "https://\(supabaseDomain).supabase.co")!,
    supabaseKey: supabaseKey
)
