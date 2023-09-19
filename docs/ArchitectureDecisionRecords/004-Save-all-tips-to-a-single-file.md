# 004 - Save all tips to a single file

## Status

Accepted 2023-08-09

## Context

In the previous ADR we decided that each tip would be stored in a separate file to make contributing new tips easier.
We need to decide if we keep them in separate files when the module ships, or if we combine all of the tips into a single file when building the module.

### Performance test

I did a test of creating many files on my machine and reading them in individually, as well as combining them into a single json file and reading the same information in via a single file using `ConvertFrom-Json`.

Results (in milliseconds):

| Number of files | Time to read all files | Time to read single file |
| --------------- | ---------------------- | ------------------------ |
| 10              | 99                     | 9                        |
| 100             | 604                    | 11                       |
| 1000            | 5420                   | 19                       |
| 10000           | 59319                  | 146                      |

## Decision

We will combine all of the tips into a single file when building the module.
This will help keep the module startup/initialization time down, which is very important since this module may be loaded on every new PowerShell session.

## Consequences

Additional steps will be required in the module's build process to combine all of the tips into a single file.
