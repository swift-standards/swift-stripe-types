//
//  Products Client.swift
//  coenttb-stripe
//
//  Created by Coen ten Thije Boonkkamp on 05/01/2025.
//

import Stripe_Types_Shared

extension Stripe.Products {
    public struct Client: Sendable {
        public let products: Stripe.Products.Products.Client
        public let prices: Stripe.Products.Prices.Client
        public let coupons: Stripe.Products.Coupons.Client
        public let promotionCodes: Stripe.Products.PromotionCodes.Client
        public let discounts: Stripe.Products.Discounts.Client
        public let taxRates: Stripe.Products.TaxRates.Client
        public let shippingRates: Stripe.Products.ShippingRates.Client

        public init(
            products: Stripe.Products.Products.Client,
            prices: Stripe.Products.Prices.Client,
            coupons: Stripe.Products.Coupons.Client,
            promotionCodes: Stripe.Products.PromotionCodes.Client,
            discounts: Stripe.Products.Discounts.Client,
            taxRates: Stripe.Products.TaxRates.Client,
            shippingRates: Stripe.Products.ShippingRates.Client
        ) {
            self.products = products
            self.prices = prices
            self.coupons = coupons
            self.promotionCodes = promotionCodes
            self.discounts = discounts
            self.taxRates = taxRates
            self.shippingRates = shippingRates
        }
    }
}
