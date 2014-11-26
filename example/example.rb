require_relative "../lib/oklink/api"
require_relative "../lib/oklink/oklink"

key    = ""
secret = ""
client = Oklink::Client.new(key, secret)
p client.buttonsListButton
