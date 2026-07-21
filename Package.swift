// swift-tools-version: 6.3.3

import Foundation
import PackageDescription

extension String {
    static let stripeTypes: Self = "Stripe Types"
    static let stripeBalance: Self = "Stripe Balance Types"
    static let stripeBalanceTransactions: Self = "Stripe Balance Transactions Types"
    static let stripeCharges: Self = "Stripe Charges Types"
    static let stripeCustomers: Self = "Stripe Customers Types"
    static let stripeCustomerSession: Self = "Stripe Customer Session Types"
    static let stripeDisputes: Self = "Stripe Disputes Types"
    static let stripeEvents: Self = "Stripe Events Types"
    static let stripeEventDestinations: Self = "Stripe Event Destinations Types"
    static let stripeFiles: Self = "Stripe Files Types"
    static let stripeFileLinks: Self = "Stripe File Links Types"
    static let stripeMandates: Self = "Stripe Mandates Types"
    static let stripePaymentIntents: Self = "Stripe Payment Intents Types"
    static let stripeSetupIntents: Self = "Stripe Setup Intents Types"
    static let stripeSetupAttempts: Self = "Stripe Setup Attempts Types"
    static let stripePayouts: Self = "Stripe Payouts Types"
    static let stripeRefunds: Self = "Stripe Refunds Types"
    static let stripeConfirmationToken: Self = "Stripe Confirmation Token Types"
    static let stripeTokens: Self = "Stripe Tokens Types"
    static let stripePaymentMethods: Self = "Stripe Payment Methods Types"
    static let stripeProducts: Self = "Stripe Products Types"
    static let stripeCheckout: Self = "Stripe Checkout Types"
    static let stripePaymentLink: Self = "Stripe Payment Link Types"
    static let stripeBilling: Self = "Stripe Billing Types"
    static let stripeCapital: Self = "Stripe Capital Types"
    static let stripeConnect: Self = "Stripe Connect Types"
    static let stripeFraud: Self = "Stripe Fraud Types"
    static let stripeIssuing: Self = "Stripe Issuing Types"
    static let stripeTerminal: Self = "Stripe Terminal Types"
    static let stripeTreasury: Self = "Stripe Treasury Types"
    static let stripeEntitlements: Self = "Stripe Entitlements Types"
    static let stripeSigma: Self = "Stripe Sigma Types"
    static let stripeReporting: Self = "Stripe Reporting Types"
    static let stripeFinancialConnections: Self = "Stripe Financial Connections Types"
    static let stripeTax: Self = "Stripe Tax Types"
    static let stripeIdentity: Self = "Stripe Identity Types"
    static let stripeCrypto: Self = "Stripe Crypto Types"
    static let stripeClimate: Self = "Stripe Climate Types"
    static let stripeForwarding: Self = "Stripe Forwarding Types"
    static let stripeWebhooks: Self = "Stripe Webhooks Types"
    static let stripeWebElements: Self = "Stripe Web Elements Types"
    static let stripeTypesShared: Self = "Stripe Types Shared"
    static let stripeTypesModels: Self = "Stripe Types Models"
}

extension Target.Dependency {
    static var stripeTypes: Self { .target(name: .stripeTypes) }
    static var stripeBalance: Self { .target(name: .stripeBalance) }
    static var stripeBalanceTransactions: Self { .target(name: .stripeBalanceTransactions) }
    static var stripeCharges: Self { .target(name: .stripeCharges) }
    static var stripeCustomers: Self { .target(name: .stripeCustomers) }
    static var stripeCustomerSession: Self { .target(name: .stripeCustomerSession) }
    static var stripeDisputes: Self { .target(name: .stripeDisputes) }
    static var stripeEvents: Self { .target(name: .stripeEvents) }
    static var stripeEventDestinations: Self { .target(name: .stripeEventDestinations) }
    static var stripeFiles: Self { .target(name: .stripeFiles) }
    static var stripeFileLinks: Self { .target(name: .stripeFileLinks) }
    static var stripeMandates: Self { .target(name: .stripeMandates) }
    static var stripePaymentIntents: Self { .target(name: .stripePaymentIntents) }
    static var stripeSetupIntents: Self { .target(name: .stripeSetupIntents) }
    static var stripeSetupAttempts: Self { .target(name: .stripeSetupAttempts) }
    static var stripePayouts: Self { .target(name: .stripePayouts) }
    static var stripeRefunds: Self { .target(name: .stripeRefunds) }
    static var stripeConfirmationToken: Self { .target(name: .stripeConfirmationToken) }
    static var stripeTokens: Self { .target(name: .stripeTokens) }
    static var stripePaymentMethods: Self { .target(name: .stripePaymentMethods) }
    static var stripeProducts: Self { .target(name: .stripeProducts) }
    static var stripeCheckout: Self { .target(name: .stripeCheckout) }
    static var stripePaymentLink: Self { .target(name: .stripePaymentLink) }
    static var stripeBilling: Self { .target(name: .stripeBilling) }
    static var stripeCapital: Self { .target(name: .stripeCapital) }
    static var stripeConnect: Self { .target(name: .stripeConnect) }
    static var stripeFraud: Self { .target(name: .stripeFraud) }
    static var stripeIssuing: Self { .target(name: .stripeIssuing) }
    static var stripeTerminal: Self { .target(name: .stripeTerminal) }
    static var stripeTreasury: Self { .target(name: .stripeTreasury) }
    static var stripeEntitlements: Self { .target(name: .stripeEntitlements) }
    static var stripeSigma: Self { .target(name: .stripeSigma) }
    static var stripeReporting: Self { .target(name: .stripeReporting) }
    static var stripeFinancialConnections: Self { .target(name: .stripeFinancialConnections) }
    static var stripeTax: Self { .target(name: .stripeTax) }
    static var stripeIdentity: Self { .target(name: .stripeIdentity) }
    static var stripeCrypto: Self { .target(name: .stripeCrypto) }
    static var stripeClimate: Self { .target(name: .stripeClimate) }
    static var stripeForwarding: Self { .target(name: .stripeForwarding) }
    static var stripeWebhooks: Self { .target(name: .stripeWebhooks) }
    static var stripeWebElements: Self { .target(name: .stripeWebElements) }
    static var stripeTypesShared: Self { .target(name: .stripeTypesShared) }
    static var stripeTypesModels: Self { .target(name: .stripeTypesModels) }
}

extension Target.Dependency {
    static var dependencies: Self { .product(name: "Dependencies", package: "swift-dependencies") }
    static var dependenciesTestSupport: Self { .product(name: "Dependencies Test Support", package: "swift-dependencies") }
    static var tagged: Self { .product(name: "Tagged Primitives", package: "swift-tagged-primitives") }
    static var dual: Self { .product(name: "Dual", package: "swift-dual") }
    static var urlRouting: Self { .product(name: "URLRouting", package: "swift-url-routing") }
    static var urlFormCoding: Self { .product(name: "URLFormCoding", package: "swift-url-form-coding") }
    static var urlFormCodingURLRouting: Self { .product(name: "URL Routing Form Coding", package: "swift-url-routing-form-coding") }
}

let package = Package(
    name: "swift-stripe-types",
    platforms: [
        .macOS(.v26),
        .iOS(.v26),
        .tvOS(.v26),
        .watchOS(.v26),
        .visionOS(.v26)
    ],
    products: [
        .library(name: .stripeTypes, targets: [.stripeTypes]),
        .library(name: .stripeBalance, targets: [.stripeBalance]),
        .library(name: .stripeBalanceTransactions, targets: [.stripeBalanceTransactions]),
        .library(name: .stripeCharges, targets: [.stripeCharges]),
        .library(name: .stripeCustomers, targets: [.stripeCustomers]),
        .library(name: .stripeCustomerSession, targets: [.stripeCustomerSession]),
        .library(name: .stripeDisputes, targets: [.stripeDisputes]),
        .library(name: .stripeEvents, targets: [.stripeEvents]),
        .library(name: .stripeEventDestinations, targets: [.stripeEventDestinations]),
        .library(name: .stripeFiles, targets: [.stripeFiles]),
        .library(name: .stripeFileLinks, targets: [.stripeFileLinks]),
        .library(name: .stripeMandates, targets: [.stripeMandates]),
        .library(name: .stripePaymentIntents, targets: [.stripePaymentIntents]),
        .library(name: .stripeSetupIntents, targets: [.stripeSetupIntents]),
        .library(name: .stripeSetupAttempts, targets: [.stripeSetupAttempts]),
        .library(name: .stripePayouts, targets: [.stripePayouts]),
        .library(name: .stripeRefunds, targets: [.stripeRefunds]),
        .library(name: .stripeConfirmationToken, targets: [.stripeConfirmationToken]),
        .library(name: .stripeTokens, targets: [.stripeTokens]),
        .library(name: .stripePaymentMethods, targets: [.stripePaymentMethods]),
        .library(name: .stripeProducts, targets: [.stripeProducts]),
        .library(name: .stripeCheckout, targets: [.stripeCheckout]),
        .library(name: .stripePaymentLink, targets: [.stripePaymentLink]),
        .library(name: .stripeBilling, targets: [.stripeBilling]),
        .library(name: .stripeCapital, targets: [.stripeCapital]),
        .library(name: .stripeConnect, targets: [.stripeConnect]),
        .library(name: .stripeFraud, targets: [.stripeFraud]),
        .library(name: .stripeIssuing, targets: [.stripeIssuing]),
        .library(name: .stripeTerminal, targets: [.stripeTerminal]),
        .library(name: .stripeTreasury, targets: [.stripeTreasury]),
        .library(name: .stripeEntitlements, targets: [.stripeEntitlements]),
        .library(name: .stripeSigma, targets: [.stripeSigma]),
        .library(name: .stripeReporting, targets: [.stripeReporting]),
        .library(name: .stripeFinancialConnections, targets: [.stripeFinancialConnections]),
        .library(name: .stripeTax, targets: [.stripeTax]),
        .library(name: .stripeIdentity, targets: [.stripeIdentity]),
        .library(name: .stripeCrypto, targets: [.stripeCrypto]),
        .library(name: .stripeClimate, targets: [.stripeClimate]),
        .library(name: .stripeForwarding, targets: [.stripeForwarding]),
        .library(name: .stripeWebhooks, targets: [.stripeWebhooks]),
        .library(name: .stripeWebElements, targets: [.stripeWebElements]),
        .library(name: .stripeTypesShared, targets: [.stripeTypesShared]),
        .library(name: .stripeTypesModels, targets: [.stripeTypesModels])
    ],
    dependencies: [
        .package(url: "https://github.com/swift-foundations/swift-dependencies.git", branch: "main"),
        .package(url: "https://github.com/swift-primitives/swift-tagged-primitives.git", branch: "main"),
        .package(url: "https://github.com/swift-foundations/swift-dual.git", branch: "main"),
        .package(url: "https://github.com/swift-foundations/swift-url-routing.git", branch: "main"),
        .package(url: "https://github.com/swift-foundations/swift-url-form-coding.git", branch: "main"),
        .package(url: "https://github.com/swift-foundations/swift-url-routing-form-coding.git", branch: "main")
    ],
    targets: [
        .target(
            name: .stripeTypesShared,
            dependencies: [
                .dependencies,
                .dual,
                .urlRouting,
                .urlFormCoding,
                .urlFormCodingURLRouting,
            ]
        ),
        .target(
            name: .stripeTypesModels,
            dependencies: [
                .dependencies,
                .dual,
                .urlRouting,
                .urlFormCoding,
                .urlFormCodingURLRouting,
                .tagged,
                .stripeTypesShared
            ]
        ),
        .target(
            name: .stripeTypes,
            dependencies: [
                .stripeTypesModels,
                .stripeTypesShared,
                .dependencies,
                .dual,
                .urlRouting,
                .urlFormCoding,
                .urlFormCodingURLRouting,
                .tagged,
                .stripeBalance,
                .stripeBalanceTransactions,
                .stripeCharges,
                .stripeCustomers,
                .stripeCustomerSession,
                .stripeDisputes,
                .stripeEvents,
                .stripeEventDestinations,
                .stripeFiles,
                .stripeFileLinks,
                .stripeMandates,
                .stripePaymentIntents,
                .stripeSetupIntents,
                .stripeSetupAttempts,
                .stripePayouts,
                .stripeRefunds,
                .stripeConfirmationToken,
                .stripeTokens,
                .stripePaymentMethods,
                .stripeProducts,
                .stripeCheckout,
                .stripePaymentLink,
                .stripeBilling,
                .stripeCapital,
                .stripeConnect,
                .stripeFraud,
                .stripeIssuing,
                .stripeTerminal,
                .stripeTreasury,
                .stripeEntitlements,
                .stripeSigma,
                .stripeReporting,
                .stripeFinancialConnections,
                .stripeTax,
                .stripeIdentity,
                .stripeCrypto,
                .stripeClimate,
                .stripeForwarding,
                .stripeWebhooks,
                .stripeWebElements
            ]
        ),
        .testTarget(
            name: "Stripe Router Parity Tests",
            dependencies: [
                .stripeTypes,
                .product(name: "URL Routing Test Support", package: "swift-url-routing")
            ],
            path: "Tests/Stripe Router Parity Tests",
            exclude: ["__Corpus__"]
        ),
        .testTarget(
            name: "Stripe Types Shared Tests",
            dependencies: [
                .stripeTypesShared,
                .dependenciesTestSupport,
                .tagged
            ]
        ),
        .testTarget(
            name: "Stripe Types Models Tests",
            dependencies: [
                .stripeTypesModels,
                .stripeTypesShared,
                .dependenciesTestSupport
            ]
        ),
        .testTarget(
            name: "Stripe Types Tests",
            dependencies: [
                .stripeTypes,
                .dependenciesTestSupport
            ]
        ),
        .target(
            name: .stripeBalance,
            dependencies: [
                .stripeTypesModels,
                .stripeTypesShared,
                .dependencies,
                .dual,
                .urlRouting,
                .urlFormCoding,
                .urlFormCodingURLRouting,
                .tagged
            ]
        ),
        .testTarget(
            name: "Stripe Balance Types Tests",
            dependencies: [
                .stripeBalance,
                .dependenciesTestSupport
            ]
        ),
        .target(
            name: .stripeBalanceTransactions,
            dependencies: [
                .stripeTypesModels,
                .stripeTypesShared,
                .dependencies,
                .dual,
                .urlRouting,
                .urlFormCoding,
                .urlFormCodingURLRouting,
                .tagged
            ]
        ),
        .testTarget(
            name: "Stripe Balance Transactions Types Tests",
            dependencies: [
                .stripeBalanceTransactions,
                .dependenciesTestSupport
            ]
        ),
        .target(
            name: .stripeCharges,
            dependencies: [
                .stripeTypesModels,
                .stripeTypesShared,
                .dependencies,
                .dual,
                .urlRouting,
                .urlFormCoding,
                .urlFormCodingURLRouting,
                .tagged
            ]
        ),
        .testTarget(
            name: "Stripe Charges Types Tests",
            dependencies: [
                .stripeCharges,
                .dependenciesTestSupport
            ]
        ),
        .target(
            name: .stripeCustomers,
            dependencies: [
                .stripeTypesModels,
                .stripeTypesShared,
                .dependencies,
                .dual,
                .urlRouting,
                .urlFormCoding,
                .urlFormCodingURLRouting,
                .tagged
            ]
        ),
        .testTarget(
            name: "Stripe Customers Types Tests",
            dependencies: [
                .stripeCustomers,
                .dependenciesTestSupport
            ]
        ),
        .target(
            name: .stripeCustomerSession,
            dependencies: [
                .stripeTypesModels,
                .stripeTypesShared,
                .dependencies,
                .dual,
                .urlRouting,
                .urlFormCoding,
                .urlFormCodingURLRouting,
                .tagged
            ]
        ),
        .testTarget(
            name: "Stripe Customer Session Types Tests",
            dependencies: [
                .stripeCustomerSession,
                .dependenciesTestSupport
            ]
        ),
        .target(
            name: .stripeDisputes,
            dependencies: [
                .stripeTypesModels,
                .stripeTypesShared,
                .dependencies,
                .dual,
                .urlRouting,
                .urlFormCoding,
                .urlFormCodingURLRouting,
                .tagged
            ]
        ),
        .testTarget(
            name: "Stripe Disputes Types Tests",
            dependencies: [
                .stripeDisputes,
                .dependenciesTestSupport
            ]
        ),
        .target(
            name: .stripeEvents,
            dependencies: [
                .stripeTypesModels,
                .stripeTypesShared,
                .dependencies,
                .dual,
                .urlRouting,
                .urlFormCoding,
                .urlFormCodingURLRouting,
                .tagged
            ]
        ),
        .testTarget(
            name: "Stripe Events Types Tests",
            dependencies: [
                .stripeEvents,
                .dependenciesTestSupport
            ]
        ),
        .target(
            name: .stripeEventDestinations,
            dependencies: [
                .stripeTypesModels,
                .stripeTypesShared,
                .dependencies,
                .dual,
                .urlRouting,
                .urlFormCoding,
                .urlFormCodingURLRouting,
                .tagged
            ]
        ),
        .testTarget(
            name: "Stripe Event Destinations Types Tests",
            dependencies: [
                .stripeEventDestinations,
                .dependenciesTestSupport
            ]
        ),
        .target(
            name: .stripeFiles,
            dependencies: [
                .stripeTypesModels,
                .stripeTypesShared,
                .dependencies,
                .dual,
                .urlRouting,
                .urlFormCoding,
                .urlFormCodingURLRouting,
                .tagged
            ]
        ),
        .testTarget(
            name: "Stripe Files Types Tests",
            dependencies: [
                .stripeFiles,
                .dependenciesTestSupport
            ]
        ),
        .target(
            name: .stripeFileLinks,
            dependencies: [
                .stripeTypesModels,
                .stripeTypesShared,
                .dependencies,
                .dual,
                .urlRouting,
                .urlFormCoding,
                .urlFormCodingURLRouting,
                .tagged
            ]
        ),
        .testTarget(
            name: "Stripe File Links Types Tests",
            dependencies: [
                .stripeFileLinks,
                .dependenciesTestSupport
            ]
        ),
        .target(
            name: .stripeMandates,
            dependencies: [
                .stripeTypesModels,
                .stripeTypesShared,
                .dependencies,
                .dual,
                .urlRouting,
                .urlFormCoding,
                .urlFormCodingURLRouting,
                .tagged
            ]
        ),
        .testTarget(
            name: "Stripe Mandates Types Tests",
            dependencies: [
                .stripeMandates,
                .dependenciesTestSupport
            ]
        ),
        .target(
            name: .stripePaymentIntents,
            dependencies: [
                .stripeTypesModels,
                .stripeTypesShared,
                .dependencies,
                .dual,
                .urlRouting,
                .urlFormCoding,
                .urlFormCodingURLRouting,
                .tagged
            ]
        ),
        .testTarget(
            name: "Stripe Payment Intents Types Tests",
            dependencies: [
                .stripePaymentIntents,
                .dependenciesTestSupport
            ]
        ),
        .target(
            name: .stripeSetupIntents,
            dependencies: [
                .stripeTypesModels,
                .stripeTypesShared,
                .dependencies,
                .dual,
                .urlRouting,
                .urlFormCoding,
                .urlFormCodingURLRouting,
                .tagged
            ]
        ),
        .testTarget(
            name: "Stripe Setup Intents Types Tests",
            dependencies: [
                .stripeSetupIntents,
                .dependenciesTestSupport
            ]
        ),
        .target(
            name: .stripeSetupAttempts,
            dependencies: [
                .stripeTypesModels,
                .stripeTypesShared,
                .dependencies,
                .dual,
                .urlRouting,
                .urlFormCoding,
                .urlFormCodingURLRouting,
                .tagged
            ]
        ),
        .testTarget(
            name: "Stripe Setup Attempts Types Tests",
            dependencies: [
                .stripeSetupAttempts,
                .dependenciesTestSupport
            ]
        ),
        .target(
            name: .stripePayouts,
            dependencies: [
                .stripeTypesModels,
                .stripeTypesShared,
                .dependencies,
                .dual,
                .urlRouting,
                .urlFormCoding,
                .urlFormCodingURLRouting,
                .tagged
            ]
        ),
        .testTarget(
            name: "Stripe Payouts Types Tests",
            dependencies: [
                .stripePayouts,
                .dependenciesTestSupport
            ]
        ),
        .target(
            name: .stripeRefunds,
            dependencies: [
                .stripeTypesModels,
                .stripeTypesShared,
                .dependencies,
                .dual,
                .urlRouting,
                .urlFormCoding,
                .urlFormCodingURLRouting,
                .tagged
            ]
        ),
        .testTarget(
            name: "Stripe Refunds Types Tests",
            dependencies: [
                .stripeRefunds,
                .dependenciesTestSupport
            ]
        ),
        .target(
            name: .stripeConfirmationToken,
            dependencies: [
                .stripeTypesModels,
                .stripeTypesShared,
                .dependencies,
                .dual,
                .urlRouting,
                .urlFormCoding,
                .urlFormCodingURLRouting,
                .tagged
            ]
        ),
        .testTarget(
            name: "Stripe Confirmation Token Types Tests",
            dependencies: [
                .stripeConfirmationToken,
                .dependenciesTestSupport
            ]
        ),
        .target(
            name: .stripeTokens,
            dependencies: [
                .stripeTypesModels,
                .stripeTypesShared,
                .dependencies,
                .dual,
                .urlRouting,
                .urlFormCoding,
                .urlFormCodingURLRouting,
                .tagged
            ]
        ),
        .testTarget(
            name: "Stripe Tokens Types Tests",
            dependencies: [
                .stripeTokens,
                .dependenciesTestSupport
            ]
        ),
        .target(
            name: .stripePaymentMethods,
            dependencies: [
                .stripeTypesModels,
                .stripeTypesShared,
                .dependencies,
                .dual,
                .urlRouting,
                .urlFormCoding,
                .urlFormCodingURLRouting,
                .tagged
            ]
        ),
        .testTarget(
            name: "Stripe Payment Methods Types Tests",
            dependencies: [
                .stripePaymentMethods,
                .dependenciesTestSupport
            ]
        ),
        .target(
            name: .stripeProducts,
            dependencies: [
                .stripeTypesModels,
                .stripeTypesShared,
                .dependencies,
                .dual,
                .urlRouting,
                .urlFormCoding,
                .urlFormCodingURLRouting,
                .tagged
            ]
        ),
        .testTarget(
            name: "Stripe Products Types Tests",
            dependencies: [
                .stripeProducts,
                .dependenciesTestSupport
            ]
        ),
        .target(
            name: .stripeCheckout,
            dependencies: [
                .stripeTypesModels,
                .stripeTypesShared,
                .dependencies,
                .dual,
                .urlRouting,
                .urlFormCoding,
                .urlFormCodingURLRouting,
                .tagged
            ]
        ),
        .testTarget(
            name: "Stripe Checkout Types Tests",
            dependencies: [
                .stripeCheckout,
                .dependenciesTestSupport
            ]
        ),
        .target(
            name: .stripePaymentLink,
            dependencies: [
                .stripeTypesModels,
                .stripeTypesShared,
                .dependencies,
                .dual,
                .urlRouting,
                .urlFormCoding,
                .urlFormCodingURLRouting,
                .tagged
            ]
        ),
        .testTarget(
            name: "Stripe Payment Link Types Tests",
            dependencies: [
                .stripePaymentLink,
                .dependenciesTestSupport
            ]
        ),
        .target(
            name: .stripeBilling,
            dependencies: [
                .stripeTypesModels,
                .stripeTypesShared,
                .dependencies,
                .dual,
                .urlRouting,
                .urlFormCoding,
                .urlFormCodingURLRouting,
                .tagged
            ]
        ),
        .testTarget(
            name: "Stripe Billing Types Tests",
            dependencies: [
                .stripeBilling,
                .dependenciesTestSupport
            ]
        ),
        .target(
            name: .stripeCapital,
            dependencies: [
                .stripeTypesModels,
                .stripeTypesShared,
                .dependencies,
                .dual,
                .urlRouting,
                .urlFormCoding,
                .urlFormCodingURLRouting,
                .tagged
            ]
        ),
        .testTarget(
            name: "Stripe Capital Types Tests",
            dependencies: [
                .stripeCapital,
                .dependenciesTestSupport
            ]
        ),
        .target(
            name: .stripeConnect,
            dependencies: [
                .stripeTypesModels,
                .stripeTypesShared,
                .dependencies,
                .dual,
                .urlRouting,
                .urlFormCoding,
                .urlFormCodingURLRouting,
                .tagged
            ]
        ),
        .testTarget(
            name: "Stripe Connect Types Tests",
            dependencies: [
                .stripeConnect,
                .dependenciesTestSupport
            ]
        ),
        .target(
            name: .stripeFraud,
            dependencies: [
                .stripeTypesModels,
                .stripeTypesShared,
                .dependencies,
                .dual,
                .urlRouting,
                .urlFormCoding,
                .urlFormCodingURLRouting,
                .tagged
            ]
        ),
        .testTarget(
            name: "Stripe Fraud Types Tests",
            dependencies: [
                .stripeFraud,
                .dependenciesTestSupport
            ]
        ),
        .target(
            name: .stripeIssuing,
            dependencies: [
                .stripeTypesModels,
                .stripeTypesShared,
                .dependencies,
                .dual,
                .urlRouting,
                .urlFormCoding,
                .urlFormCodingURLRouting,
                .tagged
            ]
        ),
        .testTarget(
            name: "Stripe Issuing Types Tests",
            dependencies: [
                .stripeIssuing,
                .dependenciesTestSupport
            ]
        ),
        .target(
            name: .stripeTerminal,
            dependencies: [
                .stripeTypesModels,
                .stripeTypesShared,
                .dependencies,
                .dual,
                .urlRouting,
                .urlFormCoding,
                .urlFormCodingURLRouting,
                .tagged
            ]
        ),
        .testTarget(
            name: "Stripe Terminal Types Tests",
            dependencies: [
                .stripeTerminal,
                .dependenciesTestSupport
            ]
        ),
        .target(
            name: .stripeTreasury,
            dependencies: [
                .stripeTypesModels,
                .stripeTypesShared,
                .dependencies,
                .dual,
                .urlRouting,
                .urlFormCoding,
                .urlFormCodingURLRouting,
                .tagged
            ]
        ),
        .testTarget(
            name: "Stripe Treasury Types Tests",
            dependencies: [
                .stripeTreasury,
                .dependenciesTestSupport
            ]
        ),
        .target(
            name: .stripeEntitlements,
            dependencies: [
                .stripeTypesModels,
                .stripeTypesShared,
                .dependencies,
                .dual,
                .urlRouting,
                .urlFormCoding,
                .urlFormCodingURLRouting,
                .tagged
            ]
        ),
        .testTarget(
            name: "Stripe Entitlements Types Tests",
            dependencies: [
                .stripeEntitlements,
                .dependenciesTestSupport
            ]
        ),
        .target(
            name: .stripeSigma,
            dependencies: [
                .stripeTypesModels,
                .stripeTypesShared,
                .dependencies,
                .dual,
                .urlRouting,
                .urlFormCoding,
                .urlFormCodingURLRouting,
                .tagged
            ]
        ),
        .testTarget(
            name: "Stripe Sigma Types Tests",
            dependencies: [
                .stripeSigma,
                .dependenciesTestSupport
            ]
        ),
        .target(
            name: .stripeReporting,
            dependencies: [
                .stripeTypesModels,
                .stripeTypesShared,
                .dependencies,
                .dual,
                .urlRouting,
                .urlFormCoding,
                .urlFormCodingURLRouting,
                .tagged
            ]
        ),
        .testTarget(
            name: "Stripe Reporting Types Tests",
            dependencies: [
                .stripeReporting,
                .dependenciesTestSupport
            ]
        ),
        .target(
            name: .stripeFinancialConnections,
            dependencies: [
                .stripeTypesModels,
                .stripeTypesShared,
                .dependencies,
                .dual,
                .urlRouting,
                .urlFormCoding,
                .urlFormCodingURLRouting,
                .tagged
            ]
        ),
        .testTarget(
            name: "Stripe Financial Connections Types Tests",
            dependencies: [
                .stripeFinancialConnections,
                .dependenciesTestSupport
            ]
        ),
        .target(
            name: .stripeTax,
            dependencies: [
                .stripeTypesModels,
                .stripeTypesShared,
                .dependencies,
                .dual,
                .urlRouting,
                .urlFormCoding,
                .urlFormCodingURLRouting,
                .tagged
            ]
        ),
        .testTarget(
            name: "Stripe Tax Types Tests",
            dependencies: [
                .stripeTax,
                .dependenciesTestSupport
            ]
        ),
        .target(
            name: .stripeIdentity,
            dependencies: [
                .stripeTypesModels,
                .stripeTypesShared,
                .dependencies,
                .dual,
                .urlRouting,
                .urlFormCoding,
                .urlFormCodingURLRouting,
                .tagged
            ]
        ),
        .testTarget(
            name: "Stripe Identity Types Tests",
            dependencies: [
                .stripeIdentity,
                .dependenciesTestSupport
            ]
        ),
        .target(
            name: .stripeCrypto,
            dependencies: [
                .stripeTypesModels,
                .stripeTypesShared,
                .dependencies,
                .dual,
                .urlRouting,
                .urlFormCoding,
                .urlFormCodingURLRouting,
                .tagged
            ]
        ),
        .testTarget(
            name: "Stripe Crypto Types Tests",
            dependencies: [
                .stripeCrypto,
                .dependenciesTestSupport
            ]
        ),
        .target(
            name: .stripeClimate,
            dependencies: [
                .stripeTypesModels,
                .stripeTypesShared,
                .dependencies,
                .dual,
                .urlRouting,
                .urlFormCoding,
                .urlFormCodingURLRouting,
                .tagged
            ]
        ),
        .testTarget(
            name: "Stripe Climate Types Tests",
            dependencies: [
                .stripeClimate,
                .dependenciesTestSupport
            ]
        ),
        .target(
            name: .stripeForwarding,
            dependencies: [
                .stripeTypesModels,
                .stripeTypesShared,
                .dependencies,
                .dual,
                .urlRouting,
                .urlFormCoding,
                .urlFormCodingURLRouting,
                .tagged
            ]
        ),
        .testTarget(
            name: "Stripe Forwarding Types Tests",
            dependencies: [
                .stripeForwarding,
                .dependenciesTestSupport
            ]
        ),
        .target(
            name: .stripeWebhooks,
            dependencies: [
                .stripeTypesModels,
                .stripeTypesShared,
                .dependencies,
                .dual,
                .urlRouting,
                .urlFormCoding,
                .urlFormCodingURLRouting,
                .tagged
            ]
        ),
        .testTarget(
            name: "Stripe Webhooks Types Tests",
            dependencies: [
                .stripeWebhooks,
                .dependenciesTestSupport
            ]
        ),
        .target(
            name: .stripeWebElements,
            dependencies: [
                .stripeTypesModels,
                .stripeTypesShared,
                .dependencies,
                .dual,
                .urlRouting,
                .urlFormCoding,
                .urlFormCodingURLRouting,
                .tagged
            ]
        ),
        .testTarget(
            name: "Stripe Web Elements Types Tests",
            dependencies: [
                .stripeWebElements,
                .dependenciesTestSupport
            ]
        )
    ],
    swiftLanguageModes: [.v6]
)

let swiftSettings: [SwiftSetting] = [
    .enableUpcomingFeature("MemberImportVisibility"),
    .enableUpcomingFeature("StrictUnsafe"),
    .enableUpcomingFeature("NonisolatedNonsendingByDefault"),
//    .unsafeFlags(["-warnings-as-errors"]),
    // .unsafeFlags([
    //   "-Xfrontend",
    //   "-warn-long-function-bodies=50",
    //   "-Xfrontend",
    //   "-warn-long-expression-type-checking=50",
    // ])
]

for index in package.targets.indices {
    package.targets[index].swiftSettings = (package.targets[index].swiftSettings ?? []) + swiftSettings
}
