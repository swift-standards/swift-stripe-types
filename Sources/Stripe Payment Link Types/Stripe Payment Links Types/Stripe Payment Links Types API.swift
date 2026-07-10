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

// This wrapper module directly uses the API from Stripe_Payment_Link_Types
// No additional wrapping needed since PaymentLinks is already the namespace
public typealias API = Stripe.PaymentLinks.API
