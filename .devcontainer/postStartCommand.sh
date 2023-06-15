#!/usr/bin/env bash

# `postCreateCommand.sh` - run commands each time the codesapce starts
# ====================================================================
# Per the [docs](https://docs.github.com/en/codespaces/developing-in-codespaces/forwarding-ports-in-your-codespace#sharing-a-port), a private port requires an access token that's VSCode automatically sends over (I assume) HTTP/HTTPS. Therefore, the HTTP port (port 27377) the CodeChat Server uses works when private. In contrast, a public port doesn't require the token, so I'm guessing  this works with non-HTTP protocols such as websockets. When this is private, the websocket never connects. The code below configures this.
#
# However, there are several challenges in setting a port's visibility:
#
# - Note that while I'd like to put this in the `forwardPorts` and `portsAttributes` section of `devcontainer.json`, that file doesn't support setting a port's visibility (see this [discussion](https://github.com/community/community/discussions/10394)). 
# - Another option: call `gh codespace ports forward` then `gh codespace ports visibility`. However, this fails: `gh codespace ports forward` never returns. Running `gh codespace ports forward &` works, but also owns the port, which prevents the CodeChat Server from using it.
# - Yet another option: forward the port in `devcontainer.json`, then run `gh codespace ports visibility` here. However, that fails, probably due to a timing issue: the port mapping seems to occur after this script runs, causing the visibility setting to be lost.
#
# So, first wait for the port to be forwarded by the codespace, based on setting in `devcontainer.json`.
until gh codespace ports -c $CODESPACE_NAME | grep 27378
do
    echo "Waiting for port 27378 to be mapped..."
    sleep 1
done

# Now the ports is mapped, so we can successfully change its visibility. See the [docs](https://cli.github.com/manual/gh_codespace_ports_visibility), this is another way to make a port's visibility public.
gh codespace ports visibility 27378:public -c $CODESPACE_NAME
