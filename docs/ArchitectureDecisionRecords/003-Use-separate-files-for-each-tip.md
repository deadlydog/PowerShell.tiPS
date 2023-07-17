# 003 - Use separate files for each tip

## Status

Accepted 2023-07-16

## Context

We are going to store the tips as files in the module directory.
We need to decide if we store them in a single large file, or in separate files.

### Single file

Pros:

- Only one file to read from, which reduces latency.

Cons:

- All tips must be read into memory at once.
  - This could be a problem if there are a large number of tips.
- Very likely that contributors will run into merge conflicts when adding tips to the file.

### Multiple files

Pros:

- PRs to add tips will be less likely to have merge conflicts, and should always be additive, meaning less chance for regressions.

Cons:

- Reading from multiple files may increase the latency of initializing the module.
  - We may be able to mitigate this by combing the files into a single file when the module is packaged.

## Decision

To make it easier for contributors to add tips, we will store each tip in a separate file.
This also allows us to defer the decision of combining all of the tips into a single file until we have a better idea of how many tips there will be, and data around how long it takes to read all of the tips.

## Consequences

We may need a step in the build process to combine all of the tips into a single file.
