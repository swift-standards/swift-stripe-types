//
//  Stripe Connect Accounts Types Accounts.swift
//  swift-stripe-types
//
//  Created by coenttb on 2025-01-14.
//

import Foundation
import Stripe_Types_Models
import Stripe_Types_Shared
import Tagged_Primitives

extension Stripe.Connect.Accounts {
    // https://docs.stripe.com/api/accounts/create.md
    public enum Create {}
}

extension Stripe.Connect.Accounts.Create {
    public struct Request: Codable, Equatable, Sendable {
        public var businessType: Stripe.Connect.Account.BusinessType?
        public var country: String?
        public var email: String?
        public var type: Stripe.Connect.Account.`Type`?
        public var company: CompanyParam?
        public var individual: IndividualParam?
        public var metadata: [String: String]?
        public var tosAcceptance: TOSAcceptanceParam?
        public var businessProfile: BusinessProfileParam?
        public var capabilities: CapabilitiesParam?
        public var documents: DocumentsParam?
        public var externalAccount: String?
        public var settings: SettingsParam?
        public var controller: ControllerParam?

        private enum CodingKeys: String, CodingKey {
            case businessType = "business_type"
            case country
            case email
            case type
            case company
            case individual
            case metadata
            case tosAcceptance = "tos_acceptance"
            case businessProfile = "business_profile"
            case capabilities
            case documents
            case externalAccount = "external_account"
            case settings
            case controller
        }

        public init(
            businessType: Stripe.Connect.Account.BusinessType? = nil,
            country: String? = nil,
            email: String? = nil,
            type: Stripe.Connect.Account.`Type`? = nil,
            company: CompanyParam? = nil,
            individual: IndividualParam? = nil,
            metadata: [String: String]? = nil,
            tosAcceptance: TOSAcceptanceParam? = nil,
            businessProfile: BusinessProfileParam? = nil,
            capabilities: CapabilitiesParam? = nil,
            documents: DocumentsParam? = nil,
            externalAccount: String? = nil,
            settings: SettingsParam? = nil,
            controller: ControllerParam? = nil
        ) {
            self.businessType = businessType
            self.country = country
            self.email = email
            self.type = type
            self.company = company
            self.individual = individual
            self.metadata = metadata
            self.tosAcceptance = tosAcceptance
            self.businessProfile = businessProfile
            self.capabilities = capabilities
            self.documents = documents
            self.externalAccount = externalAccount
            self.settings = settings
            self.controller = controller
        }

        public struct CompanyParam: Codable, Equatable, Sendable {
            public var address: Address?
            public var addressKana: AddressKana?
            public var addressKanji: AddressKanji?
            public var directorsProvided: Bool?
            public var executivesProvided: Bool?
            public var exportLicenseId: String?
            public var exportPurposeCode: String?
            public var name: String?
            public var nameKana: String?
            public var nameKanji: String?
            public var ownersProvided: Bool?
            public var ownershipDeclaration: OwnershipDeclarationParam?
            public var phone: String?
            public var registrationNumber: String?
            public var structure: String?
            public var taxId: String?
            public var taxIdRegistrar: String?
            public var vatId: String?
            public var verification: VerificationParam?

            private enum CodingKeys: String, CodingKey {
                case address
                case addressKana = "address_kana"
                case addressKanji = "address_kanji"
                case directorsProvided = "directors_provided"
                case executivesProvided = "executives_provided"
                case exportLicenseId = "export_license_id"
                case exportPurposeCode = "export_purpose_code"
                case name
                case nameKana = "name_kana"
                case nameKanji = "name_kanji"
                case ownersProvided = "owners_provided"
                case ownershipDeclaration = "ownership_declaration"
                case phone
                case registrationNumber = "registration_number"
                case structure
                case taxId = "tax_id"
                case taxIdRegistrar = "tax_id_registrar"
                case vatId = "vat_id"
                case verification
            }

            public struct OwnershipDeclarationParam: Codable, Equatable, Sendable {
                public var date: Date?
                public var ip: String?
                public var userAgent: String?

                private enum CodingKeys: String, CodingKey {
                    case date
                    case ip
                    case userAgent = "user_agent"
                }
            }

            public struct VerificationParam: Codable, Equatable, Sendable {
                public var document: DocumentParam?

                public struct DocumentParam: Codable, Equatable, Sendable {
                    public var back: String?
                    public var front: String?
                }
            }
        }

        public struct IndividualParam: Codable, Equatable, Sendable {
            public var address: Address?
            public var addressKana: AddressKana?
            public var addressKanji: AddressKanji?
            public var dob: DOBParam?
            public var email: String?
            public var firstName: String?
            public var firstNameKana: String?
            public var firstNameKanji: String?
            public var fullNameAliases: [String]?
            public var gender: String?
            public var idNumber: String?
            public var idNumberSecondary: String?
            public var lastName: String?
            public var lastNameKana: String?
            public var lastNameKanji: String?
            public var maidenName: String?
            public var metadata: [String: String]?
            public var nationality: String?
            public var phone: String?
            public var politicalExposure: String?
            public var registeredAddress: Address?
            public var ssnLast4: String?
            public var verification: VerificationParam?

            private enum CodingKeys: String, CodingKey {
                case address
                case addressKana = "address_kana"
                case addressKanji = "address_kanji"
                case dob
                case email
                case firstName = "first_name"
                case firstNameKana = "first_name_kana"
                case firstNameKanji = "first_name_kanji"
                case fullNameAliases = "full_name_aliases"
                case gender
                case idNumber = "id_number"
                case idNumberSecondary = "id_number_secondary"
                case lastName = "last_name"
                case lastNameKana = "last_name_kana"
                case lastNameKanji = "last_name_kanji"
                case maidenName = "maiden_name"
                case metadata
                case nationality
                case phone
                case politicalExposure = "political_exposure"
                case registeredAddress = "registered_address"
                case ssnLast4 = "ssn_last_4"
                case verification
            }

            public struct DOBParam: Codable, Equatable, Sendable {
                public var day: Int?
                public var month: Int?
                public var year: Int?
            }

            public struct VerificationParam: Codable, Equatable, Sendable {
                public var additionalDocument: DocumentParam?
                public var document: DocumentParam?

                private enum CodingKeys: String, CodingKey {
                    case additionalDocument = "additional_document"
                    case document
                }

                public struct DocumentParam: Codable, Equatable, Sendable {
                    public var back: String?
                    public var front: String?
                }
            }
        }

        public struct TOSAcceptanceParam: Codable, Equatable, Sendable {
            public var date: Date?
            public var ip: String?
            public var userAgent: String?

            private enum CodingKeys: String, CodingKey {
                case date
                case ip
                case userAgent = "user_agent"
            }
        }

        public struct BusinessProfileParam: Codable, Equatable, Sendable {
            public var annualRevenue: AnnualRevenueParam?
            public var estimatedWorkerCount: Int?
            public var mcc: String?
            public var monthlyEstimatedRevenue: MonthlyEstimatedRevenueParam?
            public var name: String?
            public var productDescription: String?
            public var supportAddress: Address?
            public var supportEmail: String?
            public var supportPhone: String?
            public var supportUrl: String?
            public var url: String?

            private enum CodingKeys: String, CodingKey {
                case annualRevenue = "annual_revenue"
                case estimatedWorkerCount = "estimated_worker_count"
                case mcc
                case monthlyEstimatedRevenue = "monthly_estimated_revenue"
                case name
                case productDescription = "product_description"
                case supportAddress = "support_address"
                case supportEmail = "support_email"
                case supportPhone = "support_phone"
                case supportUrl = "support_url"
                case url
            }

            public struct AnnualRevenueParam: Codable, Equatable, Sendable {
                public var amount: Int?
                public var currency: Stripe.Currency?
                public var fiscalYearEnd: String?

                private enum CodingKeys: String, CodingKey {
                    case amount
                    case currency
                    case fiscalYearEnd = "fiscal_year_end"
                }
            }

            public struct MonthlyEstimatedRevenueParam: Codable, Equatable, Sendable {
                public var amount: Int?
                public var currency: Stripe.Currency?
            }
        }

        public struct CapabilitiesParam: Codable, Equatable, Sendable {
            public var acssDebitPayments: CapabilityParam?
            public var affirmPayments: CapabilityParam?
            public var afterpayClearpayPayments: CapabilityParam?
            public var amazonPayPayments: CapabilityParam?
            public var auBecsDebitPayments: CapabilityParam?
            public var bacsDebitPayments: CapabilityParam?
            public var bancontactPayments: CapabilityParam?
            public var bankTransferPayments: CapabilityParam?
            public var blikPayments: CapabilityParam?
            public var boleto_payments: CapabilityParam?
            public var cardIssuing: CapabilityParam?
            public var cardPayments: CapabilityParam?
            public var cartesBancairesPayments: CapabilityParam?
            public var cashappPayments: CapabilityParam?
            public var epsPayments: CapabilityParam?
            public var fpxPayments: CapabilityParam?
            public var gbBankTransferPayments: CapabilityParam?
            public var giropayPayments: CapabilityParam?
            public var grabpayPayments: CapabilityParam?
            public var idealPayments: CapabilityParam?
            public var indiaInternationalPayments: CapabilityParam?
            public var jcbPayments: CapabilityParam?
            public var jpBankTransferPayments: CapabilityParam?
            public var klarnaPayments: CapabilityParam?
            public var konbiniPayments: CapabilityParam?
            public var linkPayments: CapabilityParam?
            public var mobilepayPayments: CapabilityParam?
            public var multibanco_payments: CapabilityParam?
            public var mxBankTransferPayments: CapabilityParam?
            public var oxxoPayments: CapabilityParam?
            public var p24Payments: CapabilityParam?
            public var paynowPayments: CapabilityParam?
            public var promptpayPayments: CapabilityParam?
            public var revolutPayPayments: CapabilityParam?
            public var sepaDebitPayments: CapabilityParam?
            public var sofortPayments: CapabilityParam?
            public var swishPayments: CapabilityParam?
            public var taxReportingUs1099K: CapabilityParam?
            public var taxReportingUs1099Misc: CapabilityParam?
            public var transfers: CapabilityParam?
            public var treasury: CapabilityParam?
            public var twintPayments: CapabilityParam?
            public var usBankAccountAchPayments: CapabilityParam?
            public var usBankTransferPayments: CapabilityParam?
            public var zipPayments: CapabilityParam?

            private enum CodingKeys: String, CodingKey {
                case acssDebitPayments = "acss_debit_payments"
                case affirmPayments = "affirm_payments"
                case afterpayClearpayPayments = "afterpay_clearpay_payments"
                case amazonPayPayments = "amazon_pay_payments"
                case auBecsDebitPayments = "au_becs_debit_payments"
                case bacsDebitPayments = "bacs_debit_payments"
                case bancontactPayments = "bancontact_payments"
                case bankTransferPayments = "bank_transfer_payments"
                case blikPayments = "blik_payments"
                case boleto_payments
                case cardIssuing = "card_issuing"
                case cardPayments = "card_payments"
                case cartesBancairesPayments = "cartes_bancaires_payments"
                case cashappPayments = "cashapp_payments"
                case epsPayments = "eps_payments"
                case fpxPayments = "fpx_payments"
                case gbBankTransferPayments = "gb_bank_transfer_payments"
                case giropayPayments = "giropay_payments"
                case grabpayPayments = "grabpay_payments"
                case idealPayments = "ideal_payments"
                case indiaInternationalPayments = "india_international_payments"
                case jcbPayments = "jcb_payments"
                case jpBankTransferPayments = "jp_bank_transfer_payments"
                case klarnaPayments = "klarna_payments"
                case konbiniPayments = "konbini_payments"
                case linkPayments = "link_payments"
                case mobilepayPayments = "mobilepay_payments"
                case multibanco_payments
                case mxBankTransferPayments = "mx_bank_transfer_payments"
                case oxxoPayments = "oxxo_payments"
                case p24Payments = "p24_payments"
                case paynowPayments = "paynow_payments"
                case promptpayPayments = "promptpay_payments"
                case revolutPayPayments = "revolut_pay_payments"
                case sepaDebitPayments = "sepa_debit_payments"
                case sofortPayments = "sofort_payments"
                case swishPayments = "swish_payments"
                case taxReportingUs1099K = "tax_reporting_us_1099_k"
                case taxReportingUs1099Misc = "tax_reporting_us_1099_misc"
                case transfers
                case treasury
                case twintPayments = "twint_payments"
                case usBankAccountAchPayments = "us_bank_account_ach_payments"
                case usBankTransferPayments = "us_bank_transfer_payments"
                case zipPayments = "zip_payments"
            }

            public struct CapabilityParam: Codable, Equatable, Sendable {
                public var requested: Bool?
            }
        }

        public struct DocumentsParam: Codable, Equatable, Sendable {
            public var bankAccountOwnershipVerification: BankAccountOwnershipVerificationParam?
            public var companyLicense: DocumentParam?
            public var companyMemorandumOfAssociation: DocumentParam?
            public var companyMinisterialDecree: DocumentParam?
            public var companyRegistrationVerification: DocumentParam?
            public var companyTaxIdVerification: DocumentParam?
            public var proofOfRegistration: DocumentParam?

            private enum CodingKeys: String, CodingKey {
                case bankAccountOwnershipVerification = "bank_account_ownership_verification"
                case companyLicense = "company_license"
                case companyMemorandumOfAssociation = "company_memorandum_of_association"
                case companyMinisterialDecree = "company_ministerial_decree"
                case companyRegistrationVerification = "company_registration_verification"
                case companyTaxIdVerification = "company_tax_id_verification"
                case proofOfRegistration = "proof_of_registration"
            }

            public struct BankAccountOwnershipVerificationParam: Codable, Equatable, Sendable {
                public var files: [String]?
            }

            public struct DocumentParam: Codable, Equatable, Sendable {
                public var files: [String]?
            }
        }

        public struct SettingsParam: Codable, Equatable, Sendable {
            public var bacsDebitPayments: BacsDebitPaymentsParam?
            public var branding: BrandingParam?
            public var cardIssuing: CardIssuingParam?
            public var cardPayments: CardPaymentsParam?
            public var invoices: InvoicesParam?
            public var payments: PaymentsParam?
            public var payouts: PayoutsParam?
            public var treasury: TreasuryParam?

            private enum CodingKeys: String, CodingKey {
                case bacsDebitPayments = "bacs_debit_payments"
                case branding
                case cardIssuing = "card_issuing"
                case cardPayments = "card_payments"
                case invoices
                case payments
                case payouts
                case treasury
            }

            public struct BacsDebitPaymentsParam: Codable, Equatable, Sendable {
                public var displayName: String?

                private enum CodingKeys: String, CodingKey {
                    case displayName = "display_name"
                }
            }

            public struct BrandingParam: Codable, Equatable, Sendable {
                public var icon: String?
                public var logo: String?
                public var primaryColor: String?
                public var secondaryColor: String?

                private enum CodingKeys: String, CodingKey {
                    case icon
                    case logo
                    case primaryColor = "primary_color"
                    case secondaryColor = "secondary_color"
                }
            }

            public struct CardIssuingParam: Codable, Equatable, Sendable {
                public var tosAcceptance: TOSAcceptanceParam?

                private enum CodingKeys: String, CodingKey {
                    case tosAcceptance = "tos_acceptance"
                }

                public struct TOSAcceptanceParam: Codable, Equatable, Sendable {
                    public var date: Date?
                    public var ip: String?
                    public var userAgent: String?

                    private enum CodingKeys: String, CodingKey {
                        case date
                        case ip
                        case userAgent = "user_agent"
                    }
                }
            }

            public struct CardPaymentsParam: Codable, Equatable, Sendable {
                public var declineOn: DeclineOnParam?
                public var statementDescriptorPrefix: String?
                public var statementDescriptorPrefixKana: String?
                public var statementDescriptorPrefixKanji: String?

                private enum CodingKeys: String, CodingKey {
                    case declineOn = "decline_on"
                    case statementDescriptorPrefix = "statement_descriptor_prefix"
                    case statementDescriptorPrefixKana = "statement_descriptor_prefix_kana"
                    case statementDescriptorPrefixKanji = "statement_descriptor_prefix_kanji"
                }

                public struct DeclineOnParam: Codable, Equatable, Sendable {
                    public var avsFailure: Bool?
                    public var cvcFailure: Bool?

                    private enum CodingKeys: String, CodingKey {
                        case avsFailure = "avs_failure"
                        case cvcFailure = "cvc_failure"
                    }
                }
            }

            public struct InvoicesParam: Codable, Equatable, Sendable {
                public var defaultAccountTaxIds: [String]?

                private enum CodingKeys: String, CodingKey {
                    case defaultAccountTaxIds = "default_account_tax_ids"
                }
            }

            public struct PaymentsParam: Codable, Equatable, Sendable {
                public var statementDescriptor: String?
                public var statementDescriptorKana: String?
                public var statementDescriptorKanji: String?

                private enum CodingKeys: String, CodingKey {
                    case statementDescriptor = "statement_descriptor"
                    case statementDescriptorKana = "statement_descriptor_kana"
                    case statementDescriptorKanji = "statement_descriptor_kanji"
                }
            }

            public struct PayoutsParam: Codable, Equatable, Sendable {
                public var debitNegativeBalances: Bool?
                public var schedule: ScheduleParam?
                public var statementDescriptor: String?

                private enum CodingKeys: String, CodingKey {
                    case debitNegativeBalances = "debit_negative_balances"
                    case schedule
                    case statementDescriptor = "statement_descriptor"
                }

                public struct ScheduleParam: Codable, Equatable, Sendable {
                    public var delayDays: DelayDays?
                    public var interval: Interval?
                    public var monthlyAnchor: Int?
                    public var weeklyAnchor: WeeklyAnchor?

                    private enum CodingKeys: String, CodingKey {
                        case delayDays = "delay_days"
                        case interval
                        case monthlyAnchor = "monthly_anchor"
                        case weeklyAnchor = "weekly_anchor"
                    }

                    public enum DelayDays: Codable, Equatable, Sendable {
                        case minimum
                        case days(Int)

                        public init(from decoder: Decoder) throws {
                            let container = try decoder.singleValueContainer()
                            if let stringValue = try? container.decode(String.self),
                                stringValue == "minimum"
                            {
                                self = .minimum
                            } else if let intValue = try? container.decode(Int.self) {
                                self = .days(intValue)
                            } else {
                                throw DecodingError.dataCorruptedError(
                                    in: container,
                                    debugDescription: "Invalid delay_days value"
                                )
                            }
                        }

                        public func encode(to encoder: Encoder) throws {
                            var container = encoder.singleValueContainer()
                            switch self {
                            case .minimum:
                                try container.encode("minimum")
                            case .days(let days):
                                try container.encode(days)
                            }
                        }
                    }

                    public enum Interval: String, Codable, Sendable {
                        case daily
                        case weekly
                        case monthly
                        case manual
                    }

                    public enum WeeklyAnchor: String, Codable, Sendable {
                        case monday
                        case tuesday
                        case wednesday
                        case thursday
                        case friday
                        case saturday
                        case sunday
                    }
                }
            }

            public struct TreasuryParam: Codable, Equatable, Sendable {
                public var tosAcceptance: TOSAcceptanceParam?

                private enum CodingKeys: String, CodingKey {
                    case tosAcceptance = "tos_acceptance"
                }

                public struct TOSAcceptanceParam: Codable, Equatable, Sendable {
                    public var date: Date?
                    public var ip: String?
                    public var userAgent: String?

                    private enum CodingKeys: String, CodingKey {
                        case date
                        case ip
                        case userAgent = "user_agent"
                    }
                }
            }
        }

        public struct ControllerParam: Codable, Equatable, Sendable {
            public var fees: FeesParam?
            public var losses: LossesParam?
            public var requirementCollection: RequirementCollection?
            public var stripeDashboard: StripeDashboardParam?

            private enum CodingKeys: String, CodingKey {
                case fees
                case losses
                case requirementCollection = "requirement_collection"
                case stripeDashboard = "stripe_dashboard"
            }

            public struct FeesParam: Codable, Equatable, Sendable {
                public var payer: Payer?

                public enum Payer: String, Codable, Sendable {
                    case account
                    case application
                }
            }

            public struct LossesParam: Codable, Equatable, Sendable {
                public var payments: Payments?

                public enum Payments: String, Codable, Sendable {
                    case application
                    case stripe
                }
            }

            public enum RequirementCollection: String, Codable, Sendable {
                case application
                case stripe
            }

            public struct StripeDashboardParam: Codable, Equatable, Sendable {
                public var type: `Type`?

                public enum `Type`: String, Codable, Sendable {
                    case express
                    case full
                    case none
                }
            }
        }
    }
}

extension Stripe.Connect.Accounts {
    // https://docs.stripe.com/api/accounts/update.md
    public enum Update {}
}

extension Stripe.Connect.Accounts.Update {
    public typealias Request = Stripe.Connect.Accounts.Create.Request
}

extension Stripe.Connect.Accounts {
    // https://docs.stripe.com/api/accounts/list.md
    public enum List {}
}

extension Stripe.Connect.Accounts.List {
    public struct Request: Codable, Equatable, Sendable {
        public var created: Stripe.DateFilter?
        public var endingBefore: String?
        public var expand: [String]?
        public var limit: Int?
        public var startingAfter: String?

        private enum CodingKeys: String, CodingKey {
            case created
            case endingBefore = "ending_before"
            case expand
            case limit
            case startingAfter = "starting_after"
        }

        public init(
            created: Stripe.DateFilter? = nil,
            endingBefore: String? = nil,
            expand: [String]? = nil,
            limit: Int? = nil,
            startingAfter: String? = nil
        ) {
            self.created = created
            self.endingBefore = endingBefore
            self.expand = expand
            self.limit = limit
            self.startingAfter = startingAfter
        }
    }

    public struct Response: Codable, Sendable {
        public let object: String
        public let url: String
        public let hasMore: Bool
        public let data: [Stripe.Connect.Account]

        private enum CodingKeys: String, CodingKey {
            case object
            case url
            case hasMore = "has_more"
            case data
        }
    }
}

extension Stripe.Connect.Accounts {
    // https://docs.stripe.com/api/accounts/reject.md
    public enum Reject {}
}

extension Stripe.Connect.Accounts.Reject {
    public struct Request: Codable, Equatable, Sendable {
        public var reason: Reason

        public enum Reason: String, Codable, Sendable {
            case fraud
            case termsOfService = "terms_of_service"
            case other
        }

        public init(reason: Reason) {
            self.reason = reason
        }
    }
}
