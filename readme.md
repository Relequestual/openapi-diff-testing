# Testing OpenAPI diffing tools!

## Intro

Using the Tran Travel OpenAPI, making changes to it, and then testing various OpenAPI diffing tooling.

The train travel API OpenAPI example file was provided by Bump.sh and used under licence.
CC-BY-NC-SA-4.0
Sourced at https://github.com/bump-sh-examples/train-travel-api

## Requirements

- [Open API Overlays](https://github.com/lornajane/openapi-overlays-js) installed globally per install instructions.
- [OASDiff](https://github.com/tufin/oasdiff)
- [OpenAPI Changes](https://github.com/pb33f/openapi-changes)

## Useage

Prepare the OADs from the baseline Train Travel OAD in 3.0, and generate the tests by applying the Overlays.
`prepare-oad.sh ./baseline-oads/openapi-3.0.yaml`

Run tests for all the tools.
`run-tests.sh -a ./prepared-oads/openapi-3.0.yaml`

Check `results` folder.

An empty file means no diff was found.

## Other information and details

3.1.0 version of the OAD downgraded to 3.0.3 using https://github.com/apiture/openapi-down-convert

I had to manually remove unsupported keywords, such as exclusiveMinimum, per (documentation)[https://github.com/apiture/openapi-down-convert?tab=readme-ov-file#unsupported-down-conversions] - Cannot use overlays to remove such things. Could use [AlterSchema](https://github.com/sourcemeta-research/alterschema) if a conversion was written.

Main differences are removal of webhooks and only allowing one example rather than multiple.

Writing test cases using [OpenAPI Overlays](https://github.com/OAI/Overlay-Specification).
Apply the overlays to generate the tests.
https://github.com/lornajane/openapi-overlays-js

The tests are only written for 3.0, but separate tests could be written for 3.1.

### OpenAPI Diffing tools used (so far)

https://github.com/pb33f/openapi-changes - 0.0.69

`openapi-changes summary <baseline> <changed>`

https://github.com/tufin/oasdiff - 1.10.27

`oasdiff changelog <baseline> <changed>`


### Further work

- Test for OAS 3.1.
  Not many tools currently even claim support for 3.1, so there isn't much value in testing this today for the effort required.

### Other tools used

https://jsonpathfinder.com
