require 'spec_helper'

describe StatementsController do

  before(:each) do
    @controller.stub(:require_login) { true }
  end

  describe "#new" do
    it "assigns an array of relevant years to @years and renders new" do
      create(:contribution, date: "1999-01-01")
      create(:contribution, date: "2014-01-01")
      create(:contribution, date: "2015-01-01")

      get :new

      expect(assigns(:years)).to match_array((1999..2015).to_a)
      expect(response).to render_template(:new)
    end
  end

  describe "#create" do
    context "when given a year with no contributions" do
      it "adds a flash warning, assigns years, renders new" do
        create(:contribution, date: "2014-01-01")

        post :create, year: 2015

        expect(flash[:warning]).not_to be_nil
        expect(assigns(:years)).to match_array([2014])
        expect(response).to render_template(:new)
      end
    end
    context "given a year with contributions and requesting one pdf" do
      it "responds with a pdf with the expected filename" do
        create(:contribution, date: "2014-01-01")
        create(:contribution, date: "2014-02-01")

        post :create, year: 2014, output_type: "one"
        expect(response.headers["Content-Type"]).to eq "application/pdf"
        expect(response.headers["Content-Disposition"])
          .to eq 'attachment; filename="2014-statements.pdf"'
      end
    end
    context "given a year with contributions and requesting a zip with many pdfs" do
      it "responds with a zip file with the expected filename containing statement pdfs" do
        create(:contribution, date: "2014-01-01")
        create(:contribution, date: "2014-02-01")

        post :create, year: 2014, output_type: "many"
        expect(response.headers["Content-Type"]).to eq "application/zip"
        expect(response.headers["Content-Disposition"])
          .to eq 'attachment; filename="2014-statements.zip"'

        zipfile = response.body
        entry_count = 0
        Zip::InputStream.open(StringIO.new(zipfile)) do |io|
          while(entry = io.get_next_entry)
            expect(entry.name).to end_with(".pdf")
            entry_count += 1
          end
        end
        expect(entry_count).to eq 2
      end
    end
  end

end
