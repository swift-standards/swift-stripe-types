//
//  PaymentMethodConfiguration.swift
//  Stripe Types Models
//
//  Created for swift-stripe-types on 14/01/2025.
//

import Foundation
import Stripe_Types_Shared
import Tagged_Primitives

// https://docs.stripe.com/api/payment_method_configurations/object.md

extension Stripe.PaymentMethodConfigurations {
    /// The [Payment Method Configuration Object](https://docs.stripe.com/api/payment_method_configurations/object).
    public struct Configuration: Codable, Hashable, Sendable {
        public typealias ID = Tagged<Self, String>

        /// Unique identifier for the object.
        public var id: ID?
        /// String representing the object's type. Objects of the same type share the same value.
        public var object: String
        /// Whether the configuration can be used for new payments.
        public var active: Bool
        /// Whether this configuration is the default. Child configurations effectively inherit the display preferences of default configurations.
        public var isDefault: Bool
        /// Has the value true if the object exists in live mode or the value false if the object exists in test mode.
        public var livemode: Bool
        /// The configuration's name.
        public var name: String
        /// ID of the Connect application that created the configuration.
        public var application: String?
        /// Parent configuration for configurations of type child. The child configuration inherits from the parent configuration.
        public var parent: String?

        // Payment method specific configurations
        public var acssDebit: PaymentMethodConfig?
        public var affirm: PaymentMethodConfig?
        public var afterpayClearpay: PaymentMethodConfig?
        public var alipay: PaymentMethodConfig?
        public var alma: PaymentMethodConfig?
        public var amazonPay: PaymentMethodConfig?
        public var applePay: PaymentMethodConfig?
        public var applePayLater: PaymentMethodConfig?
        public var auBecsDebit: PaymentMethodConfig?
        public var bacsDebit: PaymentMethodConfig?
        public var bancontact: PaymentMethodConfig?
        public var billie: PaymentMethodConfig?
        public var blik: PaymentMethodConfig?
        public var boleto: PaymentMethodConfig?
        public var card: PaymentMethodConfig?
        public var cartesBancaires: PaymentMethodConfig?
        public var cashapp: PaymentMethodConfig?
        public var customerBalance: PaymentMethodConfig?
        public var eps: PaymentMethodConfig?
        public var fpx: PaymentMethodConfig?
        public var giropay: PaymentMethodConfig?
        public var googlePay: PaymentMethodConfig?
        public var grabpay: PaymentMethodConfig?
        public var ideal: PaymentMethodConfig?
        public var jcb: PaymentMethodConfig?
        public var kakaoPay: PaymentMethodConfig?
        public var klarna: PaymentMethodConfig?
        public var konbini: PaymentMethodConfig?
        public var krCard: PaymentMethodConfig?
        public var link: PaymentMethodConfig?
        public var mobilepay: PaymentMethodConfig?
        public var multibanco: PaymentMethodConfig?
        public var naverPay: PaymentMethodConfig?
        public var nzBankAccount: PaymentMethodConfig?
        public var oxxo: PaymentMethodConfig?
        public var p24: PaymentMethodConfig?
        public var payByBank: PaymentMethodConfig?
        public var payco: PaymentMethodConfig?
        public var paynow: PaymentMethodConfig?
        public var paypal: PaymentMethodConfig?
        public var pix: PaymentMethodConfig?
        public var promptpay: PaymentMethodConfig?
        public var revolutPay: PaymentMethodConfig?
        public var samsungPay: PaymentMethodConfig?
        public var satispay: PaymentMethodConfig?
        public var sepaDebit: PaymentMethodConfig?
        public var sofort: PaymentMethodConfig?
        public var swish: PaymentMethodConfig?
        public var twint: PaymentMethodConfig?
        public var usBankAccount: PaymentMethodConfig?
        public var wechatPay: PaymentMethodConfig?
        public var zip: PaymentMethodConfig?

        private enum CodingKeys: String, CodingKey {
            case id
            case object
            case active
            case isDefault = "is_default"
            case livemode
            case name
            case application
            case parent
            case acssDebit = "acss_debit"
            case affirm
            case afterpayClearpay = "afterpay_clearpay"
            case alipay
            case alma
            case amazonPay = "amazon_pay"
            case applePay = "apple_pay"
            case applePayLater = "apple_pay_later"
            case auBecsDebit = "au_becs_debit"
            case bacsDebit = "bacs_debit"
            case bancontact
            case billie
            case blik
            case boleto
            case card
            case cartesBancaires = "cartes_bancaires"
            case cashapp
            case customerBalance = "customer_balance"
            case eps
            case fpx
            case giropay
            case googlePay = "google_pay"
            case grabpay
            case ideal
            case jcb
            case kakaoPay = "kakao_pay"
            case klarna
            case konbini
            case krCard = "kr_card"
            case link
            case mobilepay
            case multibanco
            case naverPay = "naver_pay"
            case nzBankAccount = "nz_bank_account"
            case oxxo
            case p24
            case payByBank = "pay_by_bank"
            case payco
            case paynow
            case paypal
            case pix
            case promptpay
            case revolutPay = "revolut_pay"
            case samsungPay = "samsung_pay"
            case satispay
            case sepaDebit = "sepa_debit"
            case sofort
            case swish
            case twint
            case usBankAccount = "us_bank_account"
            case wechatPay = "wechat_pay"
            case zip
        }

        public init(
            id: ID? = nil,
            object: String,
            active: Bool,
            isDefault: Bool,
            livemode: Bool,
            name: String,
            application: String? = nil,
            parent: String? = nil,
            acssDebit: PaymentMethodConfig? = nil,
            affirm: PaymentMethodConfig? = nil,
            afterpayClearpay: PaymentMethodConfig? = nil,
            alipay: PaymentMethodConfig? = nil,
            alma: PaymentMethodConfig? = nil,
            amazonPay: PaymentMethodConfig? = nil,
            applePay: PaymentMethodConfig? = nil,
            applePayLater: PaymentMethodConfig? = nil,
            auBecsDebit: PaymentMethodConfig? = nil,
            bacsDebit: PaymentMethodConfig? = nil,
            bancontact: PaymentMethodConfig? = nil,
            billie: PaymentMethodConfig? = nil,
            blik: PaymentMethodConfig? = nil,
            boleto: PaymentMethodConfig? = nil,
            card: PaymentMethodConfig? = nil,
            cartesBancaires: PaymentMethodConfig? = nil,
            cashapp: PaymentMethodConfig? = nil,
            customerBalance: PaymentMethodConfig? = nil,
            eps: PaymentMethodConfig? = nil,
            fpx: PaymentMethodConfig? = nil,
            giropay: PaymentMethodConfig? = nil,
            googlePay: PaymentMethodConfig? = nil,
            grabpay: PaymentMethodConfig? = nil,
            ideal: PaymentMethodConfig? = nil,
            jcb: PaymentMethodConfig? = nil,
            kakaoPay: PaymentMethodConfig? = nil,
            klarna: PaymentMethodConfig? = nil,
            konbini: PaymentMethodConfig? = nil,
            krCard: PaymentMethodConfig? = nil,
            link: PaymentMethodConfig? = nil,
            mobilepay: PaymentMethodConfig? = nil,
            multibanco: PaymentMethodConfig? = nil,
            naverPay: PaymentMethodConfig? = nil,
            nzBankAccount: PaymentMethodConfig? = nil,
            oxxo: PaymentMethodConfig? = nil,
            p24: PaymentMethodConfig? = nil,
            payByBank: PaymentMethodConfig? = nil,
            payco: PaymentMethodConfig? = nil,
            paynow: PaymentMethodConfig? = nil,
            paypal: PaymentMethodConfig? = nil,
            pix: PaymentMethodConfig? = nil,
            promptpay: PaymentMethodConfig? = nil,
            revolutPay: PaymentMethodConfig? = nil,
            samsungPay: PaymentMethodConfig? = nil,
            satispay: PaymentMethodConfig? = nil,
            sepaDebit: PaymentMethodConfig? = nil,
            sofort: PaymentMethodConfig? = nil,
            swish: PaymentMethodConfig? = nil,
            twint: PaymentMethodConfig? = nil,
            usBankAccount: PaymentMethodConfig? = nil,
            wechatPay: PaymentMethodConfig? = nil,
            zip: PaymentMethodConfig? = nil
        ) {
            self.id = id
            self.object = object
            self.active = active
            self.isDefault = isDefault
            self.livemode = livemode
            self.name = name
            self.application = application
            self.parent = parent
            self.acssDebit = acssDebit
            self.affirm = affirm
            self.afterpayClearpay = afterpayClearpay
            self.alipay = alipay
            self.alma = alma
            self.amazonPay = amazonPay
            self.applePay = applePay
            self.applePayLater = applePayLater
            self.auBecsDebit = auBecsDebit
            self.bacsDebit = bacsDebit
            self.bancontact = bancontact
            self.billie = billie
            self.blik = blik
            self.boleto = boleto
            self.card = card
            self.cartesBancaires = cartesBancaires
            self.cashapp = cashapp
            self.customerBalance = customerBalance
            self.eps = eps
            self.fpx = fpx
            self.giropay = giropay
            self.googlePay = googlePay
            self.grabpay = grabpay
            self.ideal = ideal
            self.jcb = jcb
            self.kakaoPay = kakaoPay
            self.klarna = klarna
            self.konbini = konbini
            self.krCard = krCard
            self.link = link
            self.mobilepay = mobilepay
            self.multibanco = multibanco
            self.naverPay = naverPay
            self.nzBankAccount = nzBankAccount
            self.oxxo = oxxo
            self.p24 = p24
            self.payByBank = payByBank
            self.payco = payco
            self.paynow = paynow
            self.paypal = paypal
            self.pix = pix
            self.promptpay = promptpay
            self.revolutPay = revolutPay
            self.samsungPay = samsungPay
            self.satispay = satispay
            self.sepaDebit = sepaDebit
            self.sofort = sofort
            self.swish = swish
            self.twint = twint
            self.usBankAccount = usBankAccount
            self.wechatPay = wechatPay
            self.zip = zip
        }
    }
}

// MARK: - PaymentMethodConfig
extension Stripe.PaymentMethodConfigurations {
    /// Configuration for a specific payment method.
    public struct PaymentMethodConfig: Codable, Hashable, Sendable {
        /// Display preference for this payment method.
        public var displayPreference: DisplayPreference?

        private enum CodingKeys: String, CodingKey {
            case displayPreference = "display_preference"
        }

        public init(displayPreference: DisplayPreference? = nil) {
            self.displayPreference = displayPreference
        }
    }

    /// Display preference configuration.
    public struct DisplayPreference: Codable, Hashable, Sendable {
        /// The display preference value.
        public var preference: Preference

        public init(preference: Preference) {
            self.preference = preference
        }
    }

    /// Display preference values.
    public enum Preference: String, Codable, CaseIterable, Sendable {
        /// Don't display the payment method.
        case none = "none"
        /// Payment method is disabled.
        case off = "off"
        /// Payment method is enabled.
        case on = "on"
    }
}
