# Picket

Picket is a free and lightweight web site monitoring application. Consider it your own wasitup.com: "Get a notice when your web page goes down."

A rewrite based on [rails version](https://github.com/siuying/picket).

## Requirements

- Ruby 1.9.3
- Sinatra
- ActiveRecord supported database

This app work on heroku!

## Basic Setup

- Checkout this repository
- Install dependencies by running command: ```bundle install```
- Edit the configuartion file ```config/application.yml```
  - ```sites```: array of URL to be checked
  - ```interval```: time for each requests being fired, default "1m"
  - ```http_timeout```: timeout of http request
- Setup database
  - ```rake db:migrate```
- Run the applications by running command: foreman start -p 3000
- Open the browser at http://localhost:3000/

##  License

    The MIT License

    Copyright (c) 2013 Francis Chong

    Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

    The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

    THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.