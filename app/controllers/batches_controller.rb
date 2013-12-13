class BatchesController < ApplicationController

	before_filter :require_login

  def index
    @batches = Batch.all.order('created_at desc')
      .paginate(page: params[:page], per_page: 10)
      .decorate
  end

  def new
    @batch = Batch.new
  end

  def create
    @batch = Batch.new(batch_params)
    @batch.save
    redirect_to batch_path(@batch)
  end

  def show
    @batch = Batch.find(params[:id]).decorate
    @contribution = Contribution.new(batch_id: @batch.id).decorate
    @contribution.date = last_date(@batch)
    @contributions = @batch.contributions.order('date desc, id desc')
      .paginate(page: params[:page], per_page: 10)
      .decorate
    respond_to do |format|
      format.html
      format.js
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

  def destroy
    batch = Batch.find(params[:id]).decorate
    batch.mark_deleted
    redirect_to batches_path, notice: "#{batch.title} has been marked as deleted"
  end

  private

  def batch_params
    params.require(:batch).permit(:name)
  end

  def last_date(batch)
    batch.contributions.last.try(:date)
  end

end
