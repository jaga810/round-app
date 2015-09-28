json.array!(@players) do |player|
  json.extract! player, :id, :name, :circle_id, :gender
  json.url player_url(player, format: :json)
end
