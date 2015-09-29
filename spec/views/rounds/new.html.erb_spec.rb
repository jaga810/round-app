require 'rails_helper'

RSpec.describe "rounds/new", type: :view do
  before(:each) do
    assign(:round, Round.new(
      :practice_id => 1
    ))
  end

  it "renders new round form" do
    render

    assert_select "form[action=?][method=?]", rounds_path, "post" do

      assert_select "input#round_practice_id[name=?]", "round[practice_id]"
    end
  end
end
