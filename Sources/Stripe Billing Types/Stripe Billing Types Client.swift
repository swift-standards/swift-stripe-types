//
//  Products Client.swift
//  coenttb-stripe
//
//  Created by Coen ten Thije Boonkkamp on 05/01/2025.
//

import Foundation
import Stripe_Types_Models
import Stripe_Types_Shared

extension Stripe.Billing {
    public struct Client: Sendable {
        //    public let credit_Note: Billing_Credit_Note.Client
        //    public let customer_Balance_Transaction: Billing_Customer_Balance_Transaction.Client
        public let customer_Portal_Session: Stripe.Billing.Customer.Portal.Session.Client
        //    public let customer_Portal_Configuration: Billing_Customer_Portal_Configuration.Client
        //    public let invoices: Billing_Invoices.Client
        //    public let invoice_Items: Billing_Invoice_Items.Client
        //    public let invoice_Line_Item: Billing_Invoice_Line_Item.Client
        //    public let invoice_Rendering_Templates: Stripe_Billing_Invoice_Rendering_Templates_Types.Client
        //    public let alerts: Billing_Alerts.Client
        //    public let meters: Billing_Meters.Client
        //    public let meter_Events: Billing_Meter_Events.Client
        //    public let meter_Eventsv2: Billing_Meter_Eventsv2.Client
        //    public let meter_Event_Adjustment: Billing_Meter_Event_Adjustment.Client
        //    public let meter_Event_Adjustmentv2: Billing_Meter_Event_Adjustmentv2.Client
        //    public let meter_Event_Streamv2: Billing_Meter_Event_Streamv2.Client
        //    public let meter_Event_Summary: Billing_Meter_Event_Summary.Client
        //    public let credit_Grant: Billing_Credit_Grant.Client
        //    public let credit_Balance_Summary: Billing_Credit_Balance_Summary.Client
        //    public let credit_Balance_Transaction: Billing_Credit_Balance_Transaction.Client
        //    public let plans: Billing_Plans.Client
        //    public let quote: Billing_Quote.Client
        public let subscriptions: Stripe.Billing.Subscriptions.Client
        //    public let subscription_Items: Billing_Subscription_Items.Client
        public let subscriptionSchedule: Stripe.Billing.Subscription.Schedule.Client
        //    public let tax_IDs: Billing_Tax_IDs.Client
        //    public let test_Clocks: Billing_Test_Clocks.Client
        //    public let usage_Records: Billing_Usage_Records.Client
        //    public let usage_Record_Summary: Billing_Usage_Record_Summary.Client

        public init(
            customer_Portal_Session: Stripe.Billing.Customer.Portal.Session.Client,
            subscriptions: Stripe.Billing.Subscriptions.Client,
            subscriptionSchedule: Stripe.Billing.Subscription.Schedule.Client
        ) {
            self.customer_Portal_Session = customer_Portal_Session
            self.subscriptions = subscriptions
            self.subscriptionSchedule = subscriptionSchedule
        }
    }
}
