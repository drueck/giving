require "spec_helper"

describe BatchesController do

  before(:each) do
    @controller.stub(:require_login) { true }
  end

  describe "#edit" do
    let(:batch) {
      Batch.create(name: "Batch #{rand(1..10)}", notes: "Notes #{rand(1..10)}")
    }
    before(:each) do
      get :edit, id: batch.id
    end
    it "assigns the given batch with the expected attributes to @batch" do
      expect(assigns(:batch).id).to eq batch.id
      expect(assigns(:batch).name).to eq batch.name
      expect(assigns(:batch).notes).to eq batch.notes
      expect(assigns(:batch)).to respond_to(:title)
    end
    context "with render views on" do
      render_views
      it "renders the edit template" do
        expect(response).to render_template(:edit)
      end
    end
  end

  describe "#update" do
    let(:batch) { Batch.create }
    let(:attrs) { { name: "New name #{rand(1..10)}",
                    notes: "New notes #{rand(1..10)}" } }
    before(:each) do
      patch :update, id: batch.id, batch: attrs
    end
    it "updates the given attributes for the specified batch id" do
      batch.reload
      expect(batch.name).to eq attrs[:name]
      expect(batch.notes).to eq attrs[:notes]
    end
    it "redirects to the batch contributions index for the given batch" do
      expect(response).to redirect_to(batch_contributions_path(batch))
    end
  end

end
