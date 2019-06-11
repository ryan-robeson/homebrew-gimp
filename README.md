# ryan-robeson/gimp

This Tap exists primarily to provide libgimp2.0 on macOS.

Check out my guide on [Building Resynthesizer for GIMP](https://gist.github.com/ryan-robeson/5841f712ff23c910bbbfac793c16bfad) for an example.

Hopefully this will help make compiling plugins on macOS a bit more accessible.

## How do I install these formulae?
`brew install ryan-robeson/gimp/<formula>`

Or `brew tap ryan-robeson/gimp` and then `brew install <formula>`.

Or install via URL (which will not receive updates):

```
brew install https://raw.githubusercontent.com/ryan-robeson/homebrew-gimp/master/Formula/<formula>.rb
```

## Documentation
`brew help`, `man brew` or check [Homebrew's documentation](https://docs.brew.sh).

## Maintainers

### Building Bottles

1. `brew install --build-bottle $formula`
2. Edit './prep-bottles'
    * Adjust the 'root\_url' and 'formula' variables as necessary. (Yes, this needs more automation)
3. `./prep-bottles`
    * This script currently assumes Sierra as the build platform.
4. Bottles have been built and the formula has been updated.
