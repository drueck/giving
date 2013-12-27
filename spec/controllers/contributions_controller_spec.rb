require 'spec_helper'

describe ContributionsController do

  before(:each) do
    @controller.stub(:require_login) { true }
  end

  describe "#index" do
    before(:each) do
      @contribution = FactoryGirl.create(:contribution)
      get :index
    end
    it "should assign a page of decorated contributions to @contributions" do
      expect(assigns(:contributions)).to include(@contribution)
    end
    it "should assign a new contribution for the inline form to @contribution" do
      expect(assigns(:contribution)).to be_a_kind_of(Contribution)
      expect(assigns(:contribution)).not_to be_persisted
    end
    context "with render views on" do
      render_views
      it "should render the index template" do
        expect(response).to render_template(:index)
      end
    end
  end

  describe "#new" do
    before(:each) do
      get :new
    end
    it "should assign a new decorated contribution to @contribution" do
      expect(assigns(:contribution)).to be_a_kind_of(Contribution)
      expect(assigns(:contribution)).not_to be_persisted
      expect(assigns(:contribution)).to be_decorated
    end
    context "with render views on" do
      render_views
      it "should render the new template" do
        expect(response).to render_template(:new)
      end
    end
  end

  describe "#create" do
    context "when the required attributes are supplied" do
      before(:each) do
        @contributor = FactoryGirl.create(:contributor)
        @attrs = { contributor_id: @contributor.id, amount: 9.99,
          date: "12/1/2013" }
      end
      context "regardless of format requested" do
        it "should create the contribution" do
          expect {
            post :create, contribution: @attrs
          }.to change(Contribution, :count).by(1)
          expect(Contribution.last.contributor_id).to eq @contributor.id
        end
      end
      context "when requesting html format" do
        it "should redirect to the contributions index" do
          post :create, contribution: @attrs
          expect(response).to redirect_to(contributions_path)
        end
      end
      context "when requesting js format" do
        before(:each) do
          post :create, contribution: @attrs, format: :js
        end
        it "should assign the first page of decorated contributions to @contributions" do
          expect(assigns(:contributions)).to include(Contribution.first)
          expect(assigns(:contributions)).to be_decorated
        end
        it "should assign a new decorated contribution to @contribution" do
          expect(assigns(:contribution)).to be_a_kind_of(Contribution)
          expect(assigns(:contribution)).not_to be_persisted
        end
        context "with render views on" do
          render_views
          it "should render the create js template" do
            expect(response).to render_template(:create)
          end
        end
      end
    end
    context "when any required attribute is missing" do
      context "regardless of format requested" do
        it "should not create a contribution" do
          expect {
            post :create, contribution: { invalid_param: true }
          }.not_to change(Contribution, :count)
        end
        it "should assign the decorated contribution with errors to @contribution" do
          post :create, contribution: { invalid_param: true }
          expect(assigns(:contribution)).to be_a_kind_of(Contribution)
          expect(assigns(:contribution)).to be_decorated
          expect(assigns(:contribution).errors).not_to be_empty
        end
      end
      context "with render views on" do
        render_views
        context "when requesting html format" do
          it "should render the new template" do
            post :create, contribution: { invalid_param: true }
            expect(response).to render_template(:new)
          end
        end
        context "when requesting js format" do
          it "should render the refresh_form template" do
            post :create, contribution: { invalid_param: true }, format: :js
            expect(response).to render_template(:refresh_form)
          end
        end
      end
    end
  end

  describe "#edit" do
    before(:each) do
      @contribution = FactoryGirl.create(:contribution)
      get :edit, id: @contribution.id
    end
    it "should assign the decorated contribution to @contribution" do
      expect(assigns(:contribution)).to eq @contribution
      expect(assigns(:contribution)).to be_decorated
    end
    context "with render views on" do
      render_views
      it "should render the edit template" do
        expect(response).to render_template(:edit)
      end
    end
  end

  describe "#update" do
    before(:each) do
      @contribution = FactoryGirl.create(:contribution)
    end
    context "when all of the required attributes are present and valid" do
      before(:each) do
        @expected_amount = rand(100..200)
        post :update, id: @contribution.id, contribution: { amount: @expected_amount }
      end
      it "should update the contribution" do
        expect(@contribution.reload.amount).to eq Money.new(@expected_amount * 100)
      end
      it "should redirect to the batch index" do
        expect(response).to redirect_to(contributions_path)
      end
    end
    context "when any required attributes are missing or invalid" do
      before(:each) do
        post :update, id: @contribution.id, contribution: { amount: 0 }
      end
      it "should not update the contribution" do
        expect(@contribution.reload.amount).not_to eq Money.new(0)
      end
      it "should assign the decorated contribution with errors to @contribution" do
        expect(assigns(:contribution)).to eq @contribution
        expect(assigns(:contribution)).to be_decorated
        expect(assigns(:contribution).errors).not_to be_empty
      end
      context "with render views on" do
        render_views
        it "should render the edit template" do
          expect(response).to render_template(:edit)
        end
      end
    end
  end

  describe "#destroy" do
    before(:each) do
      @contribution = FactoryGirl.create(:contribution)
      delete :destroy, id: @contribution.id
    end
    it "should mark the contribution as deleted" do
      expect(Contribution.unscoped.find(@contribution.id).status).to eq "Deleted"
    end
    it "should redirect to the batch contributions index" do
      expect(response).to redirect_to(contributions_path)
    end
  end

end
