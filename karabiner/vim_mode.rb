('a'..'z').each do |c|
  puts <<-JSON
  {
    "from": { "key_code": "#{c}" }, "to": [ { "key_code": "vk_none" } ],
    "type": "basic",
    "conditions": [ { "type": "frontmost_application_unless", "bundle_identifiers": [ "com\\.googlecode\\.iterm2", "com\\.apple\\.Terminal" ] } ]
  },
  JSON
end
