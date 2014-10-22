class BatchesController < ApplicationController

	before_action :require_login

  def index
    @batches = Batch.all.order('created_at desc')
      .paginate(page: params[:page], per_page: 10)
      .decorate
  end

  def new
    @batch = Batch.new
  end

  def create
    @batch = Batch.create(batch_params)
    redirect_to batch_contributions_path(@batch)
  end

  def show
    batch = Batch.find(params[:id]).decorate
    pdf = BatchReport.new(batch)
    send_data pdf.render, pdf_options(batch)
  end

  def edit
    @batch = Batch.find(params[:id]).decorate
  end

  def update
    @batch = Batch.find(params[:id])
    @batch.update(batch_params)
    redirect_to batch_contributions_path(@batch)
  end

  def destroy
    batch = Batch.find(params[:id]).decorate
    batch.mark_deleted
    redirect_to batches_path
  end

  private

  def batch_params
    params.require(:batch).permit(:name, :notes)
  end

  def last_date(batch)
    batch.contributions.last.try(:date)
  end

  def pdf_options(batch)
    { filename: "batch-#{batch.id}.pdf",
      type: "application/pdf",
      disposition: pdf_disposition }
  end

  def pdf_disposition
    params[:d] == 'inline' ? 'inline' : 'attachment'
  end

end
