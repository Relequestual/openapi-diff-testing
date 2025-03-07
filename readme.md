# Testing OpenAPI diffing tools!

## Intro

Using the Tran Travel OpenAPI, making changes to it, and then testing various OpenAPI diffing tooling.

The train travel API OpenAPI example file was provided by Bump.sh and used under licence.
CC-BY-NC-SA-4.0
Sourced at https://github.com/bump-sh-examples/train-travel-api

## Requirements

- [Open API Overlays](https://github.com/lornajane/openapi-overlays-js) installed globally per install instructions.

### Optional requirements
At least one of...

- [OASDiff](https://github.com/tufin/oasdiff)
- [OpenAPI Changes](https://github.com/pb33f/openapi-changes)
- [OpenAPI Diff](https://github.com/OpenAPITools/openapi-diff)
- [Optic](https://github.com/opticdev/optic)
- [Open API Comparator](https://github.com/criteo/openapi-comparator)
- [Bump CLI](https://github.com/bump-sh/cli)
- [Speakeasy](https://github.com/speakeasy-api/speakeasy)


Some tools will require their toolchain to work.
- Node
- .Net
- Java

For OpenAPITools/openapi-diff, I installed via brew.
`brew install openapi-diff`
You may also install and use via docker, but you will have to modify the CLI call.

For Open API Comparator, while dotnet can be installed via brew, it asked for my system password.
So I opted for a manual install from [.net downloads](https://dotnet.microsoft.com/en-us/download).

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

https://github.com/OpenAPITools/openapi-diff - 2.0.1

`openapi-diff <baseline> <changed>`

https://github.com/opticdev/optic - 1.0.6

`optic diff <baseline> <changed>`

(This is a little noisy on the output as it doesn't seem to allow for disabling checks. https://github.com/opticdev/optic/issues/2879)

https://github.com/criteo/openapi-comparator - 0.8.1

`openapi-compare -o <baseline> -n <changed>`

https://github.com/bump-sh/cli - 2.9.2

Note, this calls an API! So only use this on OADs you don't mind sharing with Bump.sh

`bump diff <baseline> <changed>`

https://bitbucket.org/atlassian/openapi-diff - 0.23.7

When installed globally, this happens to have the same name as openapi-diff above.
I had Volta installed, and it captures global installs with npm.
As such, I used the following command, but you may need to modify it once you have it installed.

I intially got a small number of results, but after fixing a validation issue and then re-running the script, the process hanged.
I can't even run ANY of the tests.
Open to PRs!

`volta run openapi-diff <baseline> <changed>`

https://github.com/speakeasy-api/speakeasy - 1.487.1

Seems to be identical to OpenAPI-changes by bp33f.

`speakeasy openapi diff --old <baseline --new <changed>`



### Further work

- Test for OAS 3.1.
  Not many tools currently even claim support for 3.1, so there isn't much value in testing this today for the effort required.

### Other tools used

https://jsonpathfinder.com

