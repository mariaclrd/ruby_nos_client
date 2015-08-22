#!/usr/bin/env ruby
# More info at https://github.com/guard/guard#readme

scope groups: [:test]

group :test do
  options = {
    all_after_pass: true,
    all_on_start: true,
    cmd: 'bundle exec rspec -f doc',
  }

  guard('rspec', options) do
    watch(%r{(lib/.*|config/.*|spec/.*)\.rb}) do |f|
      'spec'
    end
  end
end

