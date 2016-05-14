#!/usr/bin/env bash
elm-make *Tests.elm --yes --output build.js && node build.js
