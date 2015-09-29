require 'rails_helper'

RSpec.describe "practices/new", type: :view do
  before(:each) do
    assign(:practice, Practice.new(
      :circle_id => 1
    ))
  end

  it "renders new practice form" do
    render

    assert_select "form[action=?][method=?]", practices_path, "post" do

      assert_select "input#practice_circle_id[name=?]", "practice[circle_id]"
    end
  end
end
