//
//  Products API.swift
//  coenttb-stripe
//
//  Created by Coen ten Thije Boonkkamp on 05/01/2025.
//

import Foundation
import Stripe_Types_Models
import Stripe_Types_Shared
import URLRouting

extension Stripe.Products {
    @Cases
    public enum API: Equatable, Sendable {
        case products(Stripe.Products.Products.API)
        case prices(Stripe.Products.Prices.API)
        case coupons(Stripe.Products.Coupons.API)
        case promotionCodes(Stripe.Products.PromotionCodes.API)
        case discounts(Stripe.Products.Discounts.API)
        case taxRates(Stripe.Products.TaxRates.API)
        case shippingRates(Stripe.Products.ShippingRates.API)
    }
}
extension Stripe.Products.API {
    public struct Router: ParserPrinter, Sendable {
        public init() {}

        public var body: some URLRouting.Router<Stripe.Products.API> {
            OneOf {
                URLRouting.Route(.case(Stripe.Products.API.cases.products)) {
                    Stripe.Products.Products.API.Router()
                }

                URLRouting.Route(.case(Stripe.Products.API.cases.prices)) {
                    Stripe.Products.Prices.API.Router()
                }

                URLRouting.Route(.case(Stripe.Products.API.cases.coupons)) {
                    Stripe.Products.Coupons.API.Router()
                }

                URLRouting.Route(.case(Stripe.Products.API.cases.promotionCodes)) {
                    Stripe.Products.PromotionCodes.API.Router()
                }

                URLRouting.Route(.case(Stripe.Products.API.cases.discounts)) {
                    Stripe.Products.Discounts.API.Router()
                }

                URLRouting.Route(.case(Stripe.Products.API.cases.taxRates)) {
                    Stripe.Products.TaxRates.API.Router()
                }

                URLRouting.Route(.case(Stripe.Products.API.cases.shippingRates)) {
                    Stripe.Products.ShippingRates.API.Router()
                }
            }
        }
    }
}
