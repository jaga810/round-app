json.array!(@practices) do |practice|
  json.extract! practice, :id, :circle_id
  json.url practice_url(practice, format: :json)
end
