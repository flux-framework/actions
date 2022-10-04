# Flux Install

The Flux install action takes the following parameters:

| Name | Description | Default |
|------|-------------|---------|
|version| The version (release) of Flux to install from [Releases](https://github.com/flux-framework/flux-core/releases) | latest |
|install_root| Where to install Flux | /usr/local |
| sudo | Use sudo (e.g., for a native runner) | true |

We will try to have action releases that correspond to Flux releases. Also note that Flux
will install with the Python it finds first on the `$PATH` so make sure to load an environment
or otherwise change your Python path before install.

## Example

Here is an example of using the install action:

```
name: Run Flux Workflow
on:
  pull_request: []

jobs:
  install-flux:
    name: Install Flux
    runs-on: ubuntu-latest
    steps:
      - name: Checkout Repository
        uses: actions/checkout@v3
      - name: Install Flux
        uses: researchapps/flux-actions/install@main
      - name: Run Flux
        run: flux start echo "Hello am I working?"
```
