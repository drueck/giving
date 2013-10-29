class BatchesController < ApplicationController

	before_filter :require_login

  def index
    @batches = Batch.all.order('posted_at desc').paginate(page: params[:page], per_page: 10)
  end

  def show
    @batch = Batch.find(params[:id])
    @contributions = @batch.contributions.order('date, id').paginate(page: params[:page], per_page: 10)
    respond_to do |format|
      format.html
      format.pdf {
        pdf = BatchReport.new(@batch)
        options = {
          filename: "batch-#{@batch.id}.pdf",
          type: "application/pdf"
        }
        if(params[:d] == 'inline')
          options.store(:disposition, 'inline')
        end
        send_data pdf.render, options
      }
    end
  end

end
