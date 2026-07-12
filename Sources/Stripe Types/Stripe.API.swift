//
//  File.swift
//  coenttb-web
//
//  Created by Coen ten Thije Boonkkamp on 20/09/2024.
//

import Stripe_Balance_Transactions_Types
import Stripe_Balance_Types
import Stripe_Billing_Types
import Stripe_Capital_Types
import Stripe_Charges_Types
import Stripe_Checkout_Types
import Stripe_Climate_Types
import Stripe_Confirmation_Token_Types
import Stripe_Connect_Types
import Stripe_Customer_Session_Types
import Stripe_Customers_Types
import Stripe_Disputes_Types
import Stripe_Entitlements_Types
import Stripe_Event_Destinations_Types
import Stripe_Events_Types
import Stripe_File_Links_Types
import Stripe_Files_Types
import Stripe_Financial_Connections_Types
import Stripe_Forwarding_Types
import Stripe_Fraud_Types
import Stripe_Identity_Types
import Stripe_Issuing_Types
import Stripe_Mandates_Types
import Stripe_Payment_Intents_Types
import Stripe_Payment_Link_Types
import Stripe_Payment_Methods_Types
import Stripe_Payouts_Types
import Stripe_Products_Types
import Stripe_Refunds_Types
import Stripe_Reporting_Types
import Stripe_Setup_Attempts_Types
import Stripe_Setup_Intents_Types
import Stripe_Sigma_Types
import Stripe_Tax_Types
import Stripe_Terminal_Types
import Stripe_Tokens_Types
import Stripe_Treasury_Types
import Stripe_Webhooks_Types
import URLRouting

extension Stripe {
    @Cases
    public enum API: Equatable, Sendable {
        case balance(Stripe.Balance.API)
        case balanceTransactions(Stripe.BalanceTransactions.API)
        case charges(Stripe.Charges.API)
        case customers(Stripe.Customers.API)
        case customerSessions(Stripe.Customers.Customer.Sessions.API)
        case disputes(Stripe.Disputes.API)
        case events(Stripe.Events.API)
        case files(Stripe.Files.API)
        case fileLinks(Stripe.FileLinks.API)
        case mandates(Stripe.Mandates.API)
        case paymentIntents(Stripe.PaymentIntents.API)
        case setupIntents(Stripe.Setup.Intents.API)
        case setupAttempts(Stripe.Setup.Attempts.API)
        case payouts(Stripe.Payouts.API)
        case refunds(Stripe.Refunds.API)
        case confirmationToken(Stripe.ConfirmationToken.API)
        case tokens(Stripe.Tokens.API)
        case paymentMethods(Stripe.PaymentMethods.API)
        case products(Stripe.Products.API)
        case checkout(Stripe.Checkout.API)
        case paymentLinks(Stripe.PaymentLinks.API)
        case billing(Stripe.Billing.API)
        //    case capital(Capital.API)
        //    case connect(Connect.API)
        //    case fraud(Fraud.API)
        //    case issuing(Issuing.API)
        //    case terminal(Terminal.API)
        //    case treasury(Treasury.API)
        //    case entitlements(Entitlements.API)
        //    case sigma(Sigma.API)
        //    case reporting(Reporting.API)
        //    case financial_Connections(Financial_Connections.API)
        //    case tax(Tax.API)
        //    case identity(Identity.API)
        //    case crypto(Crypto.API)
        //    case climate(Climate.API)
        //    case forwarding(Forwarding.API)
        //    case webhooks(Webhooks.API)
    }
}

extension Stripe.API {
    public struct Router: ParserPrinter, Sendable {

        public init() {}

        public var body: some URLRouting.Router<Stripe.API> {
            OneOf {

                URLRouting.Route(.case(Stripe.API.cases.balance)) {
                    Stripe.Balance.API.Router()
                }
                URLRouting.Route(.case(Stripe.API.cases.balanceTransactions)) {
                    Stripe.BalanceTransactions.API.Router()
                }
                URLRouting.Route(.case(Stripe.API.cases.charges)) {
                    Stripe.Charges.API.Router()
                }
                URLRouting.Route(.case(Stripe.API.cases.customers)) {
                    Stripe.Customers.API.Router()
                }
                URLRouting.Route(.case(Stripe.API.cases.customerSessions)) {
                    Stripe.Customers.Customer.Sessions.API.Router()
                }
                URLRouting.Route(.case(Stripe.API.cases.disputes)) {
                    Stripe.Disputes.API.Router()
                }
                URLRouting.Route(.case(Stripe.API.cases.events)) {
                    Stripe.Events.API.Router()
                }
                URLRouting.Route(.case(Stripe.API.cases.files)) {
                    Stripe.Files.API.Router()
                }
                URLRouting.Route(.case(Stripe.API.cases.fileLinks)) {
                    Stripe.FileLinks.API.Router()
                }
                URLRouting.Route(.case(Stripe.API.cases.mandates)) {
                    Stripe.Mandates.API.Router()
                }
                URLRouting.Route(.case(Stripe.API.cases.paymentIntents)) {
                    Stripe.PaymentIntents.API.Router()
                }
                URLRouting.Route(.case(Stripe.API.cases.setupIntents)) {
                    Stripe.Setup.Intents.API.Router()
                }
                URLRouting.Route(.case(Stripe.API.cases.setupAttempts)) {
                    Stripe.Setup.Attempts.API.Router()
                }
                URLRouting.Route(.case(Stripe.API.cases.payouts)) {
                    Stripe.Payouts.API.Router()
                }
                URLRouting.Route(.case(Stripe.API.cases.refunds)) {
                    Stripe.Refunds.API.Router()
                }
                URLRouting.Route(.case(Stripe.API.cases.confirmationToken)) {
                    Stripe.ConfirmationToken.API.Router()
                }
                URLRouting.Route(.case(Stripe.API.cases.tokens)) {
                    Stripe.Tokens.API.Router()
                }
                URLRouting.Route(.case(Stripe.API.cases.paymentMethods)) {
                    Stripe.PaymentMethods.API.Router()
                }
                URLRouting.Route(.case(Stripe.API.cases.products)) {
                    Stripe.Products.API.Router()
                }
                URLRouting.Route(.case(Stripe.API.cases.checkout)) {
                    Stripe.Checkout.API.Router()
                }
                URLRouting.Route(.case(Stripe.API.cases.paymentLinks)) {
                    Stripe.PaymentLinks.API.Router()
                }
                URLRouting.Route(.case(Stripe.API.cases.billing)) {
                    Stripe.Billing.API.Router()
                }
                //                URLRouting.Route(.case(Stripe.API.capital)) {
                //                    Capital.API.Router()
                //                }
                //                URLRouting.Route(.case(Stripe.API.connect)) {
                //                    Connect.API.Router()
                //                }
                //                URLRouting.Route(.case(Stripe.API.fraud)) {
                //                    Fraud.API.Router()
                //                }
                //                URLRouting.Route(.case(Stripe.API.issuing)) {
                //                    Issuing.API.Router()
                //                }
                //                URLRouting.Route(.case(Stripe.API.terminal)) {
                //                    Terminal.API.Router()
                //                }
                //                URLRouting.Route(.case(Stripe.API.treasury)) {
                //                    Treasury.API.Router()
                //                }
                //                URLRouting.Route(.case(Stripe.API.entitlements)) {
                //                    Entitlements.API.Router()
                //                }
                //                URLRouting.Route(.case(Stripe.API.sigma)) {
                //                    Sigma.API.Router()
                //                }
                //                URLRouting.Route(.case(Stripe.API.reporting)) {
                //                    Reporting.API.Router()
                //                }
                //                URLRouting.Route(.case(Stripe.API.financial_Connections)) {
                //                    Financial_Connections.API.Router()
                //                }
                //                URLRouting.Route(.case(Stripe.API.tax)) {
                //                    Tax.API.Router()
                //                }
                //                URLRouting.Route(.case(Stripe.API.identity)) {
                //                    Identity.API.Router()
                //                }
                //                URLRouting.Route(.case(Stripe.API.crypto)) {
                //                    Crypto.API.Router()
                //                }
                //                URLRouting.Route(.case(Stripe.API.climate)) {
                //                    Climate.API.Router()
                //                }
                //                URLRouting.Route(.case(Stripe.API.forwarding)) {
                //                    Forwarding.API.Router()
                //                }
                //                URLRouting.Route(.case(Stripe.API.webhooks)) {
                //                    Webhooks.API.Router()
                //                }
            }
        }
    }
}
