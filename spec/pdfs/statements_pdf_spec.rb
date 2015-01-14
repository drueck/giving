require "spec_helper"

describe StatementsPdf do

  describe "#render" do
    context "with one statement for a contributor with one contribution" do
      it "renders a pdf with a nonzero size" do
        contribution = create(:contribution, date: "2014-01-01")
        contributor = contribution.contributor

        statement = Statement.new(contributor, "2014-01-01", "2014-12-31")
        expect(statement.contributions.length).to eq 1

        statements_pdf = StatementsPdf.new(statement)
        rendered_statement = statements_pdf.render
        expect(rendered_statement.size).to be > 0
      end
    end
  end

end
