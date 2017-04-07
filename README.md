# cucumber

[Microcuke-Cr](https://github.com/drhuffman12/microcuke-cr) Crystal-lang implementation of [Microcuke](https://github.com/cucumber/microcuke). Microcuke-Cr is based on the [Zearin's refactor/unpromise branch](https://github.com/Zearin/microcuke/tree/refactor/unpromise).

Microcuke is a tiny Cucumber implementation in 500 SLOC, based on Gherkin3.

## STATUS

- [x] boolean_expression_parser.js
- [ ] glue
- [ ] glue_loader
- [ ] hook
- [ ] pickle_loader
- [ ] pretty_plugin
- [ ] sequential_test_case_executor
- [ ] source_reader
- [ ] step_definition
- [ ] tag_filter
- [ ] test_case
- [ ] test_step

## Installation

Add this to your application's `shard.yml`:

```yaml
dependencies:
  cucumber:
    github: drhuffman12/microcuke-cr
```

## Usage

```crystal
require "cucumber"
```

TODO: Write usage instructions here

## Development

TODO: Write development instructions here

## Contributing

1. Fork it ( https://github.com/drhuffman12/microcuke-cr/fork )
2. Create your feature branch (git checkout -b my-new-feature)
3. Commit your changes (git commit -am 'Add some feature')
4. Push to the branch (git push origin my-new-feature)
5. Create a new Pull Request

## Contributors

- [[drhuffman12]](https://github.com/drhuffman12) Daniel Huffman - creator, maintainer
