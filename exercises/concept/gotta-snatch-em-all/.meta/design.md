# Design

## Goal

The Goal is to learn how to use sets.

## Learning objectives

- Know what a set is
- Build: empty, singleton, insert, remove
- Query: member, isEmpty, size
- Combine: union, intersect, diff
- Lists: toList, fromList
- Transform: filter, partition

## Out of scope

- Transform: map, foldl, foldr

## Concepts

The concepts this exercise unlock are:

- set

## Prerequisites

- booleans
- tuples
- lists
- comparison

## Analyzer

Make sure that:

- (actionable) `newCollection` uses `Set.singleton`
- (essential) `addCard` uses `Set.member` and `Set.insert`
- (essential) `tradeCard` uses `Set.member`, `Set.insert` and `Set.remove`
- (essential) `removeDuplicates` uses `Set.fromList` and `Set.toList`
- (essential) `extraCards` uses `Set.diff` and `Set.size`
- (essential) `boringCards` uses `Set.intersect` and `Set.toList`
- (actionable) `boringCards` uses `List.foldl` or `List.foldr`
- (essential) `totalCards` uses `Set.union` and `Set.size`
- (actionable) `totalCards` uses `List.foldl` or `List.foldr`
- (essential) `splitShinyCards` uses `Set.partition` and `Set.toList`
- (actionable) `splitShinyCards` uses `String.startsWith`
