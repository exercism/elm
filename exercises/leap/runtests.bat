@echo off
for %%f in (*Tests.elm) do (
  elm-make %%f --yes --output build.js && node build.js
)
