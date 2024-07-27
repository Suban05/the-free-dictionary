# TheFreeDictionary
[![Build Status](https://github.com/Suban05/the-free-dictionary/workflows/CI/badge.svg)](https://github.com/Suban05/the-free-dictionary/actions)

TheFreeDictionary is a versatile Ruby library that fetches information about words from various languages. It retrieves the pronunciation link (audio) and the transcription for a given word from [The Free Dictionary website](https://www.thefreedictionary.com).

## Features

- Fetches audio pronunciation links
- Retrieves phonetic transcription of words
- Supports multiple languages including English, French, German, Italian, Russian, Spanish, and Chinese

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'the-free-dictionary'
```

And then execute:

```shell
$ bundle install
```

Or install it yourself as:

```shell
$ gem install the-free-dictionary
```

## Usage

Here's a quick example to get you started:

```ruby
require 'the_free_dictionary'

dictionary = TheFreeDictionary::English.new
result = dictionary.find('glossary') 
# {
#  :sound => "https://img2.tfd.com/pron/mp3/en/US/st/stdyd3sjsssydsstykgk.mp3",
#  :transcription => "ˈɡlɒsərɪ"
# }
```

## Supported Languages

TheFreeDictionary provides classes for different languages:
- `TheFreeDictionary::English`
- `TheFreeDictionary::Spanish`
- `TheFreeDictionary::French`
- `TheFreeDictionary::German`
- `TheFreeDictionary::Italian`
- `TheFreeDictionary::Russian`
- `TheFreeDictionary::Chinese`

## Methods

### `find`

It finds information about a word. For example:

```ruby
dictionary = TheFreeDictionary::English.new
result = dictionary.find('glossary') 
# {
#  :sound => "https://img2.tfd.com/pron/mp3/en/US/st/stdyd3sjsssydsstykgk.mp3",
#  :transcription => "ˈɡlɒsərɪ"
# }
```

### `word_of_day`

It gets word of the day. For example:

```ruby
dictionary = TheFreeDictionary::English.new
result = dictionary.word_of_day
# {
#  :sound=>"https://img2.tfd.com/pron/mp3/en/US/st/stsdsldodfd3sgshykgk.mp3",
#  :transcription=>"ʌnˈɡeɪnlɪ",
#  :word=>"ungainly",
#  :definition=>"(adjective) Lacking grace or ease of movement or form.",
#  :synonyms=>"clumsy, clunky, gawky, unwieldy",
#  :usage=>"He was a gawky lad with long ungainly legs, but she thought he was the most handsome boy she had ever seen."
# }
```
