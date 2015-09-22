require 'rails_helper'

RSpec.describe SessionsController, type: :controller do
  # Let will define a method called user that is accessible anywhere w/in
  # this context (or describe).
  # If you never call the method 'user', it will not create it, unless
  # you use let!
  let(:user) { create(:user) }

  # view the form that will be submitting the login email / password
  describe "#new" do
    it "renders the new template" do
      get :new
      expect(response).to render_template(:new)
    end
  end

  # receiving the email / password and logging the person in or showing error
  describe "#create" do

    context "with valid credentials" do
      before do
        # Given
        # (see the 'let(:user)' above)
        # When
        post(:create, {email: user.email, password: user.password})
      end

      it "sets the session id to the user id" do
        # Given and When
        # (see before do above)
        # Then
        expect(session[:user_id]).to eq(user.id)
      end

      it "redirect to home page" do
        # Given and When
        # (see before do above)
        # Then
        expect(response).to redirect_to(root_path)
      end

      it "sets a flash message" do
        # Given and When
        # (see before do above)
        # Then
        expect(flash[:notice]).to be
      end
    end

    context "with invalid credentials" do
      before do
        # Given
        # (see the 'let(:user)' above)
        # When
        post(:create, {email: user.password, password: user.email})
      end

      it "doesn't set the session id" do
        expect(session[:user_id]).not_to be
      end

      it "renders the new template" do
        expect(response).to render_template(:new)
      end

      it "sets a flash message" do
        expect(flash[:alert]).to be
      end
    end
  end

  # for logging out
  describe "#destroy" do
    before do
      # Given
      login(user)
      # When
      delete :destroy
    end

    it "sets the sessions[:user_id] to nil" do
      # Then
      expect(session[:user_id]).to be_nil
    end

    it "redirect to home page" do
      expect(response).to redirect_to root_path
    end

    it "sets a flash message" do
      expect(flash[:notice]).to be
    end
  end
end
