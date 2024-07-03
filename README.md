# TheFreeDictionary

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
require 'the-free-dictionary'

dictionary = TheFreeDictionary::English.new
result = dictionary.find('glossary')

puts "Sound URL: #{result[:sound]}"
puts "Transcription: #{result[:transcription]}"
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

Each class has a `find` method that takes a word as an argument and returns a hash with `:sound` and `:transcription`.
