# ruby-cleantalk

API to have CleanTalk anti-spam on Ruby

## Install

Install via bundler

    gem 'cleantalk'

## Usage

## Authentication

The easiest way to configure the authentication is to set the API key globally. You can also set it on each request.

```ruby
require 'cleantalk'

Cleantalk.auth_key = 'ur_api_key'
```

## Check user registration

See https://cleantalk.org/help/api-check-newuser

```ruby
require 'cleantalk'

request = Cleantalk::CheckNewuser.new({
  auth_key: 'ur_api_key',            # Required if not defined via Cleantalk.auth_key. the API Key
  sender_email: 'test@example.org',  # Required: The email used by the user
  sender_ip: '127.0.0.1',            # Required: The IP used by the user
  js_on: 1,                          # Required: 1 if the user has javascript enabled, 0 otherwise
  submit_time: 11,                   # Required: Time spend you submit the request in seconds
  sender_nickname: 'test nickname',  # Optional: The nickname used by the user
})

request.allowed? # => true or false
request.result   # => <Object Cleantalk::CheckNewuserResult> with all response data
```

Depending of your use case, you can also mutate the request:

```ruby
require 'cleantalk'

request = Cleantalk::CheckNewuser.new({ auth_key: 'ur_api_key', sender_email: 'test@example.org' })
request.sender_ip       = '127.0.0.1'
request.sender_nickname = 'test nickname'
request.js_on           = 1
request.submit_time     = 11
```

## Check message

See https://cleantalk.org/help/api-check-message

```ruby
require 'cleantalk'

request = Cleantalk::CheckMessage.new({
  auth_key: 'ur_api_key',           # Required if not defined via Cleantalk.auth_key. the API Key
  sender_email: 'test@example.org', # Required: The email used by the user
  sender_ip: '127.0.0.1',           # Required: The IP used by the user
  js_on: 1,                         # Required: 1 if the user has javascript enabled, 0 otherwise
  submit_time: 11,                  # Required: Time spend you submit the request in seconds
  message: '<p>Hello World!</p>'    # Required: The text of the message
  sender_nickname: 'test nickname', # Optional: The nickname used by the user
})

request.allowed? # => true or false
request.result   # => <Object Cleantalk::CheckMessageResult> with all response data
```

## IP Info

See https://cleantalk.org/help/api-ip-info-country-code

```ruby
require 'cleantalk'

request = Cleantalk::IpInfo.new({
  ip: '127.0.0.1',           # Required: The IP to get info from
})

request.result   # => <Object Cleantalk::IpInfoResult> with all response data
```

## Send Feedback

See https://cleantalk.org/help/api-send-feedback

```ruby
require 'cleantalk'

request = Cleantalk::SendFeedback.new({
  auth_key: 'ur_api_key',                           # Required if not defined via Cleantalk.auth_key. the API Key
  feedback: [['requestid1', 1], ['requestid2', 0]] # Required: the feedback to send: 0 if it's spam, 1 if not spam
})

request.result   # => <Object Cleantalk::SendFeedbackResult> with all response data
```
