require 'spec_helper'

describe BatchContributionsController do

  let(:batch) { Batch.create }
  let(:contribution) { create(:contribution, batch_id: batch.id) }

  before(:each) do
    @controller.stub(:require_login) { true }
  end

  describe "#index" do
    before(:each) do
      get :index, batch_id: batch.id
    end
    it "should assign the specified Batch, decorated, to @batch" do
      expect(assigns(:batch)).to eq batch
      expect(assigns(:batch)).to be_decorated
    end
    it "should assign a page of decorated Contributions for that batch to @contributions" do
      expect(assigns(:contributions)).to include(contribution)
    end
    it "should assign a new Contribution for the inline form to @contribution" do
      expect(assigns(:contribution)).to be_a_kind_of(Contribution)
      expect(assigns(:contribution).batch_id).to eq batch.id
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
      get :new, batch_id: batch.id
    end
    it "should assign a new Contribution for the batch to @contribution" do
      expect(assigns(:contribution)).to be_a_kind_of(Contribution)
      expect(assigns(:contribution).batch_id).to eq batch.id
      expect(assigns(:contribution)).not_to be_persisted
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
      let(:contributor) { create(:contributor) }
      let(:attrs) { { batch_id: batch.id, amount: 9.99, date: "12/1/2013" } }
      context "regardless of format requested" do
        it "should create the contribution" do
          post :create, batch_id: batch.id, contribution: attrs,
            contributor_name: contributor.name
          expect(batch.contributions.count).to eq 1
          contribution = batch.contributions.first
          expect(contribution.batch_id).to eq batch.id
          expect(contribution.contributor_id).to eq contributor.id
        end
      end
      context "when requesting html format" do
        it "should redirect to the batch contributions index" do
          post :create, batch_id: batch.id, contribution: attrs,
            contributor_name: contributor.name
          expect(response).to redirect_to(batch_contributions_path)
        end
      end
      context "when requesting js format" do
        before(:each) do
          post :create, batch_id: batch.id, contribution: attrs,
            contributor_name: contributor.name, format: :js
        end
        it "should assign the first page of contributions for the batch to @contributions" do
          expect(assigns(:contributions)).to include(batch.contributions.first)
        end
        it "should assign a new decorated contribution for the batch to @contribution" do
          expect(assigns(:contribution)).to be_a_kind_of(Contribution)
          expect(assigns(:contribution).batch_id).to eq batch.id
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
        before(:each) do
          post :create, batch_id: batch.id, contribution: { invalid_param: true }
        end
        it "should not create a contribution" do
          expect(batch.contributions.count).to eq 0
        end
        it "should assign the decorated contribution with errors to @contribution" do
          expect(assigns(:contribution)).to be_a_kind_of(Contribution)
          expect(assigns(:contribution)).to be_decorated
          expect(assigns(:contribution).errors).not_to be_empty
          expect(assigns(:contribution).batch_id).to eq batch.id
        end
      end
      context "with render views on" do
        render_views
        context "when requesting html format" do
          it "should render the new template" do
            post :create, batch_id: batch.id, contribution: { invalid_param: true }
            expect(response).to render_template(:new)
          end
        end
        context "when requesting js format" do
          it "should render the refresh_form template" do
            post :create, batch_id: batch.id, contribution: { invalid_param: true }, format: :js
            expect(response).to render_template(:refresh_form)
          end
        end
      end
    end
  end

  describe "#edit" do
    before(:each) do
      get :edit, batch_id: batch.id, id: contribution.id
    end
    it "should assign the decorated contribution to @contribution" do
      expect(assigns(:contribution)).to eq contribution
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
    context "when all of the required attributes are present and valid" do
      let(:expected_amount) { rand(100.200) }
      before(:each) do
        post :update, batch_id: batch.id, id: contribution.id,
          contribution: { amount: expected_amount }
      end
      it "should update the contribution" do
        expect(contribution.reload.amount).to eq Money.new(expected_amount * 100)
      end
      it "should redirect to the batch contributions index" do
        expect(response).to redirect_to(batch_contributions_path)
      end
    end
    context "when any required attributes are missing or invalid" do
      before(:each) do
        post :update, batch_id: batch.id, id: contribution.id, contribution: { amount: 0 }
      end
      it "should not update the contribution" do
        expect(contribution.reload.amount).not_to eq Money.new(0)
      end
      it "should assign the decorated contribution with errors to @contribution" do
        expect(assigns(:contribution)).to eq contribution
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
      delete :destroy, batch_id: batch.id, id: contribution.id
    end
    it "should mark the contribution as deleted" do
      expect(Contribution.unscoped.find(contribution.id).status).to eq "Deleted"
    end
    it "should redirect to the batch contributions index" do
      expect(response).to redirect_to(batch_contributions_path)
    end
  end

end
