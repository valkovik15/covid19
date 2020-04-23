# Covid19

Ruby wrapper for https://covid19-api.com/

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'covid19', git: 'https://github.com/valkovik15/covid19'
```

And then execute:

    $ bundle install

## Usage
```ruby
require 'covid19'

#Configure client before usage with your key, other options include host and user-agent
Covid19.configure do |config|
  config.key = 'your-api-key'
end
# Get list of available countries
Covid19.countries_list
# Get openAPI documentation 
Covid19.documentation
# You can gain latest data on number of infected for the whole world 
Covid19.world_totals
# for certain country
Covid19.country_totals(country: 'Belarus')
Covid19.country_totals(country: 'By')
# or for all of them
Covid19.all_countries_totals
# You can get report on number of infected upon given date 
Covid19.world_report(date: Date.today.prev_day)
Covid19.country_report(date: Date.today.prev_day, country: 'by')
Covid19.country_report(date: Date.today.prev_day, country: 'Belarus')
Covid19.all_countries_report(date: Date.new(2020, 4, 21))

```


