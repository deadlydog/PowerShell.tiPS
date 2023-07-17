# 002 - Where to store tips

## Status

Accepted 2023-07-16

## Context

We need to decide where to store the tips that will be displayed by this module.
Possible options include:

- One or more files in the module directory
- An external service or database

### Files in the module

Pros:

- This is the simplest option; no additional infrastructure is required.
- Allows the module to be used without an internet connection.
  - Do not need to worry about network connectivity or latency issues, or users being behind a firewall.

Cons:

- Requires users to update the module to get new tips.

### An external service or database

Pros:

- Allows tips to be added and removed without users having to update the module.

Cons:

- Requires additional infrastructure to be set up.
  - More maintenance required.
  - Possible downtime.
  - Potentially costs money to host.

## Decision

We are going to store the tips in one or more files in the module directory.

## Consequences

Users will need to update the module to get new tips.
