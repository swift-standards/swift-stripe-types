//
//
//  File.swift
//  coenttb-web
//
//  Created by Coen ten Thije Boonkkamp on 10/09/2024.
//

// Core Resources
import Stripe_Balance_Transactions_Types
import Stripe_Balance_Types
// Features
import Stripe_Billing_Types
import Stripe_Charges_Types
// import Stripe_Capital_Types
import Stripe_Checkout_Types
import Stripe_Confirmation_Token_Types
import Stripe_Customer_Session_Types
import Stripe_Customers_Types
import Stripe_Disputes_Types
import Stripe_Event_Destinations_Types
import Stripe_Events_Types
import Stripe_File_Links_Types
import Stripe_Files_Types
import Stripe_Mandates_Types
import Stripe_Payment_Intents_Types
// import Stripe_Climate_Types
// import Stripe_Connect_Types
// import Stripe_Crypto_Types
// import Stripe_Entitlements_Types
// import Stripe_Financial_Connections_Types
// import Stripe_Forwarding_Types
// import Stripe_Fraud_Types
// import Stripe_Identity_Types
// import Stripe_Issuing_Types
import Stripe_Payment_Link_Types
import Stripe_Payment_Methods_Types
import Stripe_Payouts_Types
import Stripe_Products_Types
import Stripe_Refunds_Types
import Stripe_Setup_Attempts_Types
import Stripe_Setup_Intents_Types
import Stripe_Tokens_Types

// import Stripe_Reporting_Types
// import Stripe_Sigma_Types
// import Stripe_Tax_Types
// import Stripe_Terminal_Types
// import Stripe_Treasury_Types
// import Stripe_Webhooks_Types

// public var stripeJsScript: some HTML { script().src("https://js.stripe.com/v3/") }

extension Stripe {
    public struct Client: Sendable {
        public var balance: Stripe.Balance.Client
        public var balanceTransactions: Stripe.BalanceTransactions.Client
        public var charges: Stripe.Charges.Client
        public var customers: Stripe.Customers.Client
        public var customerSessions: Stripe.Customers.Customer.Sessions.Client
        public var disputes: Stripe.Disputes.Client
        public var events: Stripe.Events.Client
        public var files: Stripe.Files.Client
        public var fileLinks: Stripe.FileLinks.Client
        public var mandates: Stripe.Mandates.Client
        public var paymentIntents: Stripe.PaymentIntents.Client
        public var setupIntents: Stripe.Setup.Intents.Client
        public var setupAttempts: Stripe.Setup.Attempts.Client
        public var payouts: Stripe.Payouts.Client
        public var refunds: Stripe.Refunds.Client
        public var confirmationToken: Stripe.ConfirmationTokenClient
        public var tokens: Stripe.Tokens.Client
        public var paymentMethods: Stripe.PaymentMethods.Client
        public var paymentLinks: Stripe.PaymentLinks.Client
        public var products: Stripe.Products.Client
        public var checkout: Stripe.Checkout.Client
        public var billing: Stripe.Billing.Client

        public init(
            balance: Stripe.Balance.Client,
            balanceTransactions: Stripe.BalanceTransactions.Client,
            charges: Stripe.Charges.Client,
            customers: Stripe.Customers.Client,
            customerSessions: Stripe.Customers.Customer.Sessions.Client,
            disputes: Stripe.Disputes.Client,
            events: Stripe.Events.Client,
            files: Stripe.Files.Client,
            fileLinks: Stripe.FileLinks.Client,
            mandates: Stripe.Mandates.Client,
            paymentIntents: Stripe.PaymentIntents.Client,
            setupIntents: Stripe.Setup.Intents.Client,
            setupAttempts: Stripe.Setup.Attempts.Client,
            payouts: Stripe.Payouts.Client,
            refunds: Stripe.Refunds.Client,
            confirmationToken: Stripe.ConfirmationTokenClient,
            tokens: Stripe.Tokens.Client,
            paymentMethods: Stripe.PaymentMethods.Client,
            paymentLinks: Stripe.PaymentLinks.Client,
            products: Stripe.Products.Client,
            checkout: Stripe.Checkout.Client,
            billing: Stripe.Billing.Client
        ) {
            self.balance = balance
            self.balanceTransactions = balanceTransactions
            self.charges = charges
            self.customers = customers
            self.customerSessions = customerSessions
            self.disputes = disputes
            self.events = events
            self.files = files
            self.fileLinks = fileLinks
            self.mandates = mandates
            self.paymentIntents = paymentIntents
            self.setupIntents = setupIntents
            self.setupAttempts = setupAttempts
            self.payouts = payouts
            self.refunds = refunds
            self.confirmationToken = confirmationToken
            self.tokens = tokens
            self.paymentMethods = paymentMethods
            self.paymentLinks = paymentLinks
            self.products = products
            self.checkout = checkout
            self.billing = billing
        }
    }
}
