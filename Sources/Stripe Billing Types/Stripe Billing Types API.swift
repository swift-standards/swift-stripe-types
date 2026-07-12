//
//  Billing API.swift
//  coenttb-stripe
//
//  Created by Coen ten Thije Boonkkamp on 05/01/2025.
//

import Foundation
import Stripe_Types_Models
import Stripe_Types_Shared
import URLRouting

extension Stripe.Billing {
    @Cases
    public enum API: Equatable, Sendable {
        //    case credit_Note(Stripe.Billing.Credit_Note.API)
        //    case customer_Balance_Transaction(Stripe.Billing.Customer_Balance_Transaction.API)
        case customer_Portal_Session(Stripe.Billing.Customer.Portal.Session.API)
        //    case customer_Portal_Configuration(Stripe.Billing.Customer_Portal_Configuration.API)
        //    case invoices(Stripe.Billing.Invoices.API)
        //    case invoice_Items(Stripe.Billing.Invoice_Items.API)
        //    case invoice_Line_Item(Stripe.Billing.Invoice_Line_Item.API)
        //    case invoice_Rendering_Templates(Stripe_Stripe.Billing.Invoice_Rendering_Templates_Types.API)
        //    case alerts(Stripe.Billing.Alerts.API)
        //    case meters(Stripe.Billing.Meters.API)
        //    case meter_Events(Stripe.Billing.Meter_Events.API)
        //    case meter_Eventsv2(Stripe.Billing.Meter_Eventsv2.API)
        //    case meter_Event_Adjustment(Stripe.Billing.Meter_Event_Adjustment.API)
        //    case meter_Event_Adjustmentv2(Stripe.Billing.Meter_Event_Adjustmentv2.API)
        //    case meter_Event_Streamv2(Stripe.Billing.Meter_Event_Streamv2.API)
        //    case meter_Event_Summary(Stripe.Billing.Meter_Event_Summary.API)
        //    case credit_Grant(Stripe.Billing.Credit_Grant.API)
        //    case credit_Balance_Summary(Stripe.Billing.Credit_Balance_Summary.API)
        //    case credit_Balance_Transaction(Stripe.Billing.Credit_Balance_Transaction.API)
        //    case plans(Stripe.Billing.Plans.API)
        //    case quote(Stripe.Billing.Quote.API)
        case subscriptions(Stripe.Billing.Subscriptions.API)
        //    case subscription_Items(Stripe.Billing.Subscription_Items.API)
        case subscriptionSchedule(Stripe.Billing.Subscription.Schedule.API)
        //    case tax_IDs(Stripe.Billing.Tax_IDs.API)
        //    case test_Clocks(Stripe.Billing.Test_Clocks.API)
        //    case usage_Records(Stripe.Billing.Usage_Records.API)
        //    case usage_Record_Summary(Stripe.Billing.Usage_Record_Summary.API)
    }
}

extension Stripe.Billing.API {
    public struct Router: ParserPrinter, Sendable {
        public init() {}

        public var body: some URLRouting.Router<Stripe.Billing.API> {
            OneOf {
                URLRouting.Route(.case(Stripe.Billing.API.cases.subscriptions)) {
                    Stripe.Billing.Subscriptions.API.Router()
                }

                URLRouting.Route(.case(Stripe.Billing.API.cases.customer_Portal_Session)) {
                    Stripe.Billing.Customer.Portal.Session.API.Router()
                }

                URLRouting.Route(.case(Stripe.Billing.API.cases.subscriptionSchedule)) {
                    Stripe.Billing.Subscription.Schedule.API.Router()
                }
            }
        }
    }
}
