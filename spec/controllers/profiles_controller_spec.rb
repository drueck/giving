require "spec_helper"

describe ProfilesController do

  let(:user) { create(:user, user_type: User::STANDARD,
                     password: "originalpassword", password_confirmation: "originalpassword") }

  before(:each) do
    @controller.stub(:require_login) { true }
    @controller.stub(:current_user) { user }
  end

  describe "#edit" do
    it "sets @user to the current user and renders the edit template" do
      get :edit
      expect(assigns(:user)).to eq user
      expect(response).to render_template(:edit)
    end
  end

  describe "#update" do
    context "when the username is present and not a duplicate" do
      it "updates the username and redirects to the main page" do
        patch :update, user: { username: "newusername" }
        expect(user.reload.username).to eq "newusername"
        expect(response).to redirect_to root_url
      end
      context "and when the password and confirmation are supplied and valid" do
        it "updates the password" do
          patch :update, user: { password: "newpassword",
                                 password_confirmation: "newpassword" }
          expect(User.authenticate(user.username, "newpassword")).to be_true
        end
      end
    end
    context "when the username would create a duplicate" do
      it "does not update the username, assigns @user with errors, renders edit" do
        create(:user, username: "duplicateusername")
        patch :update, user: { username: "duplicateusername" }
        expect(user.reload.username).not_to eq "duplicateusername"
        expect(assigns(:user).id).to eq user.id
        expect(assigns(:user).errors[:username]).not_to be_empty
        expect(response).to render_template(:edit)
      end
    end
    context "when the password and confirmation do not match" do
      it "does not update the password, assigns @user with errors, renders edit" do
        patch :update, user: { password: "newpassword", password_confirmation: "wrongconfirmation" }
        expect(User.authenticate(user.username, "originalpassword")).to be_true
        expect(assigns(:user).id).to eq user.id
        expect(assigns(:user).errors[:password_confirmation]).not_to be_empty
        expect(response).to render_template(:edit)
      end
    end
  end

end
