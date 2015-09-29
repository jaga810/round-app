require 'rails_helper'

RSpec.describe "practices/index", type: :view do
  before(:each) do
    assign(:practices, [
      Practice.create!(
        :circle_id => 1
      ),
      Practice.create!(
        :circle_id => 1
      )
    ])
  end

  it "renders a list of practices" do
    render
    assert_select "tr>td", :text => 1.to_s, :count => 2
  end
end
