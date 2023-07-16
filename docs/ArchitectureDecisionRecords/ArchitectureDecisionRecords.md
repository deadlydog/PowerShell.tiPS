# Architecture Decision Records (ADR)

Here is where we log decisions we make about the architecture of the project.
Each decision will have it's own dedicated ADR file in this directory.

See the [Architecture Decision Record](https://github.com/joelparkerhenderson/architecture-decision-record) for more details of what an ADR is and common formats for it.

## Document format

The ADR file name should be prefixed with an incrementing, sequential number.
This shows the order in which decisions were made over the lifetime of the project.
e.g. `001-Use-ADRs-for-decisions.md`.

Here is an example of the sections that an ADR typically includes:

```markdown
## Status

What is the status, such as _proposed_, _accepted_, _rejected_, _superseded_, etc.? If _superseded_ by a subsequent decision, link to the subsequent decision. Include the date that the status change was made.

## Context

What is the issue that we're seeing that is motivating this decision or change? Are there any social or budgetary concerns that must be factored into the decision? Hyperlinks to supporting documentation are encouraged.

## Options Considered

What options are available to solve the aforementioned issue? What are the tradeoffs associated with each option?  Hyperlinks to supporting documentation are encouraged.

## Decision

What is the change that we're proposing and/or doing to solve the aforementioned issue?

## Consequences

What becomes easier or more difficult to do because of this change?  What are the immediate action items?

## References / Additional Reading

What individuals, teams, vendor documentation, and/or articles were consulted when gathering information throughout the decision-making process?
```

And an example of what an ADR might actually look like:

```markdown
# 001 - Record Architecture Decisions

## Status

Accepted 2022-10-28

## Context

As the project is an example of a more advanced monolith architecture, it is necessary to save all architectural decisions in one place.

## Decision

For all architectural decisions Architecture Decision Log (ADL) is created. All decisions will be recorded as Architecture Decision Records (ADR).

Each ADR will be recorded in the repository and contain following sections: __Status__, __Context__, __Options Considered__ (optional if decision is straightforward), __Decision__, __Consequences__, and __References / Additional Reading__ (optional, but strongly encouraged).

## Consequences

- All significant architectural decisions shall be recorded.
- Old decisions should be recorded with an approximate decision date.
- New decisions shall be recorded on a regular basis.
```
