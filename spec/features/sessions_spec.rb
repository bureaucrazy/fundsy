require 'rails_helper'

RSpec.feature "Sessions", type: :feature do
  describe "signing in" do
    let!(:user) {create(:user)}

    context "successful login" do
      it "redirects to home page, show a message 'Logged in' and shows user full name" do
        visit new_session_path

        fill_in "Email", with: user.email
        fill_in "Password", with: user.password
        click_button "Sign In"

        expect(current_path).to eq(root_path)
        expect(page).to have_text /Logged in/i
        expect(page).to have_text /#{user.full_name}/i
      end
    end
    context "unsuccessful login" do
      it "stays on the same page and see a message saying can't login and don't see your name on the page" do
        visit new_session_path

        # in this case it'll look for an input field with an id email.
        fill_in "email", with: user.password
        fill_in "Password", with: user.email
        click_button "Sign In"

        expect(current_path).to eq(sessions_path)
        expect(page).to have_text /Wrong credentials/i
        expect(page).not_to have_text /#{user.full_name}/i

      end
    end
  end
end
