//
//  Model.swift
//  Mobius Coding test
//
//  Created by Adaps on 09/12/20.
//  Copyright © 2020 Task. All rights reserved.
//

import Foundation

// MARK: - BonosCouponModel

struct BonosCouponModel: Codable {
    let id: String
    let validFrom, validUntil: String?
    let isActive: Bool
    let isDeleted: Bool?
    let tags: Tags
    let createdAt, lastUpdatedAt, code: String
    let bonusImageFront, bonusImageBack: String
    let userRedeemLimit, userLimit: Int
    let tabType, ribbonMsg: String
    let isBonusBoosterEnabled: Bool
    let wagerBonusExpiry, wagerToReleaseRatioNumerator, wagerToReleaseRatioDenominator: Int
    let slabs: [Slab]
    let userSegmentationType: String
    let eligibilityUserLevels: [Int]
    let eligibilityUserSegments: [String]
    let visibilityUserLevels: [Int]
    let visibilityUserSegments: [String]
    let daysSinceLastPurchaseMin: Int
    let cls, campaign: String
    let bonusBooster: String?

    enum CodingKeys: String, CodingKey {
        case id
        case validFrom = "valid_from"
        case validUntil = "valid_until"
        case isActive = "is_active"
        case isDeleted = "is_deleted"
        case tags
        case createdAt = "created_at"
        case lastUpdatedAt = "last_updated_at"
        case code
        case bonusImageFront = "bonus_image_front"
        case bonusImageBack = "bonus_image_back"
        case userRedeemLimit = "user_redeem_limit"
        case userLimit = "user_limit"
        case tabType = "tab_type"
        case ribbonMsg = "ribbon_msg"
        case isBonusBoosterEnabled = "is_bonus_booster_enabled"
        case wagerBonusExpiry = "wager_bonus_expiry"
        case wagerToReleaseRatioNumerator = "wager_to_release_ratio_numerator"
        case wagerToReleaseRatioDenominator = "wager_to_release_ratio_denominator"
        case slabs
        case userSegmentationType = "user_segmentation_type"
        case eligibilityUserLevels = "eligibility_user_levels"
        case eligibilityUserSegments = "eligibility_user_segments"
        case visibilityUserLevels = "visibility_user_levels"
        case visibilityUserSegments = "visibility_user_segments"
        case daysSinceLastPurchaseMin = "days_since_last_purchase_min"
        case cls = "_cls"
        case campaign
        case bonusBooster = "bonus_booster"
    }
}

// MARK: - Slab
struct Slab: Codable {
    let name: Name
    let num, min, max, wageredPercent: Int
    let wageredMax, otcPercent, otcMax: Int

    enum CodingKeys: String, CodingKey {
        case name, num, min, max
        case wageredPercent = "wagered_percent"
        case wageredMax = "wagered_max"
        case otcPercent = "otc_percent"
        case otcMax = "otc_max"
    }
}

enum Name: String, Codable {
    case slab1 = "Slab 1"
    case slab2 = "Slab 2"
    case slab3 = "Slab 3"
}

// MARK: - Tags
struct Tags: Codable {
}

typealias BonusCouponsList = [BonosCouponModel]
