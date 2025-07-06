//
//  Circle_of_deathTests.swift
//  Circle of deathTests
//
//  Created by Tim Röckemann on 06.07.25.
//

import Testing
@testable import Circle_of_death

struct Circle_of_deathTests {

    @Test func testDeckContains52Cards() async throws {
        #expect(Card.deck.count == 52)
    }

}
