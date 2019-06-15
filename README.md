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

1. `./prep-bottles -t=$tag -f=$formula`
    * This script currently assumes Sierra as the build platform.
2. Bottles have been built in `./bottles` and the formula has been updated.

### Distributing Bottles

1. Build the bottles.
    * See: **Building Bottles**
2. Release them
    * `./release -t=$tag -publish $file1 $file2 $file3`
