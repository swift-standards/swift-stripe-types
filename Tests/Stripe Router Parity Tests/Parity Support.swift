//
//  Parity Support.swift
//  swift-stripe-types
//
//  Batch-0 wire-shape parity corpus support (url-routing-stack migration).
//

import Foundation
import Testing
import URL_Routing_Test_Support

// §A9 toolchain gate (swift-institute/Research/swift-compiler-bug-catalog.md §A9):
// every Stripe router materializes `Tagged` inside deep generic parser chains
// (`.string.representing(<Tagged ID>.self)`); on Swift 6.3.x the first
// parse/print SIGSEGVs the runner (null metadata from
// `swift_getTypeByMangledName` during witness-table instantiation — verified
// empirically for this suite on 2026-07-21, crash report
// swiftpm-testing-helper-2026-07-21-005610.ips). `.disabled(if:)`, not
// `withKnownIssue`, because the crash kills the runner. Auto-retires at the
// 6.4 toolchain move, at which point the first run RECORDS the Batch-0 corpus
// into `__Corpus__/` (Parity.fixture record-when-absent semantics).
#if compiler(<6.4)
let taggedMetadataSIGSEGV = true
#else
let taggedMetadataSIGSEGV = false
#endif

/// Compares a corpus against `__Corpus__/<name>.txt`, recording on first run.
func assertParity(
    _ corpus: String,
    fixture name: String,
    filePath: String = #filePath
) throws {
    let url = URL(fileURLWithPath: filePath)
        .deletingLastPathComponent()
        .appendingPathComponent("__Corpus__")
        .appendingPathComponent("\(name).txt")
    let outcome = try Parity.fixture(corpus, at: url)
    if case .mismatched(let diff) = outcome {
        Issue.record("Parity mismatch for \(name):\n\(diff)")
    }
}
