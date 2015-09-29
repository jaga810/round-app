require 'rails_helper'

RSpec.describe "rounds/edit", type: :view do
  before(:each) do
    @round = assign(:round, Round.create!(
      :practice_id => 1
    ))
  end

  it "renders the edit round form" do
    render

    assert_select "form[action=?][method=?]", round_path(@round), "post" do

      assert_select "input#round_practice_id[name=?]", "round[practice_id]"
    end
  end
end
