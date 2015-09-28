require 'rails_helper'

RSpec.describe "players/new", type: :view do
  before(:each) do
    assign(:player, Player.new(
      :name => "MyString",
      :circle_id => 1,
      :gender => false
    ))
  end

  it "renders new player form" do
    render

    assert_select "form[action=?][method=?]", players_path, "post" do

      assert_select "input#player_name[name=?]", "player[name]"

      assert_select "input#player_circle_id[name=?]", "player[circle_id]"

      assert_select "input#player_gender[name=?]", "player[gender]"
    end
  end
end
