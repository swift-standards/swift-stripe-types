//
//  Stripe Connect Account Session Types.swift
//  swift-stripe-types
//
//  Created on 2025-01-14.
//

import Foundation
import Stripe_Types_Models
import Stripe_Types_Shared
import Tagged_Primitives

extension Stripe.Connect.Account.Session {
    // https://docs.stripe.com/api/account_sessions/create.md
    public enum Create {}
}

extension Stripe.Connect.Account.Session.Create {
    public struct Request: Codable, Equatable, Sendable {
        public var account: Stripe.Connect.Account.ID
        public var components: Components

        public init(
            account: Stripe.Connect.Account.ID,
            components: Components
        ) {
            self.account = account
            self.components = components
        }

        public struct Components: Codable, Equatable, Sendable {
            public var accountManagement: ComponentConfig?
            public var accountOnboarding: ComponentConfig?
            public var balances: ComponentConfig?
            public var disputesList: ComponentConfig?
            public var documents: ComponentConfig?
            public var financialAccount: ComponentConfig?
            public var financialAccountTransactions: ComponentConfig?
            public var instantPayoutsPromotion: ComponentConfig?
            public var issuingCard: ComponentConfig?
            public var issuingCardsList: ComponentConfig?
            public var notificationBanner: ComponentConfig?
            public var paymentDetails: ComponentConfig?
            public var paymentDisputes: ComponentConfig?
            public var payments: ComponentConfig?
            public var payouts: ComponentConfig?
            public var payoutsList: ComponentConfig?
            public var taxRegistrations: ComponentConfig?
            public var taxSettings: ComponentConfig?

            private enum CodingKeys: String, CodingKey {
                case accountManagement = "account_management"
                case accountOnboarding = "account_onboarding"
                case balances
                case disputesList = "disputes_list"
                case documents
                case financialAccount = "financial_account"
                case financialAccountTransactions = "financial_account_transactions"
                case instantPayoutsPromotion = "instant_payouts_promotion"
                case issuingCard = "issuing_card"
                case issuingCardsList = "issuing_cards_list"
                case notificationBanner = "notification_banner"
                case paymentDetails = "payment_details"
                case paymentDisputes = "payment_disputes"
                case payments
                case payouts
                case payoutsList = "payouts_list"
                case taxRegistrations = "tax_registrations"
                case taxSettings = "tax_settings"
            }

            public init(
                accountManagement: ComponentConfig? = nil,
                accountOnboarding: ComponentConfig? = nil,
                balances: ComponentConfig? = nil,
                disputesList: ComponentConfig? = nil,
                documents: ComponentConfig? = nil,
                financialAccount: ComponentConfig? = nil,
                financialAccountTransactions: ComponentConfig? = nil,
                instantPayoutsPromotion: ComponentConfig? = nil,
                issuingCard: ComponentConfig? = nil,
                issuingCardsList: ComponentConfig? = nil,
                notificationBanner: ComponentConfig? = nil,
                paymentDetails: ComponentConfig? = nil,
                paymentDisputes: ComponentConfig? = nil,
                payments: ComponentConfig? = nil,
                payouts: ComponentConfig? = nil,
                payoutsList: ComponentConfig? = nil,
                taxRegistrations: ComponentConfig? = nil,
                taxSettings: ComponentConfig? = nil
            ) {
                self.accountManagement = accountManagement
                self.accountOnboarding = accountOnboarding
                self.balances = balances
                self.disputesList = disputesList
                self.documents = documents
                self.financialAccount = financialAccount
                self.financialAccountTransactions = financialAccountTransactions
                self.instantPayoutsPromotion = instantPayoutsPromotion
                self.issuingCard = issuingCard
                self.issuingCardsList = issuingCardsList
                self.notificationBanner = notificationBanner
                self.paymentDetails = paymentDetails
                self.paymentDisputes = paymentDisputes
                self.payments = payments
                self.payouts = payouts
                self.payoutsList = payoutsList
                self.taxRegistrations = taxRegistrations
                self.taxSettings = taxSettings
            }

            public struct ComponentConfig: Codable, Equatable, Sendable {
                public var enabled: Bool
                public var features: Features?

                public init(
                    enabled: Bool,
                    features: Features? = nil
                ) {
                    self.enabled = enabled
                    self.features = features
                }

                // Component-specific features based on Stripe API documentation
                public struct Features: Codable, Equatable, Sendable {
                    // Common features across multiple components
                    public var externalAccountCollection: Bool?
                    public var disableStripeUserAuthentication: Bool?

                    // Balances-specific features
                    public var editPayoutSchedule: Bool?
                    public var instantPayouts: Bool?
                    public var standardPayouts: Bool?

                    // Financial account features
                    public var sendMoney: Bool?
                    public var transferBalance: Bool?

                    // Issuing card features
                    public var cardManagement: Bool?
                    public var cardSpendDisputeManagement: Bool?
                    public var cardholderManagement: Bool?
                    public var spendControlManagement: Bool?

                    private enum CodingKeys: String, CodingKey {
                        case externalAccountCollection = "external_account_collection"
                        case disableStripeUserAuthentication = "disable_stripe_user_authentication"
                        case editPayoutSchedule = "edit_payout_schedule"
                        case instantPayouts = "instant_payouts"
                        case standardPayouts = "standard_payouts"
                        case sendMoney = "send_money"
                        case transferBalance = "transfer_balance"
                        case cardManagement = "card_management"
                        case cardSpendDisputeManagement = "card_spend_dispute_management"
                        case cardholderManagement = "cardholder_management"
                        case spendControlManagement = "spend_control_management"
                    }

                    public init(
                        externalAccountCollection: Bool? = nil,
                        disableStripeUserAuthentication: Bool? = nil,
                        editPayoutSchedule: Bool? = nil,
                        instantPayouts: Bool? = nil,
                        standardPayouts: Bool? = nil,
                        sendMoney: Bool? = nil,
                        transferBalance: Bool? = nil,
                        cardManagement: Bool? = nil,
                        cardSpendDisputeManagement: Bool? = nil,
                        cardholderManagement: Bool? = nil,
                        spendControlManagement: Bool? = nil
                    ) {
                        self.externalAccountCollection = externalAccountCollection
                        self.disableStripeUserAuthentication = disableStripeUserAuthentication
                        self.editPayoutSchedule = editPayoutSchedule
                        self.instantPayouts = instantPayouts
                        self.standardPayouts = standardPayouts
                        self.sendMoney = sendMoney
                        self.transferBalance = transferBalance
                        self.cardManagement = cardManagement
                        self.cardSpendDisputeManagement = cardSpendDisputeManagement
                        self.cardholderManagement = cardholderManagement
                        self.spendControlManagement = spendControlManagement
                    }
                }
            }
        }
    }
}
