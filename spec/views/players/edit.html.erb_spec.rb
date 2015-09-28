require 'rails_helper'

RSpec.describe "players/edit", type: :view do
  before(:each) do
    @player = assign(:player, Player.create!(
      :name => "MyString",
      :circle_id => 1,
      :gender => false
    ))
  end

  it "renders the edit player form" do
    render

    assert_select "form[action=?][method=?]", player_path(@player), "post" do

      assert_select "input#player_name[name=?]", "player[name]"

      assert_select "input#player_circle_id[name=?]", "player[circle_id]"

      assert_select "input#player_gender[name=?]", "player[gender]"
    end
  end
end
