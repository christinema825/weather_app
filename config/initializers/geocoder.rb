Geocoder.configure(
    lookup: :google,
    api_key: ENV['GOOGLE_GEOCODING_API_KEY'],
    units: :imperial, # Use kilometers
    language: :en, # Language preference
    use_https: true, # Use HTTPS for requests
    http_proxy: nil, # Specify a proxy if needed
    https_proxy: nil, # Specify a proxy if needed
    cache: Rails.cache, # Use Rails cache
    cache_prefix: 'geocoder:' # Cache prefix
  )