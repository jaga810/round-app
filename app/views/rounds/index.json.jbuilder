json.array!(@rounds) do |round|
  json.extract! round, :id, :practice_id
  json.url round_url(round, format: :json)
end
